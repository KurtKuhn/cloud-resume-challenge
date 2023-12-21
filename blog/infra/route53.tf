data "aws_route53_zone" "route53_zone" {
  name = var.site_domain
  private_zone = false
}

resource "aws_route53_record" "route_53_record" {
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
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.route53_zone.zone_id
}

resource aws_route53_record A {
  zone_id = data.aws_route53_zone.route53_zone.zone_id
  name    = "www.${var.site_domain}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.distribution.domain_name
    zone_id                = aws_cloudfront_distribution.distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource aws_route53_record AAAA {
  zone_id = data.aws_route53_zone.route53_zone.zone_id
  name    = "www.${var.site_domain}"
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.distribution.domain_name
    zone_id                = aws_cloudfront_distribution.distribution.hosted_zone_id
    evaluate_target_health = false
  }
}
