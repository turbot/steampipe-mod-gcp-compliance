benchmark "nist_csf_v2_de" {
  title       = "Detect (DE)"
  description = "Possible cybersecurity attacks and compromises are found and analyzed."
  children = [
    benchmark.nist_csf_v2_de_ae,
    benchmark.nist_csf_v2_de_cm
  ]
}

benchmark "nist_csf_v2_de_ae" {
  title       = "Anomalies and Events (DE.AE)"
  description = "Anomalies, indicators of compromise, and other potentially adverse events are analyzed to characterize the events and detect cybersecurity incidents."
  children = [
    benchmark.nist_csf_v2_de_ae_02,
    benchmark.nist_csf_v2_de_ae_03,
    benchmark.nist_csf_v2_de_ae_04,
    benchmark.nist_csf_v2_de_ae_06,
    benchmark.nist_csf_v2_de_ae_07,
    benchmark.nist_csf_v2_de_ae_08
  ]
}

benchmark "nist_csf_v2_de_ae_02" {
  title       = "DE.AE-02"
  description = "Potentially adverse events are analyzed to better understand associated activities."
  children = [
    control.audit_logging_configured_for_all_service,
    control.logging_metric_alert_audit_configuration_changes,
    control.logging_metric_alert_custom_role_changes,
    control.logging_metric_alert_firewall_rule_changes,
    control.logging_metric_alert_network_changes,
    control.logging_metric_alert_network_route_changes,
    control.logging_metric_alert_project_ownership_assignment,
    control.logging_metric_alert_sql_instance_configuration_changes,
    control.logging_metric_alert_storage_iam_permission_changes
  ]
}

benchmark "nist_csf_v2_de_ae_03" {
  title       = "DE.AE-03"
  description = "Information is correlated from multiple sources."
  children = [
    control.logging_sink_configured_for_all_resource
  ]
}

benchmark "nist_csf_v2_de_ae_04" {
  title       = "DE.AE-04"
  description = "The estimated impact and scope of adverse events are understood."
  children = [
    control.audit_logging_configured_for_all_service,
    control.logging_metric_alert_audit_configuration_changes,
    control.logging_metric_alert_custom_role_changes,
    control.logging_metric_alert_firewall_rule_changes,
    control.logging_metric_alert_network_changes,
    control.logging_metric_alert_network_route_changes,
    control.logging_metric_alert_project_ownership_assignment,
    control.logging_metric_alert_sql_instance_configuration_changes,
    control.logging_metric_alert_storage_iam_permission_changes
  ]
}

benchmark "nist_csf_v2_de_ae_06" {
  title       = "DE.AE-06"
  description = "Information on adverse events is provided to authorized staff and tools."
  children = [
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
}

benchmark "nist_csf_v2_de_ae_07" {
  title       = "DE.AE-07"
  description = "Cyber threat intelligence and other contextual information are integrated into the analysis."
  children = [
    control.logging_sink_configured_for_all_resource
  ]
}

benchmark "nist_csf_v2_de_ae_08" {
  title       = "DE.AE-08"
  description = "Incidents are declared when adverse events meet the defined incident criteria."
  children = [
    control.logging_metric_alert_audit_configuration_changes,
    control.logging_metric_alert_custom_role_changes,
    control.logging_metric_alert_firewall_rule_changes,
    control.logging_metric_alert_network_changes,
    control.logging_metric_alert_network_route_changes,
    control.logging_metric_alert_project_ownership_assignment,
    control.logging_metric_alert_sql_instance_configuration_changes,
    control.logging_metric_alert_storage_iam_permission_changes
  ]
}

benchmark "nist_csf_v2_de_cm" {
  title       = "Continuous Monitoring (DE.CM)"
  description = "Assets are monitored to find anomalies, indicators of compromise, and other potentially adverse events."
  children = [
    benchmark.nist_csf_v2_de_cm_01,
    benchmark.nist_csf_v2_de_cm_02,
    benchmark.nist_csf_v2_de_cm_03,
    benchmark.nist_csf_v2_de_cm_06,
    benchmark.nist_csf_v2_de_cm_09
  ]
}

benchmark "nist_csf_v2_de_cm_01" {
  title       = "DE.CM-01"
  description = "Networks and network services are monitored to find potentially adverse events."
  children = [
    control.compute_network_dns_logging_enabled,
    control.enable_network_flow_logs,
    control.logging_metric_alert_firewall_rule_changes,
    control.logging_metric_alert_network_changes,
    control.logging_metric_alert_network_route_changes
  ]
}

benchmark "nist_csf_v2_de_cm_02" {
  title       = "DE.CM-02"
  description = "The physical environment is monitored to find potentially adverse events."
  children = [
    control.project_access_approval_settings_enabled
  ]
}

benchmark "nist_csf_v2_de_cm_03" {
  title       = "DE.CM-03"
  description = "Personnel activity and technology usage are monitored to find potentially adverse events."
  children = [
    control.audit_logging_configured_for_all_service,
    control.iam_api_key_age_90,
    control.iam_service_account_key_age_90,
    control.logging_metric_alert_audit_configuration_changes,
    control.logging_metric_alert_custom_role_changes,
    control.logging_metric_alert_project_ownership_assignment
  ]
}

benchmark "nist_csf_v2_de_cm_06" {
  title       = "DE.CM-06"
  description = "External service provider activities and services are monitored to find potentially adverse events."
  children = [
    control.audit_logging_configured_for_all_service,
    control.project_service_cloudasset_api_enabled
  ]
}

benchmark "nist_csf_v2_de_cm_09" {
  title       = "DE.CM-09"
  description = "Computing hardware and software, runtime environments, and their data are monitored to find potentially adverse events."
  children = [
    control.audit_logging_configured_for_all_service,
    control.kubernetes_cluster_monitoring_enabled,
    control.logging_metric_alert_project_ownership_assignment,
    control.logging_metric_alert_sql_instance_configuration_changes,
    control.logging_metric_alert_storage_iam_permission_changes
  ]
}
