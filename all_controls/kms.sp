locals {
  all_controls_kms_common_tags = merge(local.all_controls_common_tags, {
    service = "GCP/KMS"
  })
}

benchmark "all_controls_kms" {
  title       = "KMS"
  description = "This section contains recommendations for configuring KMS resources."
  children = [
    control.cmek_rotation_one_hundred_days,
    control.kms_key_not_publicly_accessible,
    control.kms_key_rotated_within_90_day,
    control.kms_key_separation_of_duties_enforced

  ]

  tags = merge(local.all_controls_kms_common_tags, {
    type = "Benchmark"
  })
}
