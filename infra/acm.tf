# module "acm" {
#   source  = "terraform-aws-modules/acm/aws"
#   version = "~> 5.0.1"

#   domain_name  = var.apex_domain
#   #zone_id for the apex zone
#   zone_id      = aws_route53_zone.apex_route53_hosted_zone.id

#   validation_method = "DNS"

#   subject_alternative_names = [
#     "*${var.apex_domain}"
#   ]

#   wait_for_validation = true

# }

resource "aws_acm_certificate" "cert" {
  
  domain_name = var.apex_domain
  subject_alternative_names = ["*.${var.apex_domain}"
  ]
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }

  provider=aws.virginia
}

resource "aws_acm_certificate_validation" "cert-validatation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.apex_route53_record : record.fqdn]
}
