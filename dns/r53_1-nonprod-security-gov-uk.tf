resource "aws_route53_zone" "np-sec-gov-uk" {
  name = local.nonprod_domain

  tags = merge(local.default_tags, {
    "Name" : local.nonprod_domain,
    "Environment" : "nonprod"
  })

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_route53_record" "security_txt" {
  zone_id = aws_route53_zone.np-sec-gov-uk.zone_id
  name    = "_security"
  type    = "TXT"
  ttl     = local.standard_ttl

  records = [
    "security_policy=https://vulnerability-reporting.service.security.gov.uk/.well-known/security.txt",
    "security_contact=https://vulnerability-reporting.service.security.gov.uk/submit",
    "security_contact=mailto:vulnerability-reporting@cabinetoffice.gov.uk"
  ]
}

module "np-aws-r53-parked-domain" {
  source            = "github.com/co-cddo/aws-route53-parked-govuk-domain//terraform?ref=5e85556ce417cd335c440fd1e7079bd331f443d5"
  zone_id           = aws_route53_zone.np-sec-gov-uk.zone_id
  depends_on        = [aws_route53_zone.np-sec-gov-uk]
  email_records     = true  # default
  webserver_records = false # default
  additional_txt_records = [
    "google-site-verification=3EQRZEbgFr5cq9w3guznHUPnU_S7MQyDsQ_CuVCSpEM",
    "security_policy=https://vulnerability-reporting.service.security.gov.uk/.well-known/security.txt"
  ]
}

resource "aws_route53_record" "keycloak-nonprod-delegated-zone" {
  zone_id         = aws_route53_zone.np-sec-gov-uk.zone_id
  allow_overwrite = true
  name            = "keycloak.nonprod-service"
  ttl             = local.standard_ttl
  type            = "NS"

  records = [
    "ns-754.awsdns-30.net.",
    "ns-1416.awsdns-49.org.",
    "ns-1681.awsdns-18.co.uk.",
    "ns-66.awsdns-08.com."
  ]
}

resource "aws_route53_record" "cape-nonprod-delegated-zone" {
  zone_id         = aws_route53_zone.np-sec-gov-uk.zone_id
  allow_overwrite = true
  name            = "cape.nonprod-service"
  ttl             = local.standard_ttl
  type            = "NS"

  records = [
    "ns-716.awsdns-25.net.",
    "ns-1224.awsdns-25.org.",
    "ns-1816.awsdns-35.co.uk.",
    "ns-429.awsdns-53.com."
  ]
}
