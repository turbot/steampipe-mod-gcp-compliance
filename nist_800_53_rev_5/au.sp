benchmark "nist_800_53_rev_5_au" {
  title       = "Audit and Accountability (AU)"
  description = "The AU control family consists of security controls related to an organization's audit capabilities. This includes audit policies and procedures, audit logging, audit report generation, and protection of audit information."
  children = [
    benchmark.nist_800_53_rev_5_au_2,
    benchmark.nist_800_53_rev_5_au_3,
    benchmark.nist_800_53_rev_5_au_6,
    benchmark.nist_800_53_rev_5_au_7,
    benchmark.nist_800_53_rev_5_au_12
  ]

  tags = local.nist_800_53_rev_5_common_tags
}

benchmark "nist_800_53_rev_5_au_2" {
  title       = "Event Logging (AU-2)"
  description = "Automate security audit function with other organizational entities. Enable mutual support of audit of auditable events."
  children = [
    control.compute_https_load_balancer_logging_enabled,
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

  tags = local.nist_800_53_rev_5_common_tags
}

benchmark "nist_800_53_rev_5_au_3" {
  title       = "Content of Audit Records (AU-3)"
  description = "The information system generates audit records containing information that establishes what type of event occurred, when the event occurred, where the event occurred, the source of the event, the outcome of the event, and the identity of any individuals or subjects associated with the event."
  children = [
    control.alloydb_instance_log_error_verbosity_database_flag_default_or_stricter,
    control.alloydb_instance_log_min_error_statement_database_flag_configured,
    control.alloydb_instance_log_min_messages_database_flag_error,
    control.compute_network_dns_logging_enabled,
    control.sql_instance_postgresql_log_connections_database_flag_on,
    control.sql_instance_postgresql_log_disconnections_database_flag_on,
    control.sql_instance_postgresql_log_error_verbosity_database_flag_default_or_stricter,
    control.sql_instance_postgresql_log_min_duration_statement_database_flag_disabled,
    control.sql_instance_postgresql_log_min_error_statement_database_flag_configured,
    control.sql_instance_postgresql_log_min_messages_database_flag_error,
    control.sql_instance_postgresql_log_statement_database_flag_ddl
  ]

  tags = local.nist_800_53_rev_5_common_tags
}

benchmark "nist_800_53_rev_5_au_6" {
  title       = "Audit Record Review, Analysis And Reporting (AU-6)"
  description = "Integrate audit review, analysis, and reporting with processes for investigation and response to suspicious activities."
  children = [
    control.audit_logging_configured_for_all_service,
    control.compute_https_load_balancer_logging_enabled
  ]

  tags = local.nist_800_53_rev_5_common_tags
}

benchmark "nist_800_53_rev_5_au_7" {
  title       = "Audit Record Reduction And Report Generation (AU-7)"
  description = "Support for real-time audit review, analysis, and reporting requirements without altering original audit records."
  children = [
    control.alloydb_instance_log_error_verbosity_database_flag_default_or_stricter,
    control.alloydb_instance_log_min_error_statement_database_flag_configured,
    control.alloydb_instance_log_min_messages_database_flag_error,
    control.audit_logging_configured_for_all_service,
    control.compute_network_dns_logging_enabled,
    control.logging_metric_alert_audit_configuration_changes,
    control.logging_metric_alert_custom_role_changes,
    control.logging_metric_alert_firewall_rule_changes,
    control.logging_metric_alert_network_changes,
    control.logging_metric_alert_network_route_changes,
    control.logging_metric_alert_project_ownership_assignment,
    control.logging_metric_alert_sql_instance_configuration_changes,
    control.logging_metric_alert_storage_iam_permission_changes,
    control.logging_sink_configured_for_all_resource,
    control.sql_instance_postgresql_log_connections_database_flag_on,
    control.sql_instance_postgresql_log_disconnections_database_flag_on,
    control.sql_instance_postgresql_log_error_verbosity_database_flag_default_or_stricter,
    control.sql_instance_postgresql_log_min_duration_statement_database_flag_disabled,
    control.sql_instance_postgresql_log_min_error_statement_database_flag_configured,
    control.sql_instance_postgresql_log_min_messages_database_flag_error,
    control.sql_instance_postgresql_log_statement_database_flag_ddl
  ]

  tags = local.nist_800_53_rev_5_common_tags
}

benchmark "nist_800_53_rev_5_au_12" {
  title       = "Audit Record Generation (AU-12)"
  description = "Audit events defined in AU-2. Allow trusted personnel to select which events to audit. Generate audit records for events."
  children = [
    control.alloydb_instance_log_error_verbosity_database_flag_default_or_stricter,
    control.alloydb_instance_log_min_error_statement_database_flag_configured,
    control.alloydb_instance_log_min_messages_database_flag_error,
    control.compute_https_load_balancer_logging_enabled,
    control.logging_metric_alert_audit_configuration_changes,
    control.logging_metric_alert_custom_role_changes,
    control.logging_metric_alert_firewall_rule_changes,
    control.logging_metric_alert_network_changes,
    control.logging_metric_alert_network_route_changes,
    control.logging_metric_alert_project_ownership_assignment,
    control.logging_metric_alert_sql_instance_configuration_changes,
    control.logging_metric_alert_storage_iam_permission_changes,
    control.logging_sink_configured_for_all_resource,
    control.sql_instance_postgresql_log_connections_database_flag_on,
    control.sql_instance_postgresql_log_disconnections_database_flag_on,
    control.sql_instance_postgresql_log_error_verbosity_database_flag_default_or_stricter,
    control.sql_instance_postgresql_log_min_duration_statement_database_flag_disabled,
    control.sql_instance_postgresql_log_min_error_statement_database_flag_configured,
    control.sql_instance_postgresql_log_min_messages_database_flag_error,
    control.sql_instance_postgresql_log_statement_database_flag_ddl
  ]

  tags = local.nist_800_53_rev_5_common_tags
}