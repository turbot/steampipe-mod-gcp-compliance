locals {
  all_controls_logging_common_tags = merge(local.all_controls_common_tags, {
    service = "GCP/Logging"
  })
}

benchmark "all_controls_logging" {
  title       = "Logging"
  description = "This section contains recommendations for configuring Logging resources."
  children = [
    control.logging_bucket_retention_policy_enabled,
    control.logging_metric_alert_audit_configuration_changes,
    control.logging_metric_alert_custom_role_changes,
    control.logging_metric_alert_firewall_rule_changes,
    control.logging_metric_alert_network_changes,
    control.logging_metric_alert_network_route_changes,
    control.logging_metric_alert_project_ownership_assignment,
    control.logging_metric_alert_sql_instance_configuration_changes,
    control.logging_metric_alert_storage_iam_permission_changes,
    control.logging_sink_configured_for_all_resource
  ]

  tags = merge(local.all_controls_logging_common_tags, {
    type = "Benchmark"
  })
}
