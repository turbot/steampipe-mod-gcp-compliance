benchmark "nist_800_53_rev_5_ir" {
  title       = "Incident Response (IR)"
  description = "IR controls are specific to an organization’s incident response policies and procedures. This includes incident response training, testing, monitoring, reporting, and response plan."
  children = [
    benchmark.nist_800_53_rev_5_ir_6
  ]

  tags = local.nist_800_53_rev_5_common_tags
}

benchmark "nist_800_53_rev_5_ir_6" {
  title       = "Incident Reporting (IR-6)"
  description = "Requires personnel to report suspected security incidents to the organizational incident response capability within Assignment: organization-defined time period; and reports security incident information to Assignment: organization-defined authorities."
  children = [
    control.organization_essential_contacts_configured
  ]

  tags = local.nist_800_53_rev_5_common_tags
}