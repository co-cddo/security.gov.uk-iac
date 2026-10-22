resource "aws_route53_record" "hbc-email-records" {
  # These records are for enabling Outlook email addresses on hbc.security.gov.uk
  zone_id         = aws_route53_zone.sec-gov-uk.zone_id
  allow_overwrite = true
  name            = "hbc"
  ttl             = local.standard_ttl
  type            = "TXT"

  records = [
    "v=spf1 include:spf.protection.outlook.com -all",
    "v=DMARC1; p=reject; fo=1; pct=100; rua=mailto:DMARC-ics@ics.gov.uk,mailto:dmarc-rua@dmarc.service.gov.uk; ruf=mailto:DMARC-ics@ics.gov.uk"
  ]
}
