locals {
  policy_bundle_kms_common_tags = merge(local.gcp_compliance_common_tags, {
    service = "GCP/KMS"
  })
}

control "cmek_rotation_one_hundred_days" {
  title = "Check that CMEK rotation policy is in place and is sufficiently short"
  query = query.kms_key_rotated_within_100_day

  tags = merge(local.policy_bundle_kms_common_tags, {
    forseti_security_v226 = "true"
    severity              = "high"
  })
}

query "kms_key_rotated_within_100_day" {
  sql = <<-EOQ
    select
      -- Required Columns
      self_link as resource,
      case
        when split_part(rotation_period, 's', 1) :: int <= 8640000 then 'ok'
        else 'alarm'
      end as status,
      case
        when rotation_period is null then title || ' in ' || key_ring_name || ' requires manual rotation.'
        else key_ring_name || ' ' || title || ' rotation period set for ' || (split_part(rotation_period, 's', 1) :: int)/86400 || ' day(s).'
      end as reason
      -- Additional Dimensions
    ${local.tag_dimensions_sql}
    ${local.common_dimensions_sql}
    from
      gcp_kms_key;
  EOQ
}
