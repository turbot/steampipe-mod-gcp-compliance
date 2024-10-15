benchmark "hipaa_164_312_b" {
  title       = "164.312(b) Audit controls"
  description = "Implement hardware, software, and/or procedural mechanisms that record and examine activity in information systems that contain or use electronic protected health information."
  children = [
    control.audit_logging_configured_for_all_service,
    control.compute_https_load_balancer_logging_enabled,
    control.compute_network_dns_logging_enabled,
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

  tags = merge(local.hipaa_164_312_common_tags, {
    hipaa_security_rule_2003_item_id = "164_312_b"
  })
}
