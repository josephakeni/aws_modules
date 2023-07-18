output "alb_hostname" {
  value = join(":", [aws_alb.main.dns_name, var.app_port])
}