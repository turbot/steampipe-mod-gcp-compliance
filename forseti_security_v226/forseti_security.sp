locals {
  forseti_security_common_tags = {
    forseti_security_v226   = "true"
    plugin                  = "gcp"
  }
}

benchmark "forseti_security_v226" {
  title         = "Forseti Security v2.26.0"
  description   = "Forseti Security Benchmark covers foundational security elements of Google Cloud Platform."
  documentation = file("./forseti_security_v226/docs/forseti_security_overview.md")
  tags          = local.forseti_security_common_tags
  children = [
      control.cmek_rotation_one_hundred_days,
      control.denylist_public_users,
      control.iam_restrict_service_account_key_age_one_hundred_days,
      control.only_my_domain,
      control.require_bq_table_iam,
      control.restrict_firewall_rule_world_open,
      control.restrict_firewall_rule_world_open_tcp_udp_all_ports,
      control.restrict_gmail_bigquery_dataset,
      control.restrict_googlegroups_bigquery_dataset,
      control.sql_world_readable
  ]
}