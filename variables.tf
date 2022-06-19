
variable "naming_prefix" {
  type = string
  default = "jerin"
  
}


variable "enable_dns_hostnames" {
  type    = bool
  default = true

}

variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"

}

variable "vpc_subnet_count" {
  type = number
  default = 2
  
}

variable "map_public_ip_on_launch" {
  type    = bool
  default = true

}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "web_name" {
  type    = string
  default = "nginx"
}

variable "name" {
  type = string

}

variable "project" {
  type = string
}

