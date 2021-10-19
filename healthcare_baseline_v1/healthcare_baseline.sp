locals {
  healthcare_baseline_common_tags = {
    healthcare_baseline_v1  = "true"
    plugin                  = "gcp"
  }
}

benchmark "healthcare_baseline_v1" {
  title         = "Healthcare Baseline v1"
  documentation = file("./healthcare_baseline_v1/docs/healthcare_baseline_overview.md")
  tags          = local.healthcare_baseline_common_tags
  children = [
    control.audit_log_all,
    control.denylist_public_users,
    control.enable_network_flow_logs,
    control.enable_network_firewall_logs,
    control.only_my_domain,
    control.prevent_public_ip_cloudsql,
    control.require_bq_table_iam,
    control.require_bucket_policy_only,
    control.sql_world_readable
  ]
}