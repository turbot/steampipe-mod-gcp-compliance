locals {
  policy_bundle_dns_common_tags = merge(local.gcp_compliance_common_tags, {
    service = "GCP/DNS"
  })
}

control "dnssec_prevent_rsasha1_ksk" {
  title = "Ensure that RSASHA1 is not used for key-signing key in Cloud DNS"
  query = query.dns_managed_zone_key_signing_not_using_rsasha1

  tags = merge(local.policy_bundle_dns_common_tags, {
    cft_scorecard_v1 = "true"
    severity         = "high"
  })
}

control "dnssec_prevent_rsasha1_zsk" {
  title = "Ensure that RSASHA1 is not used for zone-signing key in Cloud DNS"
  query = query.dns_managed_zone_zone_signing_not_using_rsasha1

  tags = merge(local.policy_bundle_dns_common_tags, {
    cft_scorecard_v1 = "true"
    severity         = "high"
  })
}

query "dns_managed_zone_key_signing_not_using_rsasha1" {
  sql = <<-EOQ
    select
    -- Required Columns
    self_link resource,
    case
      when visibility = 'private' then 'skip'
      when dnssec_config_state is null then 'alarm'
      when dnssec_config_default_key_specs @> '[{"keyType": "keySigning", "algorithm": "rsasha1"}]' then 'alarm'
      else 'ok'
    end status,
    case
      when visibility = 'private'
        then title || ' is private.'
      when dnssec_config_state is null
        then title || ' DNSSEC not enabled.'
      when dnssec_config_default_key_specs @> '[{"keyType": "keySigning", "algorithm": "rsasha1"}]'
        then title || ' using RSASHA1 algorithm for key-signing.'
      else title || ' not using RSASHA1 algorithm for key-signing.'
    end reason
    -- Additional Dimensions
    ${local.tag_dimensions_sql}
    ${local.common_dimensions_sql}
  from
    gcp_dns_managed_zone;
  EOQ
}

query "dns_managed_zone_zone_signing_not_using_rsasha1" {
  sql = <<-EOQ
    select
    -- Required Columns
    self_link resource,
    case
      when visibility = 'private' then 'skip'
      when dnssec_config_state is null then 'alarm'
      when dnssec_config_default_key_specs @> '[{"keyType": "zoneSigning", "algorithm": "rsasha1"}]' then 'alarm'
      else 'ok'
    end status,
    case
      when visibility = 'private'
        then title || ' is private.'
      when dnssec_config_state is null
        then title || ' DNSSEC not enabled.'
      when dnssec_config_default_key_specs @> '[{"keyType": "zoneSigning", "algorithm": "rsasha1"}]'
        then title || ' using RSASHA1 algorithm for zone-signing.'
      else title || ' not using RSASHA1 algorithm for zone-signing.'
    end reason
    -- Additional Dimensions
    ${local.tag_dimensions_sql}
    ${local.common_dimensions_sql}
  from
    gcp_dns_managed_zone;
  EOQ
}