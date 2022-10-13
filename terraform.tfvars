project  = "terrateam"
name     = "jerin"
web_name = "resume"

vpc_cidr_block = {
  "default" = "10.0.0.0/16"
  "UAT"          = "10.1.0.0/16"
  "Production"   = "10.2.0.0/16"
}

vpc_subnet_count = {
  "default" = 2
  "UAT"          = 2
  "Production"   = 3
}

instance_type = {
  "default" = "t2.micro"
  "UAT"          = "t2.small"
  "Production"   = "t2.medium"
}

instance_count = {
  "default" = 2
  "UAT"          = 4
  "Production"   = 6
}