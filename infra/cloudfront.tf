# BLOG
data "aws_cloudfront_cache_policy" "cache-optimized" {
  name = "Managed-CachingOptimized"
}

resource "aws_cloudfront_distribution" "blog_distribution" {

  origin {
    domain_name = aws_s3_bucket_website_configuration.blog_config.website_endpoint
    origin_id   = aws_s3_bucket_website_configuration.blog_config.website_endpoint

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = ""
  default_root_object = "index.html"

  aliases = ["${var.blog_subdomain}"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket_website_configuration.blog_config.website_endpoint
    compress         = true

    viewer_protocol_policy = "redirect-to-https"
    cache_policy_id = data.aws_cloudfront_cache_policy.cache-optimized.id
  }

  viewer_certificate {
    # acm_certificate_arn      = module.acm.acm_certificate_arn
    acm_certificate_arn      = aws_acm_certificate.cert.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2018"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}