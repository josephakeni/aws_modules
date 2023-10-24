###################################
# CloudFront Origin Access Identity
###################################
resource "aws_cloudfront_origin_access_identity" "web" {
  comment = "web"
}

resource "aws_cloudfront_distribution" "website" {
  aliases = ["*.${local.s3_web_domain}"]
  origin {
    domain_name = aws_s3_bucket_website_configuration.web.website_endpoint
    origin_id = aws_s3_bucket.web.bucket

    # You must specify either a CustomOrigin or an S3Origin. You cannot specify both.
    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }

    # s3_origin_config {
    #   origin_access_identity = aws_cloudfront_origin_access_identity.web.cloudfront_access_identity_path
    # }
  }


  enabled             = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = aws_s3_bucket.web.id

    forwarded_values {
      query_string = true

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = var.virginia_acm_certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}
