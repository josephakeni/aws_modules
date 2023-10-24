

output "aws_s3_bucket_endpoint" {
  value = aws_s3_bucket_website_configuration.web.website_endpoint
}

output "cloudfront_distribution_domain_name" {
  value = aws_cloudfront_distribution.website.domain_name
}

output "aws_route53_record_domain_url" {
  value = aws_route53_record.web_cal.fqdn
}
