locals {
  all_controls_organization_common_tags = merge(local.all_controls_common_tags, {
    service = "GCP/Organization"
  })
}

benchmark "all_controls_organization" {
  title       = "Organization"
  description = "This section contains recommendations for configuring Organization resources."
  children = [
    control.organization_essential_contacts_configured
  ]

  tags = merge(local.all_controls_organization_common_tags, {
    type = "Benchmark"
  })
}
