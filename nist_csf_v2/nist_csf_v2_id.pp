benchmark "nist_csf_v2_id" {
  title       = "IDENTIFY (ID)"
  description = "The organization's current cybersecurity risks are understood."
  children = [
    benchmark.nist_csf_v2_id_am,
    benchmark.nist_csf_v2_id_ra,
    benchmark.nist_csf_v2_id_im
  ]
}

benchmark "nist_csf_v2_id_am" {
  title       = "ID.AM"
  description = "Asset Management (ID.AM): Assets (e.g., data, hardware, software, systems, facilities, services, people) that enable the organization to achieve business purposes are identified and managed consistent with their relative importance to organizational objectives and the organization's risk strategy."
  children = [
    benchmark.nist_csf_v2_id_am_01,
    benchmark.nist_csf_v2_id_am_02,
    benchmark.nist_csf_v2_id_am_03,
    benchmark.nist_csf_v2_id_am_04,
    benchmark.nist_csf_v2_id_am_05,
    benchmark.nist_csf_v2_id_am_07,
    benchmark.nist_csf_v2_id_am_08
  ]
}

benchmark "nist_csf_v2_id_am_01" {
  title       = "ID.AM-01"
  description = "Inventories of hardware managed by the organization are maintained."
  children = [
    control.project_service_cloudasset_api_enabled,
    control.compute_instance_with_labels,
    control.compute_instance_shielded_vm_enabled,
    control.compute_instance_with_no_public_ip_addresses,
    control.compute_instance_confidential_computing_enabled,
    control.compute_instance_with_no_default_service_account,
    control.compute_instance_block_project_wide_ssh_enabled,
    control.compute_instance_oslogin_enabled,
    control.compute_instance_serial_port_connection_disabled,
    control.compute_disk_encrypted_with_csk
  ]
}

benchmark "nist_csf_v2_id_am_02" {
  title       = "ID.AM-02"
  description = "Inventories of software, services, and systems managed by the organization are maintained."
  children = [
    control.project_service_cloudasset_api_enabled,
    control.audit_logging_configured_for_all_service,
    control.iam_service_account_gcp_managed_key,
    control.iam_service_account_key_age_90,
    control.iam_user_not_assigned_service_account_user_role_project_level
  ]
}

benchmark "nist_csf_v2_id_am_03" {
  title       = "ID.AM-03"
  description = "Representations of the organization's authorized network communication and internal and external network data flows are maintained."
  children = [
    control.logging_metric_alert_firewall_rule_changes,
    control.logging_metric_alert_network_changes,
    control.logging_metric_alert_network_route_changes,
    control.compute_subnetwork_flow_log_enabled,
    control.compute_network_dns_logging_enabled
  ]
}

benchmark "nist_csf_v2_id_am_04" {
  title       = "ID.AM-04"
  description = "Inventories of services provided by suppliers are maintained."
  children = [
    control.project_service_cloudasset_api_enabled,
    control.audit_logging_configured_for_all_service
  ]
}

benchmark "nist_csf_v2_id_am_05" {
  title       = "ID.AM-05"
  description = "Assets are prioritized based on classification, criticality, resources, and impact on the mission."
  children = [
    control.project_service_cloudasset_api_enabled,
    control.compute_instance_with_labels
  ]
}

benchmark "nist_csf_v2_id_am_07" {
  title       = "ID.AM-07"
  description = "Inventories of data and corresponding metadata for designated data types are maintained."
  children = [
    control.project_service_cloudasset_api_enabled,
    control.logging_metric_alert_storage_iam_permission_changes,
    control.storage_bucket_not_publicly_accessible,
    control.storage_bucket_log_retention_policy_enabled,
    control.storage_bucket_log_object_versioning_enabled
  ]
}

benchmark "nist_csf_v2_id_am_08" {
  title       = "ID.AM-08"
  description = "Systems, hardware, software, services, and data are managed throughout their life cycles."
  children = [
    control.project_service_cloudasset_api_enabled,
    control.logging_bucket_retention_policy_enabled,
    control.storage_bucket_log_retention_policy_enabled,
    control.iam_service_account_key_age_90,
    control.kms_key_rotated_within_90_day
  ]
}

