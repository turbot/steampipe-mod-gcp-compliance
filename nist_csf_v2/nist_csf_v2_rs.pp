benchmark "nist_csf_v2_rs" {
  title       = "RESPOND (RS)"
  description = "Actions regarding a detected cybersecurity incident are taken."
  children = [
    benchmark.nist_csf_v2_rs_ma,
    benchmark.nist_csf_v2_rs_an,
    benchmark.nist_csf_v2_rs_co,
    benchmark.nist_csf_v2_rs_mi
  ]
}

benchmark "nist_csf_v2_rs_ma" {
  title       = "RS.MA"
  description = "Incident Management (RS.MA): Responses to detected cybersecurity incidents are managed."
  children = [
    benchmark.nist_csf_v2_rs_ma_01,
    benchmark.nist_csf_v2_rs_ma_02,
    benchmark.nist_csf_v2_rs_ma_03,
    benchmark.nist_csf_v2_rs_ma_04,
    benchmark.nist_csf_v2_rs_ma_05
  ]
}

benchmark "nist_csf_v2_rs_ma_01" {
  title       = "RS.MA-01"
  description = "The incident response plan is executed in coordination with relevant third parties once an incident is declared."
  children = [
    control.organization_essential_contacts_configured
  ]
}

benchmark "nist_csf_v2_rs_ma_02" {
  title       = "RS.MA-02"
  description = "Incident reports are triaged and validated."
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

benchmark "nist_csf_v2_rs_ma_03" {
  title       = "RS.MA-03"
  description = "Incidents are categorized and prioritized."
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

benchmark "nist_csf_v2_rs_ma_04" {
  title       = "RS.MA-04"
  description = "Incidents are escalated or elevated as needed."
  children = [
    control.logging_metric_alert_audit_configuration_changes,
    control.logging_metric_alert_custom_role_changes,
    control.logging_metric_alert_firewall_rule_changes,
    control.logging_metric_alert_network_changes,
    control.logging_metric_alert_network_route_changes,
    control.logging_metric_alert_project_ownership_assignment,
    control.logging_metric_alert_sql_instance_configuration_changes,
    control.logging_metric_alert_storage_iam_permission_changes,
    control.organization_essential_contacts_configured
  ]
}

benchmark "nist_csf_v2_rs_ma_05" {
  title       = "RS.MA-05"
  description = "The criteria for initiating incident recovery are applied."
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

benchmark "nist_csf_v2_rs_an" {
  title       = "RS.AN"
  description = "Incident Analysis (RS.AN): Investigations are conducted to ensure effective response and support forensics and recovery activities."
  children = [
    benchmark.nist_csf_v2_rs_an_03,
    benchmark.nist_csf_v2_rs_an_06,
    benchmark.nist_csf_v2_rs_an_07,
    benchmark.nist_csf_v2_rs_an_08
  ]
}

benchmark "nist_csf_v2_rs_an_03" {
  title       = "RS.AN-03"
  description = "Analysis is performed to establish what has taken place during an incident and the root cause of the incident."
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

benchmark "nist_csf_v2_rs_an_06" {
  title       = "RS.AN-06"
  description = "Actions performed during an investigation are recorded, and the records' integrity and provenance are preserved."
  children = [
    control.audit_logging_configured_for_all_service,
    control.logging_bucket_retention_policy_enabled
  ]
}

benchmark "nist_csf_v2_rs_an_07" {
  title       = "RS.AN-07"
  description = "Incident data and metadata are collected, and their integrity and provenance are preserved."
  children = [
    control.audit_logging_configured_for_all_service,
    control.logging_bucket_retention_policy_enabled
  ]
}

benchmark "nist_csf_v2_rs_an_08" {
  title       = "RS.AN-08"
  description = "An incident's magnitude is estimated and validated."
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

benchmark "nist_csf_v2_rs_co" {
  title       = "RS.CO"
  description = "Incident Response Reporting and Communication (RS.CO): Response activities are coordinated with internal and external stakeholders as required by laws, regulations, or policies."
  children = [
    benchmark.nist_csf_v2_rs_co_02,
    benchmark.nist_csf_v2_rs_co_03
  ]
}

benchmark "nist_csf_v2_rs_co_02" {
  title       = "RS.CO-02"
  description = "Internal and external stakeholders are notified of incidents."
  children = [
    control.organization_essential_contacts_configured
  ]
}

benchmark "nist_csf_v2_rs_co_03" {
  title       = "RS.CO-03"
  description = "Information is shared with designated internal and external stakeholders."
  children = [
    control.organization_essential_contacts_configured
  ]
}

benchmark "nist_csf_v2_rs_mi" {
  title       = "RS.MI"
  description = "Incident Mitigation (RS.MI): Activities are performed to prevent expansion of an event and mitigate its effects."
  children = [
    benchmark.nist_csf_v2_rs_mi_01,
    benchmark.nist_csf_v2_rs_mi_02
  ]
}

benchmark "nist_csf_v2_rs_mi_01" {
  title       = "RS.MI-01"
  description = "Incidents are contained."
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

benchmark "nist_csf_v2_rs_mi_02" {
  title       = "RS.MI-02"
  description = "Incidents are eradicated."
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