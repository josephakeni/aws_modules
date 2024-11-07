data "aws_route53_zone" "selected" {
  name         = var.zone_name 
  private_zone = false
}
# resource "aws_route53_zone" "main" {
#   name = var.domain_name
# }

# Route 53 Record
resource "aws_route53_record" "main" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = var.record_name 
  type    = var.record_type
  ttl     = var.ttl
  records = var.records
}

# ACM Certificate for HTTPS
resource "aws_acm_certificate" "main_cert" {
  domain_name       = var.web_domain
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

# Route 53 Validation Records for ACM using for_each
resource "aws_route53_record" "validation" {
  for_each = { for dvo in aws_acm_certificate.main_cert.domain_validation_options : dvo.domain_name => dvo }
  
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = each.value.resource_record_name
  type    = each.value.resource_record_type
  records = [each.value.resource_record_value]
  ttl     = 60
}

# ACM Certificate Validation Resource
resource "aws_acm_certificate_validation" "main_cert_validation" {
  certificate_arn = aws_acm_certificate.main_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.validation : record.fqdn]
}