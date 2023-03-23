locals {
  policy_bundle_bigquery_common_tags = merge(local.gcp_compliance_common_tags, {
    service = "GCP/BigQuery"
  })
}

control "require_bq_table_iam" {
  title = "Check if BigQuery datasets are publicly readable"
  query = query.bigquery_dataset_not_publicly_accessible

  tags = merge(local.policy_bundle_bigquery_common_tags, {
    cft_scorecard_v1      = "true"
    forseti_security_v226 = "true"
    severity              = "high"
  })
}

control "restrict_gmail_bigquery_dataset" {
  title = "Enforce corporate domain by banning gmail.com addresses access to BigQuery datasets"
  query = query.bigquery_dataset_restrict_gmail

  tags = merge(local.policy_bundle_bigquery_common_tags, {
    cft_scorecard_v1      = "true"
    forseti_security_v226 = "true"
    severity              = "high"
  })
}

control "restrict_googlegroups_bigquery_dataset" {
  title = "Enforce corporate domain by banning googlegroups.com addresses access to BigQuery datasets"
  query = query.bigquery_dataset_restrict_googlegroups

  tags = merge(local.policy_bundle_bigquery_common_tags, {
    cft_scorecard_v1      = "true"
    forseti_security_v226 = "true"
    severity              = "high"
  })
}

query "bigquery_dataset_not_publicly_accessible" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when access @> '[{"specialGroup": "allAuthenticatedUsers"}]' or access @> '[{"iamMember": "allUsers"}]' then 'alarm'
        else 'ok'
      end as status,
      case
        when access @> '[{"specialGroup": "allAuthenticatedUsers"}]' or access @> '[{"iamMember": "allUsers"}]'
          then title || ' publicly accessible.'
        else title || ' not anonymously or publicly accessible.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_bigquery_dataset;
  EOQ
}

query "bigquery_dataset_restrict_gmail" {
  sql = <<-EOQ
    with dataset_access as (
    select
      distinct dataset_id
      from
      gcp_bigquery_dataset,
      jsonb_array_elements(access) as a
      where
      a ->> 'userByEmail' like '%gmail.com'
    )
    select
        a.dataset_id as resource,
      case
        when b.dataset_id is null then 'ok'
        else 'alarm'
      end as status,
      case
        when b.dataset_id is null
          then a.dataset_id || ' enforces corporate domain by banning gmail.com addresses access.'
        else
        a.dataset_id || ' does not enforce corporate domain by banning gmail.com addresses access.'
      end as reason
      ${replace(local.tag_dimensions_qualifier_sql, "__QUALIFIER__", "a.")}
      ${replace(local.common_dimensions_qualifier_sql, "__QUALIFIER__", "a.")}
    from
      gcp_bigquery_dataset as a
      left join dataset_access as b on a.dataset_id = b.dataset_id;
  EOQ
}

query "bigquery_dataset_restrict_googlegroups" {
  sql = <<-EOQ
    with dataset_access as (
    select
      distinct dataset_id
    from
      gcp_bigquery_dataset,
      jsonb_array_elements(access) as a
      where
      a ->> 'userByEmail' like '%googlegroups.com'
      )
    select
        a.dataset_id as resource,
      case
        when b.dataset_id is null then 'ok'
        else 'alarm'
      end as status,
      case
        when b.dataset_id is null
          then a.dataset_id || ' enforces corporate domain by banning googlegroups.com addresses access.'
        else
        a.dataset_id || ' does not enforce corporate domain by banning googlegroups.com addresses access.'
      end as reason
      ${replace(local.tag_dimensions_qualifier_sql, "__QUALIFIER__", "a.")}
      ${replace(local.common_dimensions_qualifier_sql, "__QUALIFIER__", "a.")}
    from
      gcp_bigquery_dataset as a
      left join dataset_access as b on a.dataset_id = b.dataset_id;
  EOQ
}

# Non-Config rule query

query "bigquery_dataset_encrypted_with_cmk" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when kms_key_name is null then 'alarm'
        else 'ok'
      end as status,
      case
        when kms_key_name is null
          then title || ' encrypted with Google-managed cryptographic keys.'
        else title || ' encrypted with customer-managed encryption keys.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_bigquery_dataset;
  EOQ
}

query "bigquery_table_encrypted_with_cmk" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when kms_key_name is null then 'alarm'
        else 'ok'
      end as status,
      case
        when kms_key_name is null
          then title || ' encrypted with Google managed cryptographic keys.'
        else title || ' encrypted with customer-managed encryption keys.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_bigquery_table;
  EOQ
}
