output "load_balance_url" {
  value = "http://${aws_lb.dino-aws-lb.dns_name}"
}
