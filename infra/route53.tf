#APEX
resource "aws_route53_zone" "apex_route53_hosted_zone" {
  name         = var.apex_domain
}

resource "aws_route53_record" "apex_route53_record" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 300
  type            = each.value.type
  zone_id         = aws_route53_zone.apex_route53_hosted_zone.zone_id
}

#BLOG
resource "aws_route53_zone" "blog_route53_hosted_zone" {
  name         = var.blog_subdomain
}

resource "aws_route53_record" "blog_route53_record" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 300
  type            = each.value.type
  zone_id         = aws_route53_zone.blog_route53_hosted_zone.zone_id
}

resource aws_route53_record A {
  zone_id = aws_route53_zone.blog_route53_hosted_zone.zone_id
  name    = "${var.blog_subdomain}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.blog_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.blog_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource aws_route53_record AAAA {
  zone_id = aws_route53_zone.blog_route53_hosted_zone.zone_id
  name    = "${var.blog_subdomain}"
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.blog_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.blog_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "blog-ns" {
  zone_id = aws_route53_zone.apex_route53_hosted_zone.zone_id
  name    = "blog.kurtkuhn.me"
  type    = "NS"
  ttl     = "172800"
  records = aws_route53_zone.blog_route53_hosted_zone.name_servers
}
