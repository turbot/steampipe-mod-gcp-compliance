locals {
  all_controls_dns_common_tags = merge(local.all_controls_common_tags, {
    service = "GCP/DNS"
  })
}

benchmark "all_controls_dns" {
  title       = "DNS"
  description = "This section contains recommendations for configuring DNS resources."
  children = [
    control.dns_managed_zone_dnssec_enabled,
    control.dnssec_prevent_rsasha1_ksk,
    control.dnssec_prevent_rsasha1_zsk
  ]

  tags = merge(local.all_controls_dns_common_tags, {
    type = "Benchmark"
  })
}
