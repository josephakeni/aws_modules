locals {
  s3_web_filepath = "../s3_web"
  s3_web_domain = join(".", [var.domain_name, var.domain_extension])
}

resource "aws_s3_bucket" "web" {
  bucket = local.s3_web_domain
  tags = {
    Name = var.domain_name
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.web.id
  depends_on = [
    aws_s3_bucket_public_access_block.public_access
  ]

  policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "AllowUserToReadWrite",
        "Effect": "Allow",
        "Principal": {
          "AWS": "*"
        },
        "Action": [
          "s3:GetObject",
          "s3:PutObject"
        ],
        "Resource": "${aws_s3_bucket.web.arn}/*"
      }
    ]
  }
  EOF
}


resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.web.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_object" "web_files" {
  for_each     = fileset(local.s3_web_filepath, "**")
  bucket       = aws_s3_bucket.web.id
  key          = each.key
  source       = "${local.s3_web_filepath}/${each.value}"
  etag         = filemd5("${local.s3_web_filepath}/${each.value}")
  content_type = "text/html"
}

resource "aws_s3_bucket_website_configuration" "web" {
  bucket = aws_s3_bucket.web.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  #   routing_rule {
  #     condition {
  #       key_prefix_equals = "docs/"
  #     }
  #     redirect {
  #       replace_key_prefix_with = "documents/"
  #     }
  #   }
}

