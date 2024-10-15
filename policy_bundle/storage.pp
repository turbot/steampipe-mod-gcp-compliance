locals {
  policy_bundle_storage_common_tags = merge(local.gcp_compliance_common_tags, {
    service = "GCP/Storage"
  })
}

control "require_bucket_policy_only" {
  title = "Check if Cloud Storage buckets have Bucket Only Policy turned on"
  query = query.storage_bucket_bucket_policy_only_enabled

  tags = merge(local.policy_bundle_storage_common_tags, {
    cft_scorecard_v1  = "true"
    hipaa             = "true"
    nist_800_53_rev_5 = "true"
    nist_csf_v10      = "true"
    severity          = "high"
    soc_2_2017        = "true"
  })
}

control "storage_bucket_not_publicly_accessible" {
  title       = "Ensure that Cloud Storage bucket is not anonymously or publicly accessible"
  description = "It is recommended that IAM policy on Cloud Storage bucket does not allows anonymous or public access."
  query       = query.storage_bucket_not_publicly_accessible

  tags = merge(local.policy_bundle_storage_common_tags, {
    nist_800_53_rev_5 = "true"
    nist_csf_v10      = "true"
    pci_dss_v321      = "true"
    soc_2_2017        = "true"
  })
}

control "storage_bucket_uniform_access_enabled" {
  title       = "Ensure that Cloud Storage buckets have uniform bucket-level access enabled"
  description = "It is recommended that uniform bucket-level access is enabled on Cloud Storage buckets."
  query       = query.storage_bucket_uniform_access_enabled

  tags = local.policy_bundle_storage_common_tags
}

control "storage_bucket_log_retention_policy_lock_enabled" {
  title       = "Ensure that Cloud Storage buckets used for exporting logs are configured using bucket lock"
  description = "It is recommended that Cloud Storage buckets used for exporting logs are using bucket lock."
  query       = query.storage_bucket_log_retention_policy_lock_enabled

  tags = merge(local.policy_bundle_storage_common_tags, {
    hipaa             = "true"
    nist_800_53_rev_5 = "true"
    nist_csf_v10      = "true"
    soc_2_2017        = "true"
  })
}

control "storage_bucket_log_retention_policy_enabled" {
  title       = "Ensure that Cloud Storage buckets used for exporting logs have retention policy enabled"
  description = "It is recommended that Cloud Storage buckets used for exporting logs have retention policy enabled."
  query       = query.storage_bucket_log_retention_policy_enabled

  tags = merge(local.policy_bundle_storage_common_tags, {
    pci_dss_v321 = "true"
  })
}

control "storage_bucket_log_object_versioning_enabled" {
  title       = "Ensure that Cloud Storage buckets used for exporting logs have object versioning enabled"
  description = "It is recommended that logging Cloud Storage buckets should have object versioning enabled."
  query       = query.storage_bucket_log_object_versioning_enabled

  tags = merge(local.policy_bundle_storage_common_tags, {
    pci_dss_v321 = "true"
  })
}

