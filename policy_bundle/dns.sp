locals {
  policy_bundle_dns_common_tags = merge(local.gcp_compliance_common_tags, {
    service = "GCP/DNS"
  })
}

control "dnssec_prevent_rsasha1_ksk" {
  title = "Ensure that RSASHA1 is not used for key-signing key in Cloud DNS"
  query = query.dns_managed_zone_key_signing_not_using_rsasha1

  tags = merge(local.policy_bundle_dns_common_tags, {
    cft_scorecard_v1  = "true"
    nist_800_53_rev_5 = "true"
    nist_csf_v10      = "true"
    severity          = "high"
    soc_2_2017        = "true"
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

control "dns_managed_zone_dnssec_enabled" {
  title       = "Ensure that DNSSEC is enabled for Cloud DNS"
  description = "Cloud Domain Name System (DNS) is a fast, reliable, and cost-effective domain name system that powers millions of domains on the internet. Domain Name System Security Extensions (DNSSEC) in Cloud DNS enables domain owners to take easy steps to protect their domains against DNS hijacking and man-in-the-middle and other attacks."
  query       = query.dns_managed_zone_dnssec_enabled

  tags = merge(local.policy_bundle_dns_common_tags, {
    nist_800_53_rev_5 = "true"
    nist_csf_v10      = "true"
    soc_2_2017        = "true"
  })
}

query "dns_managed_zone_key_signing_not_using_rsasha1" {
  sql = <<-EOQ
    select
    self_link resource,
    case
      when visibility = 'private' then 'skip'
      when dnssec_config_state is null then 'alarm'
      when dnssec_config_default_key_specs @> '[{"keyType": "keySigning", "algorithm": "rsasha1"}]' then 'alarm'
      else 'ok'
    end as status,
    case
      when visibility = 'private'
        then title || ' is private.'
      when dnssec_config_state is null
        then title || ' DNSSEC not enabled.'
      when dnssec_config_default_key_specs @> '[{"keyType": "keySigning", "algorithm": "rsasha1"}]'
        then title || ' using RSASHA1 algorithm for key-signing.'
      else title || ' not using RSASHA1 algorithm for key-signing.'
    end as reason
    ${local.tag_dimensions_sql}
    ${local.common_dimensions_global_sql}
  from
    gcp_dns_managed_zone;
  EOQ
}

query "dns_managed_zone_zone_signing_not_using_rsasha1" {
  sql = <<-EOQ
    select
    self_link resource,
    case
      when visibility = 'private' then 'skip'
      when dnssec_config_state is null then 'alarm'
      when dnssec_config_default_key_specs @> '[{"keyType": "zoneSigning", "algorithm": "rsasha1"}]' then 'alarm'
      else 'ok'
    end as status,
    case
      when visibility = 'private'
        then title || ' is private.'
      when dnssec_config_state is null
        then title || ' DNSSEC not enabled.'
      when dnssec_config_default_key_specs @> '[{"keyType": "zoneSigning", "algorithm": "rsasha1"}]'
        then title || ' using RSASHA1 algorithm for zone-signing.'
      else title || ' not using RSASHA1 algorithm for zone-signing.'
    end as reason
    ${local.tag_dimensions_sql}
    ${local.common_dimensions_global_sql}
  from
    gcp_dns_managed_zone;
  EOQ
}

query "dns_managed_zone_dnssec_enabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when visibility = 'private' then 'skip'
        when visibility = 'public' and (dnssec_config_state is null or dnssec_config_state = 'off') then 'alarm'
        else 'ok'
      end as status,
      case
        when visibility = 'private'
          then title || ' is private.'
        when visibility = 'public' and (dnssec_config_state is null or dnssec_config_state = 'off')
          then title || ' DNSSEC not enabled.'
        else title || ' DNSSEC enabled.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_global_sql}
    from
      gcp_dns_managed_zone;
  EOQ
}
