resource "aws_s3_bucket" "web_bucket" {
  bucket        = var.bucket_name
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
        "AWS": "${var.elb_service_account_arn}"
      },
      "Resource": "arn:aws:s3:::${var.bucket_name}/alb-logs/*"
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
        "arn:aws:s3:::${var.bucket_name}/alb-logs/*"
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
      "Resource": "arn:aws:s3:::${var.bucket_name}"
    }
  ]
}
    POLICY


  tags = var.common_tags
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
          "arn:aws:s3:::${var.bucket_name}",
          "arn:aws:s3:::${var.bucket_name}/*"
        ]
      },
    ]
  })
}

resource "aws_iam_role" "allow_nginx_s3" {
  name = "${var.bucket_name}-jerin-nginx-s3"
  tags = var.common_tags
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

resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.bucket_name}-jerin-ins-profile"
  role = aws_iam_role.allow_nginx_s3.name
}
