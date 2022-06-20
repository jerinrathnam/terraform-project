/*variable "aws_access_key" {
  type      = string
  sensitive = true

}
variable "aws_secret_key" {
  type      = string
  sensitive = true

} */
variable "naming_prefix" {
  type    = string
  default = "jerin"

}
variable "instance_count" {
  type = map(number)
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

}

variable "vpc_subnet_count" {
  type = map(number)

}

variable "map_public_ip_on_launch" {
  type    = bool
  default = true

}

variable "instance_type" {
  type = map(string)
}

variable "web_name" {
  type = string
}

variable "name" {
  type = string

}

variable "project" {
  type = string
}

