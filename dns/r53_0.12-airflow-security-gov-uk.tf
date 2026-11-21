# dev.airflow.security.gov.uk is a hosted zone in the PLATFORM_DATA_DEV account, created by
# AirflowDnsStack in uk-gov-cyber/airflow-iac.
resource "aws_route53_record" "dev-airflow-delegated-zone" {
  zone_id         = aws_route53_zone.sec-gov-uk.zone_id
  allow_overwrite = true
  name            = "dev.airflow"
  ttl             = local.standard_ttl
  type            = "NS"

  records = [
    "ns-274.awsdns-34.com.",
    "ns-1385.awsdns-45.org.",
    "ns-1548.awsdns-01.co.uk.",
    "ns-952.awsdns-55.net."
  ]
}
