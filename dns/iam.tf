#############
  # IAM
#############

resource "aws_iam_role" "admin_role" {
  name = "bootstrap"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          AWS = [
            "arn:aws:iam::622626885786:user/madhuri.nethi1@digital.cabinet-office.gov.uk",
            "arn:aws:iam::622626885786:user/paul.hallam@digital.cabinet-office.gov.uk"
          ]
        },
        Action = "sts:AssumeRole",
        Condition = {
          Bool = {
            "aws:MultiFactorAuthPresent" = "true"
          }
        }
      }
    ]
  })

  tags = {
     "Service" : "security.gov.uk",
    "Reference" : "https://github.com/co-cddo/security.gov.uk-iac",
  }
}

resource "aws_iam_role_policy_attachment" "admin_attach" {
  role       = aws_iam_role.admin_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}