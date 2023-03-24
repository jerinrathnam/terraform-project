variable "aws_access_key" {
  type      = string
  sensitive = true

}
variable "aws_secret_key" {
  type      = string
  sensitive = true

} 
variable "naming_prefix" {
  type    = string
  default = "jerin"

}
variable "instance_count" {
  type = map(number)
  default = {
    "Development" = 1
  }
}

variable "aws_region" {
  type    = string
  default = "us-east-1"

}
variable "enable_dns_hostnames" {
  type    = bool
  default = true

}

variable "vpc_cidr_block" {
  type = map(string)
  default = {
    "Development" = "10.0.0.0/16"
    }
}

variable "vpc_subnet_count" {
  type = map(number)
  default = {
    "Development" = 2

}

variable "map_public_ip_on_launch" {
  type    = bool
  default = true

}

variable "instance_type" {
  type = map(string)
  default = {
    "Development" = "t2.micro"
    }
}

variable "web_name" {
  type = string
  default = {
    "Development" = "myweb"
    }
}

variable "name" {
  type = string
  default = {
    "Development" = "jerin"
    }
}

variable "project" {
  type = string
  default = {
    "Development" = "terraform"
    }
}

