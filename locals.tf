locals {
  common_tags = {
    web_name = var.web_name
    #name     = "${var.name}-${var.web_name}"
    project  = var.project
  }
  s3_bucket_name = lower("${local.name_prefix}-${random_integer.rand.result}")  
  name_prefix = "${var.naming_prefix}-dev"
}

resource "random_integer" "rand" {
  min = 20000
  max = 99999
}

