  # These records are for enabling Outlook email addresses on hbc.security.gov.uk

resource "aws_route53_record" "hbc-TXT-records" {
  zone_id         = aws_route53_zone.sec-gov-uk.zone_id
  allow_overwrite = true
  name            = "hbc"
  ttl             = local.standard_ttl
  type            = "TXT"

  records = [
    "v=spf1 include:spf.protection.outlook.com -all",
    "v=DMARC1; p=reject; fo=1; pct=100; rua=mailto:DMARC-ics@ics.gov.uk,mailto:dmarc-rua@dmarc.service.gov.uk; ruf=mailto:DMARC-ics@ics.gov.uk",
    "MS=ms81320579"
  ]
}


resource "aws_route53_record" "hbc-MX-records" {
  zone_id         = aws_route53_zone.sec-gov-uk.zone_id
  allow_overwrite = true
  name            = "hbc"
  ttl             = local.standard_ttl
  type            = "MX"

  records = [
    "0 hbc-security-gov-uk.mail.protection.outlook.com"
  ]
}


resource "aws_route53_record" "hbc-autodiscover-CNAME-record" {
  zone_id         = aws_route53_zone.sec-gov-uk.zone_id
  allow_overwrite = true
  name            = "autodiscover.hbc"
  ttl             = local.standard_ttl
  type            = "CNAME"

  records = [
    "hbc-security-gov-uk.mail.protection.outlook.com"
  ]
}

resource "aws_route53_record" "hbc-domainkey1-CNAME-records" {
  zone_id         = aws_route53_zone.sec-gov-uk.zone_id
  allow_overwrite = true
  name            = "selector1._domainkey.hbc"
  ttl             = local.standard_ttl
  type            = "CNAME"

  records = [
    "selector1-hbc-security-gov-uk._domainkey.beisgov.r-v1.dkim.mail.microsoft"
  ]
}

resource "aws_route53_record" "hbc-domainkey2-CNAME-records" {
  zone_id         = aws_route53_zone.sec-gov-uk.zone_id
  allow_overwrite = true
  name            = "selector2._domainkey.hbc"
  ttl             = local.standard_ttl
  type            = "CNAME"

  records = [
    "selector2-hbc-security-gov-uk._domainkey.beisgov.r-v1.dkim.mail.microsoft"
  ]
}
