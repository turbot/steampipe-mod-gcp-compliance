locals {
  control_library_dns_common_tags = {
    service = "dns"
  }
}

control "dnssec_prevent_rsasha1_ksk" {
  title         = "Ensure that RSASHA1 is not used for key-signing key in Cloud DNS"
  sql           = query.dns_managed_zone_key_signing_not_using_rsasha1.sql

  tags = merge(local.cft_scorecard_common_tags, {
    cft_scorecard_v1   = "true"
    severity           = "high"
  })
}

control "dnssec_prevent_rsasha1_zsk" {
  title         = "Ensure that RSASHA1 is not used for zone-signing key in Cloud DNS"
  sql           = query.dns_managed_zone_zone_signing_not_using_rsasha1.sql

  tags = merge(local.cft_scorecard_common_tags, {
    cft_scorecard_v1   = "true"
    severity           = "high"
  })
}