resource "aws_instance" "nginx" {
  count                  = var.instance_count[terraform.workspace]
  ami                    = "ami-065efef2c739d613b"
  instance_type          = var.instance_type[terraform.workspace]
  subnet_id              = module.vpc.public_subnets[(count.index % var.vpc_subnet_count[terraform.workspace])]
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]
  user_data = templatefile("${path.module}/template.tpl", {
    s3_bucket_name = module.web_app_s3.web_bucket.id
  })

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-web-${count.index}"
  })
  depends_on = [
    module.web_app_s3
  ]
  iam_instance_profile = module.web_app_s3.instance_profile.name
}
