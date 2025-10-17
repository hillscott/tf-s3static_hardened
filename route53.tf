# Create Route53 records for the CloudFront distribution aliases
resource "aws_route53_zone" "route53_domain" {
  name = var.domain_name
  tags = var.common_tags
}
# tflint-ignore: terraform_required_providers
resource "null_resource" "show_ns_servers" {
  # Force the resource to run after the zone exists.
  depends_on = [aws_route53_zone.route53_domain]

  triggers = {
    ns = join(",", aws_route53_zone.route53_domain.name_servers)
  }

  provisioner "local-exec" {
    # Show the user what they need to do now that the zone exists...
    command = "echo \"NOTICE!!!\"; echo \"NAME SERVERS:\"; echo \"${self.triggers.ns}\"; echo \"The Above Route53 Name Servers must now be set in your name registrar.\"; echo \"The deployment will continue once resolution succeeds.\""
  }
}
resource "aws_route53_record" "domain_validate" {
  for_each = {
    for dvo in aws_acm_certificate.web_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  allow_overwrite = true
  zone_id         = aws_route53_zone.route53_domain.zone_id
  name            = each.value.name
  records         = [each.value.record]
  type            = each.value.type
  ttl             = 300
}

resource "aws_route53_record" "cf_distro" {
  for_each = aws_cloudfront_distribution.website_cf.aliases
  zone_id  = aws_route53_zone.route53_domain.zone_id
  name     = each.value
  type     = "A"

  alias {
    name                   = aws_cloudfront_distribution.website_cf.domain_name
    zone_id                = aws_cloudfront_distribution.website_cf.hosted_zone_id
    evaluate_target_health = false
  }
}
