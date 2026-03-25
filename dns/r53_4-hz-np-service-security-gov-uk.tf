resource "aws_route53_zone" "np-service-security-gov-uk" {
  name = local.np_service

  tags = merge(local.default_tags, {
    "Name" : local.np_service,
    "Environment" : "nonprod"
  })

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_route53_record" "security_txt-service" {
  zone_id = aws_route53_zone.np-service-security-gov-uk.zone_id
  name    = "_security"
  type    = "TXT"
  ttl     = local.standard_ttl

  records = [
    "security_policy=https://vulnerability-reporting.service.security.gov.uk/.well-known/security.txt",
    "security_contact=https://vulnerability-reporting.service.security.gov.uk/submit",
    "security_contact=mailto:vulnerability-reporting@cabinetoffice.gov.uk"
  ]
}

module "np-service-aws-r53-parked-domain" {
  source            = "github.com/co-cddo/aws-route53-parked-govuk-domain//terraform?ref=5e85556ce417cd335c440fd1e7079bd331f443d5"
  zone_id           = aws_route53_zone.np-service-security-gov-uk
  depends_on        = [aws_route53_zone.np-service-security-gov-uk]
  email_records     = true  # default
  webserver_records = false # default
  additional_txt_records = [
    "google-site-verification=3EQRZEbgFr5cq9w3guznHUPnU_S7MQyDsQ_CuVCSpEM",
    "security_policy=https://vulnerability-reporting.service.security.gov.uk/.well-known/security.txt"
  ]
}
