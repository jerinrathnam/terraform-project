resource "aws_s3_bucket" "web_bucket" {
  bucket        = local.s3_bucket_name
  acl           = "private"
  force_destroy = true
  policy        = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Principal": {
        "AWS": "${data.aws_elb_service_account.root.arn}"
      },
      "Resource": "arn:aws:s3:::${local.s3_bucket_name}/alb-logs/*"
    },
    {
      "Action": [
        "s3:PutObject"
      ],
      "Principal": {
        "Service": "delivery.logs.amazonaws.com"
      },
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::${local.s3_bucket_name}/alb-logs/*"
      ],
      "Condition": {
        "StringEquals": {
          "s3:x-amz-acl": "bucket-owner-full-control"
        }
      }
    },
    {
      "Action": [
        "s3:GetBucketAcl"
      ],
      "Principal": {
        "Service": "delivery.logs.amazonaws.com"
      },
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${local.s3_bucket_name}"
    }
  ]
}
    POLICY


  tags = local.common_tags
}

resource "aws_s3_bucket_object" "object1" {
  bucket = aws_s3_bucket.web_bucket.bucket
  key    = "/website/index.html"
  source = "./website/index.html"

  tags = local.common_tags
}

resource "aws_s3_bucket_object" "object2" {
  bucket = aws_s3_bucket.web_bucket.bucket
  key    = "/website/Polish_20220517_223858461.png"
  source = "./website/Polish_20220517_223858461.png"

  tags = local.common_tags
}


resource "aws_iam_role_policy" "nginx_policy" {
  name = "jerin-nginx-s3-policy"
  role = aws_iam_role.allow_nginx_s3.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*",
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::${local.s3_bucket_name}",
          "arn:aws:s3:::${local.s3_bucket_name}/*"
        ]
      },
    ]
  })
}

resource "aws_iam_role" "allow_nginx_s3" {
  name = "jerin-nginx-s3"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_instance_profile" "nginx_profile" {
  name = "jerin-nginx-profile"  
  role = aws_iam_role.allow_nginx_s3.name
  tags = local.common_tags
}
