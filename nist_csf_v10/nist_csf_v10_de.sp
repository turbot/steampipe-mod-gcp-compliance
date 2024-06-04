benchmark "nist_csf_v10_de" {
  title       = "Detect (DE)"
  description = "Detect and implement appropriate activities to identify the occurrence of a cybersecurity event. Functions include Anomalies & Events, Security Continuous Monitoring, and Detection Processes."
  children = [
    benchmark.nist_csf_v10_de_ae,
    benchmark.nist_csf_v10_de_cm,
  ]

  tags = local.nist_csf_v10_common_tags
}

benchmark "nist_csf_v10_de_ae" {
  title       = "Anomalies and Events (DE.AE)"
  description = "Anomalous activity is detected and the potential impact of events is understood."
  children = [
    benchmark.nist_csf_v10_de_ae_2,
    benchmark.nist_csf_v10_de_ae_3,
  ]

  tags = local.nist_csf_v10_common_tags
}

benchmark "nist_csf_v10_de_ae_2" {
  title       = "DE.AE-2"
  description = "Detected events are analyzed to understand attack targets and methods."
  children = [
    control.audit_logging_configured_for_all_service
    control.compute_network_dns_logging_enabled
  ]

  tags = local.nist_csf_v10_common_tags
}

benchmark "nist_csf_v10_de_ae_3" {
  title       = "DE.AE-3"
  description = "Event data are collected and correlated from multiple sources and sensors."
  children = [
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
    control.sql_instance_postgresql_log_statement_database_flag_ddl,
    control.compute_https_load_balancer_logging_enabled,
  ]

  tags = local.nist_csf_v10_common_tags
}

benchmark "nist_csf_v10_de_cm" {
  title       = "Security Continuous Monitoring (DE.CM)"
  description = "The information system and assets are monitored to identify cybersecurity events and verify the effectiveness of protective measures."
  children = [
    benchmark.nist_csf_v10_de_cm_1
  ]

  tags = local.nist_csf_v10_common_tags
}

benchmark "nist_csf_v10_de_cm_1" {
  title       = "DE.CM-1"
  description = "The network is monitored to detect potential cybersecurity events."
  children = [
    control.enable_network_flow_logs,
    control.sql_instance_postgresql_log_connections_database_flag_on,
    control.sql_instance_postgresql_log_disconnections_database_flag_on,
    control.sql_instance_postgresql_log_error_verbosity_database_flag_default_or_stricter,
    control.sql_instance_postgresql_log_min_duration_statement_database_flag_disabled,
    control.sql_instance_postgresql_log_min_error_statement_database_flag_configured,
    control.sql_instance_postgresql_log_min_messages_database_flag_error,
    control.sql_instance_postgresql_log_statement_database_flag_ddl
  ]

  tags = local.nist_csf_v10_common_tags
}