control "storage_bucket_log_not_publicly_accessible" {
  title       = "Ensure that Cloud Storage bucket used for exporting logs is not anonymously or publicly accessible"
  description = "It is recommended that IAM policy on Cloud Storage bucket used for exporting logs does not allows anonymous or public access."
  query       = query.storage_bucket_log_not_publicly_accessible

  tags = merge(local.policy_bundle_storage_common_tags, {
    pci_dss_v321 = "true"
  })
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

query "storage_bucket_log_retention_policy_lock_enabled" {
  sql = <<-EOQ
    with log_sink_buckets as (
      select
        split_part(destination, '/', 2) as bucket_name,
        project
      from
        gcp_logging_sink
      where
        destination like 'storage.googleapis.com/%'
    )
    select
      b.self_link resource,
      case
        when s.bucket_name is null then 'skip'
        when b.retention_policy is null then 'alarm'
        when b.retention_policy ->> 'is_locked' = 'true' then 'ok'
        else 'ok'
      end as status,
      case
        when s.bucket_name is null then title || ' does not export logs.'
        when b.retention_policy is null then title || ' retention policy not defined.'
        when b.retention_policy ->> 'is_locked' = 'false'
          then title || ' has retention policy with bucket lock.'
        else title || '  retention policy with no bucket lock.'
      end as reason
      ${replace(local.tag_dimensions_qualifier_sql, "__QUALIFIER__", "b.")}
      ${replace(local.common_dimensions_qualifier_sql, "__QUALIFIER__", "b.")}
    from
      gcp_storage_bucket as b
      left join log_sink_buckets as s on s.bucket_name = b.name and b.project = s.project;
  EOQ
}

query "storage_bucket_log_retention_policy_enabled" {
  sql = <<-EOQ
    with log_sink_buckets as (
      select
        split_part(destination, '/', 2) as bucket_name,
        project
      from
        gcp_logging_sink
      where
        destination like 'storage.googleapis.com/%'
    )
    select
      b.self_link resource,
      case
        when s.bucket_name is null then 'skip'
        when b.retention_policy is not null then 'ok'
        else 'ok'
      end as status,
      case
        when s.bucket_name is null then title || ' does not export logs.'
        when b.retention_policy is not null then title || ' retention policy defined.'
        else title || ' retention policy not defined.'
      end as reason
      ${replace(local.tag_dimensions_qualifier_sql, "__QUALIFIER__", "b.")}
      ${replace(local.common_dimensions_qualifier_sql, "__QUALIFIER__", "b.")}
    from
      gcp_storage_bucket as b
      left join log_sink_buckets as s on s.bucket_name = b.name and b.project = s.project;
  EOQ
}

query "storage_bucket_log_object_versioning_enabled" {
  sql = <<-EOQ
    with log_sink_buckets as (
      select
        split_part(destination, '/', 2) as bucket_name,
        project
      from
        gcp_logging_sink
      where
        destination like 'storage.googleapis.com/%'
    )
    select
      b.self_link resource,
      case
        when s.bucket_name is null then 'skip'
        when b.versioning_enabled then 'ok'
        else 'alarm'
      end as status,
      case
        when s.bucket_name is null then title || ' does not export logs.'
        when b.versioning_enabled then title || ' has object versioning enabled.'
        else title || ' has object versioning disabled.'
      end as reason
      ${replace(local.tag_dimensions_qualifier_sql, "__QUALIFIER__", "b.")}
      ${replace(local.common_dimensions_qualifier_sql, "__QUALIFIER__", "b.")}
    from
      gcp_storage_bucket as b
      left join log_sink_buckets as s on s.bucket_name = b.name and b.project = s.project;
  EOQ
}

query "storage_bucket_log_not_publicly_accessible" {
  sql = <<-EOQ
    with log_sink_buckets as (
      select
        split_part(destination, '/', 2) as bucket_name,
        project
      from
        gcp_logging_sink
      where
        destination like 'storage.googleapis.com/%'
    )
    select
      b.self_link resource,
      case
        when s.bucket_name is null then 'skip'
        when b.iam_policy ->> 'bindings' like any (array ['%allAuthenticatedUsers%','%allUsers%']) then 'alarm'
        else 'ok'
      end as status,
      case
        when s.bucket_name is null then title || ' does not export logs.'
        when b.iam_policy ->> 'bindings' like any (array ['%allAuthenticatedUsers%','%allUsers%']) then title || ' publicly accessible.'
        else title || ' not publicly accessible.'
      end as reason
      ${replace(local.tag_dimensions_qualifier_sql, "__QUALIFIER__", "b.")}
      ${replace(local.common_dimensions_qualifier_sql, "__QUALIFIER__", "b.")}
    from
      gcp_storage_bucket as b
      left join log_sink_buckets as s on s.bucket_name = b.name and b.project = s.project;
  EOQ
}
