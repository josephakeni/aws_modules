data "aws_route53_zone" "selected" {
  name         = local.s3_web_domain
  private_zone = false
}

resource "aws_route53_record" "web_cal" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = var.sub_domain
  type    = "CNAME"
  records = ["${aws_cloudfront_distribution.website.domain_name}"]
  ttl     = var.ttl
}
