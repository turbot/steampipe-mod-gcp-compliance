locals {
  all_controls_storage_common_tags = merge(local.all_controls_common_tags, {
    service = "GCP/Storage"
  })
}

benchmark "all_controls_storage" {
  title       = "Storage"
  description = "This section contains recommendations for configuring Storage resources."
  children = [
    control.require_bucket_policy_only,
    control.storage_bucket_log_retention_policy_lock_enabled,
    control.storage_bucket_not_publicly_accessible,
    control.storage_bucket_uniform_access_enabled,
    control.storage_bucket_log_retention_policy_enabled,
  ]

  tags = merge(local.all_controls_storage_common_tags, {
    type = "Benchmark"
  })
}
