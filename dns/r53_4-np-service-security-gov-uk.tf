resource "aws_route53_record" "keycloak-np-service-security-zone" {
  zone_id         = aws_route53_zone.np-service-security-gov-uk.zone_id
  allow_overwrite = true
  name            = "keycloak.nonprod-service"
  ttl             = local.standard_ttl
  type            = "NS"

  records = [
    "ns-620.awsdns-13.net.",
    "ns-326.awsdns-40.com.",
    "ns-1137.awsdns-14.org.",
    "ns-2038.awsdns-62.co.uk."
  ]
}

resource "aws_route53_record" "assemblyline-np-service-security-zone" {
  zone_id         = aws_route53_zone.np-service-security-gov-uk.zone_id
  allow_overwrite = true
  name            = "assemblyline.nonprod-service"
  ttl             = local.standard_ttl
  type            = "NS"

  records = [
    "ns-1.awsdns-1.net.",
    "ns-2.awsdns-2.com.",
    "ns-3.awsdns-3.org.",
    "ns-4.awsdns-4.co.uk."
  ]
}

resource "aws_route53_record" "checking-np-service-security-zone" {
  zone_id         = aws_route53_zone.np-service-security-gov-uk.zone_id
  allow_overwrite = true
  name            = "checking.nonprod-service"
  ttl             = local.standard_ttl
  type            = "NS"

  records = [
    "ns-1.awsdns-5.net.",
    "ns-2.awsdns-6.com.",
    "ns-3.awsdns-7.org.",
    "ns-4.awsdns-8.co.uk."
  ]
}