benchmark "nist_csf_v2_id_ra" {
  title       = "ID.RA"
  description = "Risk Assessment (ID.RA): The cybersecurity risk to the organization, assets, and individuals is understood by the organization."
  children = [
    benchmark.nist_csf_v2_id_ra_01,
    benchmark.nist_csf_v2_id_ra_02,
    benchmark.nist_csf_v2_id_ra_03,
    benchmark.nist_csf_v2_id_ra_04,
    benchmark.nist_csf_v2_id_ra_05,
    benchmark.nist_csf_v2_id_ra_06,
    benchmark.nist_csf_v2_id_ra_07,
    benchmark.nist_csf_v2_id_ra_08,
    benchmark.nist_csf_v2_id_ra_09,
    benchmark.nist_csf_v2_id_ra_10
  ]
}

benchmark "nist_csf_v2_id_ra_01" {
  title       = "ID.RA-01"
  description = "Vulnerabilities in assets are identified, validated, and recorded."
  children = [
    control.project_service_container_scanning_api_enabled
  ]
}

benchmark "nist_csf_v2_id_ra_02" {
  title       = "ID.RA-02"
  description = "Cyber threat intelligence is received from information sharing forums and sources."
  children = [
    control.organization_essential_contacts_configured,
    control.logging_metric_alert_audit_configuration_changes,
    control.logging_metric_alert_custom_role_changes,
    control.logging_metric_alert_custom_role_changes_with_iam_admin_undelete_role,
    control.logging_metric_alert_firewall_rule_changes,
    control.logging_metric_alert_network_changes,
    control.logging_metric_alert_network_route_changes,
    control.logging_metric_alert_project_ownership_assignment,
    control.logging_metric_alert_sql_instance_configuration_changes,
    control.logging_metric_alert_storage_iam_permission_changes
  ]
}

benchmark "nist_csf_v2_id_ra_03" {
  title       = "ID.RA-03"
  description = "Internal and external threats to the organization are identified and recorded."
  children = [
    control.logging_metric_alert_audit_configuration_changes,
    control.logging_metric_alert_custom_role_changes,
    control.logging_metric_alert_custom_role_changes_with_iam_admin_undelete_role,
    control.logging_metric_alert_firewall_rule_changes,
    control.logging_metric_alert_network_changes,
    control.logging_metric_alert_network_route_changes,
    control.logging_metric_alert_project_ownership_assignment,
    control.logging_metric_alert_sql_instance_configuration_changes,
    control.logging_metric_alert_storage_iam_permission_changes
  ]
}

benchmark "nist_csf_v2_id_ra_04" {
  title       = "ID.RA-04"
  description = "Potential impacts and likelihoods of threats exploiting vulnerabilities are identified and recorded."
  children = [
    control.logging_metric_alert_audit_configuration_changes,
    control.logging_metric_alert_custom_role_changes,
    control.logging_metric_alert_custom_role_changes_with_iam_admin_undelete_role,
    control.logging_metric_alert_firewall_rule_changes,
    control.logging_metric_alert_network_changes,
    control.logging_metric_alert_network_route_changes,
    control.logging_metric_alert_project_ownership_assignment,
    control.logging_metric_alert_sql_instance_configuration_changes,
    control.logging_metric_alert_storage_iam_permission_changes
  ]
}

benchmark "nist_csf_v2_id_ra_05" {
  title       = "ID.RA-05"
  description = "Threats, vulnerabilities, likelihoods, and impacts are used to understand inherent risk and inform risk response prioritization."
  children = [
    control.logging_metric_alert_audit_configuration_changes,
    control.logging_metric_alert_custom_role_changes,
    control.logging_metric_alert_custom_role_changes_with_iam_admin_undelete_role,
    control.logging_metric_alert_firewall_rule_changes,
    control.logging_metric_alert_network_changes,
    control.logging_metric_alert_network_route_changes,
    control.logging_metric_alert_project_ownership_assignment,
    control.logging_metric_alert_sql_instance_configuration_changes,
    control.logging_metric_alert_storage_iam_permission_changes
  ]
}

benchmark "nist_csf_v2_id_ra_06" {
  title       = "ID.RA-06"
  description = "Risk responses are chosen, prioritized, planned, tracked, and communicated."
  children = [
    control.logging_metric_alert_audit_configuration_changes,
    control.logging_metric_alert_custom_role_changes,
    control.logging_metric_alert_custom_role_changes_with_iam_admin_undelete_role,
    control.logging_metric_alert_firewall_rule_changes,
    control.logging_metric_alert_network_changes,
    control.logging_metric_alert_network_route_changes,
    control.logging_metric_alert_project_ownership_assignment,
    control.logging_metric_alert_sql_instance_configuration_changes,
    control.logging_metric_alert_storage_iam_permission_changes
  ]
}

