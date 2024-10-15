locals {
  all_controls_resourcemanager_common_tags = merge(local.all_controls_common_tags, {
    service = "GCP/ResourceManager"
  })
}

benchmark "all_controls_resourcemanager" {
  title       = "Resource Manager"
  description = "This section contains recommendations for configuring Resource Manager resources."
  children = [
    control.audit_logging_configured_for_all_service
  ]

  tags = merge(local.all_controls_resourcemanager_common_tags, {
    type = "Benchmark"
  })
}
