output "elb_dns" {
  value = aws_lb.web.dns_name
}