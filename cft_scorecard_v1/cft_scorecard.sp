locals {
  cft_scorecard_common_tags = {
    cft_scorecard_v1   = "true"
    plugin             = "gcp"
  }
}

benchmark "cft_scorecard" {
  title         = "CFT Scorecard v1"
  documentation = file("./cft_scorecard_v1/docs/cft_scorecard_overview.md")
  tags          = local.cft_scorecard_common_tags
  children = [
      control.allow_only_private_cluster,
      control.denylist_public_users,
      control.disable_gke_dashboard,
      control.disable_gke_default_service_account,
      control.disable_gke_legacy_abac,
      control.disable_gke_legacy_endpoints,
      control.dnssec_prevent_rsasha1_ksk,
      control.dnssec_prevent_rsasha1_zsk,
      control.enable_alias_ip_ranges,
      control.enable_auto_repair,
      control.enable_auto_upgrade,
      control.enable_gke_master_authorized_networks,
      control.enable_network_flow_logs,
      control.enable_network_private_google_access,
      control.gke_container_optimized_os,
      control.gke_restrict_pod_traffic,
      control.prevent_public_ip_cloudsql,
      control.require_bq_table_iam,
      control.require_bucket_policy_only,
      control.require_ssl_sql,
      control.restrict_firewall_rule_rdp_world_open,
      control.restrict_firewall_rule_ssh_world_open,
      control.restrict_firewall_rule_world_open,
      control.restrict_gmail_bigquery_dataset,
      control.restrict_googlegroups_bigquery_dataset,
      control.service_versions,
      control.sql_world_readable
  ]
}