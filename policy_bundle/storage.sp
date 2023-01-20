locals {
  policy_bundle_storage_common_tags = merge(local.gcp_compliance_common_tags, {
    service = "GCP/Storage"
  })
}

control "require_bucket_policy_only" {
  title = "Check if Cloud Storage buckets have Bucket Only Policy turned on"
  query = query.storage_bucket_bucket_policy_only_enabled

  tags = merge(local.policy_bundle_storage_common_tags, {
    cft_scorecard_v1 = "true"
    severity         = "high"
  })
}