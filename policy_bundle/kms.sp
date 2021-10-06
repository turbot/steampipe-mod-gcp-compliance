locals {
  policy_bundle_kms_common_tags = {
    service = "kms"
  }
}

control "cmek_rotation_one_hundred_days" {
  title         = "Check that CMEK rotation policy is in place and is sufficiently short"
  sql           = query.kms_key_rotated_within_100_day.sql

  tags = merge(local.policy_bundle_kms_common_tags, {
    forseti_security_v226   = "true"
    severity                = "high"
  })
}