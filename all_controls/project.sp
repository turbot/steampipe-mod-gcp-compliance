locals {
  all_controls_project_common_tags = merge(local.all_controls_common_tags, {
    service = "GCP/Project"
  })
}

benchmark "all_controls_project" {
  title       = "Project"
  description = "This section contains recommendations for configuring Project resources."
  children = [
    control.project_access_approval_settings_enabled,
    control.project_service_cloudasset_api_enabled
  ]

  tags = merge(local.all_controls_project_common_tags, {
    type = "Benchmark"
  })
}
