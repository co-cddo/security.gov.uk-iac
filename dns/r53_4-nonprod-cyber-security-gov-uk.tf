resource "aws_route53_zone" "cyber-nonprod-gov-uk" {
  name = local.nonprod_cyber

  tags = merge(local.default_tags, {
    "Name" : local.nonprod_cyber,
    "Environment" : "nonprod"
  })

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_route53_record" "keycloak-nonprod-delegated-zone" {
  zone_id         = aws_route53_zone.cyber-nonprod-gov-uk.zone_id
  allow_overwrite = true
  name            = "keycloak.nonprod.security"
  ttl             = local.standard_ttl
  type            = "NS"

  records = [
    "ns-435.awsdns-54.com.",
    "ns-1278.awsdns-31.org.",
    "ns-1613.awsdns-09.co.uk.",
    "ns-963.awsdns-56.net.",
  ]
}

resource "aws_route53_record" "assemblyline-nonprod-delegated-zone" {
  zone_id         = aws_route53_zone.sec-gov-uk.zone_id
  allow_overwrite = true
  name            = "assemblyline.nonprod-service"
  ttl             = local.standard_ttl
  type            = "NS"

  records = [
    "ns-620.awsdns-13.net.",
    "ns-326.awsdns-40.com.",
    "ns-1137.awsdns-14.org.",
    "ns-2038.awsdns-62.co.uk."
  ]
}
