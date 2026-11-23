# security.gov.uk-iac

security.gov.uk - Infrastructure as Code

![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Terraform Version v1.12.1](https://img.shields.io/badge/Terraform-v1.12.1-blueviolet?style=for-the-badge&logo=terraform)
![Last commit image](https://img.shields.io/github/last-commit/cabinetoffice/security.gov.uk-iac?style=for-the-badge&logo=github)

Infrastructure as code (Terraform) for the security.gov.uk domain on AWS Route53.

## Naming standard for AWS account services

Each service hosted in our AWS accounts gets one name per environment:

| Account environment | Name | Example (Airflow) | Delegated in |
| --- | --- | --- | --- |
| `*_DEV` | `<service>.nonprod.security.gov.uk` | `airflow.nonprod.security.gov.uk` | `dns/r53_1-nonprod-security-gov-uk.tf` |
| `*_PROD` | `<service>.service.security.gov.uk` | `airflow.service.security.gov.uk` | `dns/r53_2-service-security-gov-uk.tf` |

- Each name is a Route 53 hosted zone in the account that runs the service, e.g.
  `airflow.nonprod.security.gov.uk` in `PLATFORM_DATA_DEV`. The service's infrastructure code
  creates the zone, and this repository delegates it with an NS record built from the zone's
  name servers.
- The service name must be unique across all accounts in that environment. Check the
  delegation file for the environment before choosing one.
- Staging accounts aren't covered yet. Agree a name here before the first one needs a domain.

Names that predate this standard, e.g. `*.nonprod-service`, `gc3-staging` and `beta-dev`, are
left as they are.