benchmark "nist_csf_v2_id_ra_07" {
  title       = "ID.RA-07"
  description = "Changes and exceptions are managed, assessed for risk impact, recorded, and tracked."
  children = [
    control.logging_metric_alert_audit_configuration_changes,
    control.logging_metric_alert_custom_role_changes,
    control.logging_metric_alert_custom_role_changes_with_iam_admin_undelete_role,
    control.logging_metric_alert_firewall_rule_changes,
    control.logging_metric_alert_network_changes,
    control.logging_metric_alert_network_route_changes,
    control.logging_metric_alert_project_ownership_assignment,
    control.logging_metric_alert_sql_instance_configuration_changes,
    control.logging_metric_alert_storage_iam_permission_changes
  ]
}

benchmark "nist_csf_v2_id_ra_08" {
  title       = "ID.RA-08"
  description = "Processes for receiving, analyzing, and responding to vulnerability disclosures are established."
  children = [
    control.project_service_container_scanning_api_enabled,
    control.logging_metric_alert_audit_configuration_changes,
    control.logging_metric_alert_custom_role_changes,
    control.logging_metric_alert_custom_role_changes_with_iam_admin_undelete_role,
    control.logging_metric_alert_firewall_rule_changes,
    control.logging_metric_alert_network_changes,
    control.logging_metric_alert_network_route_changes,
    control.logging_metric_alert_project_ownership_assignment,
    control.logging_metric_alert_sql_instance_configuration_changes,
    control.logging_metric_alert_storage_iam_permission_changes
  ]
}

benchmark "nist_csf_v2_id_ra_09" {
  title       = "ID.RA-09"
  description = "The authenticity and integrity of hardware and software are assessed prior to acquisition and use."
  children = [
    control.compute_instance_shielded_vm_enabled,
    control.kubernetes_cluster_binary_authorization_enabled,
    control.kubernetes_cluster_shielded_instance_integrity_monitoring_enabled,
    control.kubernetes_cluster_shielded_node_secure_boot_enabled,
    control.sql_instance_sql_contained_database_authentication_database_flag_off,
    control.project_service_container_scanning_api_enabled
  ]
}

benchmark "nist_csf_v2_id_ra_10" {
  title       = "ID.RA-10"
  description = "Critical suppliers are assessed prior to acquisition."
  children = [
    control.project_service_cloudasset_api_enabled,
    control.audit_logging_configured_for_all_service
  ]
}

benchmark "nist_csf_v2_id_im" {
  title       = "ID.IM"
  description = "Improvement (ID.IM): Improvements to organizational cybersecurity risk management processes, procedures and activities are identified across all CSF Functions."
  children = [
    benchmark.nist_csf_v2_id_im_01,
    benchmark.nist_csf_v2_id_im_02,
    benchmark.nist_csf_v2_id_im_03,
    benchmark.nist_csf_v2_id_im_04
  ]
}

benchmark "nist_csf_v2_id_im_01" {
  title       = "ID.IM-01"
  description = "Improvements are identified from evaluations."
  children = [
    control.audit_logging_configured_for_all_service,
    control.logging_metric_alert_audit_configuration_changes,
    control.sql_instance_postgresql_cloudsql_pgaudit_database_flag_enabled
  ]
}

benchmark "nist_csf_v2_id_im_02" {
  title       = "ID.IM-02"
  description = "Improvements are identified from security tests and exercises, including those done in coordination with suppliers and relevant third parties."
  children = [
    control.audit_logging_configured_for_all_service,
    control.logging_metric_alert_audit_configuration_changes,
    control.sql_instance_postgresql_cloudsql_pgaudit_database_flag_enabled
  ]
}

benchmark "nist_csf_v2_id_im_03" {
  title       = "ID.IM-03"
  description = "Improvements are identified from execution of operational processes, procedures, and activities."
  children = [
    control.audit_logging_configured_for_all_service,
    control.logging_metric_alert_audit_configuration_changes,
    control.sql_instance_postgresql_cloudsql_pgaudit_database_flag_enabled,
    control.logging_bucket_retention_policy_enabled
  ]
}

benchmark "nist_csf_v2_id_im_04" {
  title       = "ID.IM-04"
  description = "Incident response plans and other cybersecurity plans that affect operations are established, communicated, maintained, and improved."
  children = [
    control.organization_essential_contacts_configured
  ]
}