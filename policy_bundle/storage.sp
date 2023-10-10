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

control "storage_bucket_not_publicly_accessible" {
  title         = "Ensure that Cloud Storage bucket is not anonymously or publicly accessible"
  description   = "It is recommended that IAM policy on Cloud Storage bucket does not allows anonymous or public access."
  query = query.storage_bucket_not_publicly_accessible

  tags = local.policy_bundle_storage_common_tags
}

control "storage_bucket_uniform_access_enabled" {
  title         = "Ensure that Cloud Storage buckets have uniform bucket-level access enabled"
  description   = "It is recommended that uniform bucket-level access is enabled on Cloud Storage buckets."
  query = query.storage_bucket_uniform_access_enabled

  tags = local.policy_bundle_storage_common_tags
}

query "storage_bucket_bucket_policy_only_enabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when iam_configuration_bucket_policy_only_enabled then 'ok'
        else 'alarm'
      end as status,
      case
        when iam_configuration_bucket_policy_only_enabled
          then title || ' bucket only policy turned on.'
        else title || ' bucket only policy turned off'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_storage_bucket;
  EOQ
}

# Non-Config rule query

query "storage_bucket_not_publicly_accessible" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when iam_policy ->> 'bindings' like any (array ['%allAuthenticatedUsers%','%allUsers%']) then 'alarm'
        else 'ok'
      end as status,
      case
        when iam_policy ->> 'bindings' like any (array ['%allAuthenticatedUsers%','%allUsers%'])
          then title || ' publicly accessible.'
        else title || ' not publicly accessible.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_storage_bucket;
  EOQ
}

query "storage_bucket_uniform_access_enabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when iam_configuration_uniform_bucket_level_access_enabled then 'ok'
        else 'alarm'
      end as status,
      case
        when iam_configuration_uniform_bucket_level_access_enabled
          then title || ' uniform bucket-level access enabled.'
        else title || ' uniform bucket-level access not enabled.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_storage_bucket;
  EOQ
}
