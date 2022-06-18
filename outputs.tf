output "loadbalancer_dns" {
  value = aws_lb.nginx.dns_name
}