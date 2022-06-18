resource "aws_instance" "nginx1" {
  ami                    = "	ami-0b0ea68c435eb488d"
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.subnet1.id
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]
  user_data              = <<EOF
    #! /bin/bash
    sudo amazon-linux-extras install -y nginx1
    sudo service nginx start
    aws s3 cp s3://${aws_s3_bucket.web_bucket.id}/website/index.html /home/ec2-user/index.html
    aws s3 cp s3://${aws_s3_bucket.web_bucket.id}/website/Polish_20220517_223858461.png /home/ec2-user/Polish_20220517_223858461.png
    sudo rm /usr/share/nginx/html/index.html
    cp /home/ec2-user/index.html /usr/share/nginx/html/index.html
    cp /home/ec2-user/Polish_20220517_223858461.png  /usr/share/nginx/html/Polish_20220517_223858461.png
    EOF
  tags                   = local.common_tags
  depends_on = [
    aws_iam_role_policy.nginx_policy
  ]
  iam_instance_profile = aws_iam_instance_profile.nginx_profile.name
}

resource "aws_instance" "nginx2" {
  ami                    = "	ami-0b0ea68c435eb488d"
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.subnet2.id
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]
  user_data              = <<EOF
    #! /bin/bash
    sudo amazon-linux-extras install -y nginx1
    sudo service nginx start
    aws s3 cp s3://${aws_s3_bucket.web_bucket.id}/website/index.html /home/ec2-user/index.html
    aws s3 cp s3://${aws_s3_bucket.web_bucket.id}/website/Polish_20220517_223858461.png /home/ec2-user/Polish_20220517_223858461.png
    sudo rm /usr/share/nginx/html/index.html
    cp /home/ec2-user/index.html /usr/share/nginx/html/index.html
    cp /home/ec2-user/Polish_20220517_223858461.png  /usr/share/nginx/html/Polish_20220517_223858461.png
    EOF
  tags                   = local.common_tags
  depends_on = [
    aws_iam_role_policy.nginx_policy
  ]
  iam_instance_profile = aws_iam_instance_profile.nginx_profile.name
}