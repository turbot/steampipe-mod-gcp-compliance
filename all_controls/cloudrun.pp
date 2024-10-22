locals {
  all_controls_cloudrun_common_tags = merge(local.all_controls_common_tags, {
    service = "GCP/CloudRun"
  })
}

benchmark "all_controls_cloudrun" {
  title       = "Cloud Run"
  description = "This section contains recommendations for configuring Cloud Run resources."
  children = [
    control.cloudrun_service_restrict_public_access
  ]

  tags = merge(local.all_controls_cloudrun_common_tags, {
    type = "Benchmark"
  })
}
