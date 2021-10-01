locals {
  control_library_storage_common_tags = {
    service = "storage"
  }
}

control "require_bucket_policy_only" {
  title         = "Check if Cloud Storage buckets have Bucket Only Policy turned on"
  sql           = query.storage_bucket_bucket_policy_only_enabled.sql

  tags = merge(local.cft_scorecard_common_tags, {
    cft_scorecard_v1   = "true"
    severity           = "high"
  })
}