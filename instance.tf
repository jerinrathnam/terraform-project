resource "aws_instance" "nginx" {
  count = var.vpc_subnet_count
  ami                    = "ami-0b0ea68c435eb488d"
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.subnets[(count.index % var.vpc_subnet_count)].id
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]
  user_data              = templatefile("${path.module}/template.tpl", {
    s3_bucket_name = aws_s3_bucket.web_bucket.id
  })

  tags                 = merge(local.common_tags, {
    Name = "${local.name_prefix}-web"
  })
  depends_on = [
    aws_iam_role_policy.nginx_policy
  ]
  iam_instance_profile = aws_iam_instance_profile.nginx_profile.name
}
