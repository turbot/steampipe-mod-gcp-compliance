benchmark "nist_csf_v10_pr" {
  title       = "Protect (PR)"
  description = "Develop and implement appropriate safeguards to ensure delivery of critical services. Functions include Identity & Access Management Control, Awareness & Training, Data Security, Maintenance, Protective Technologies, Information Protection Processes & Procedures."

  children = [
    benchmark.nist_csf_v10_pr_ac,
    benchmark.nist_csf_v10_pr_ds,
    benchmark.nist_csf_v10_pr_ip,
    benchmark.nist_csf_v10_pr_pt
  ]

  tags = local.nist_csf_v10_common_tags
}

benchmark "nist_csf_v10_pr_pt" {
  title       = "Protective Technology (PR.PT)"
  description = "Anomalous activity is detected and the potential impact of events is understood."
  children = [
    benchmark.nist_csf_v10_pr_pt_1,
    benchmark.nist_csf_v10_pr_pt_3
  ]

  tags = local.nist_csf_v10_common_tags
}

benchmark "nist_csf_v10_pr_pt_1" {
  title       = "PR.PT-1"
  description = "Audit/log records are determined, documented, implemented, and reviewed in accordance with policy."
  children = [
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
    control.compute_https_load_balancer_logging_enabled,
  ]

  tags = local.nist_csf_v10_common_tags
}

benchmark "nist_csf_v10_pr_pt_3" {
  title       = "PR.PT-3"
  description = "The principle of least functionality is incorporated by configuring systems to provide only essential capabilities."
  children = [
    control.sql_instance_sql_external_scripts_enabled_database_flag_off
  ]

  tags = local.nist_csf_v10_common_tags
}

benchmark "nist_csf_v10_pr_ds" {
  title       = "Data Security (PR.DS)"
  description = "Information and records (data) are managed consistent with the organization’s risk strategy to protect the confidentiality, integrity, and availability of information."
  children = [
    benchmark.nist_csf_v10_pr_ds_1,
    benchmark.nist_csf_v10_pr_ds_2,
    benchmark.nist_csf_v10_pr_ds_3
  ]

  tags = local.nist_csf_v10_common_tags
}

benchmark "nist_csf_v10_pr_ds_1" {
  title       = "PR.DS-1"
  description = "Data-at-rest is protected."
  children = [
    control.bigquery_dataset_encrypted_with_cmk,
    control.bigquery_table_encrypted_with_cmk,
    control.compute_disk_encrypted_with_csk,
    control.dataproc_cluster_encryption_with_cmek,
    control.kms_key_rotated_within_90_day,
    control.compute_instance_confidential_computing_enabled,
  ]

  tags = local.nist_csf_v10_common_tags
}

benchmark "nist_csf_v10_pr_ds_2" {
  title       = "PR.DS-2"
  description = "DData-in-transit is protected."
  children = [
    control.compute_instance_block_project_wide_ssh_enabled
  ]

  tags = local.nist_csf_v10_common_tags
}

benchmark "nist_csf_v10_pr_ds_3" {
  title       = "PR.DS-3"
  description = "Assets are formally managed throughout removal, transfers, and disposition."
  children = [
    control.project_service_cloudasset_api_enabled
  ]

  tags = local.nist_csf_v10_common_tags
}

benchmark "nist_csf_v10_pr_ac" {
  title       = "Identity Management Authentication and Access Control (PR.AC)"
  description = "Access to physical and logical assets and associated facilities is limited to authorized users, processes, and devices, and is managed consistent with the assessed risk of unauthorized access to authorized activities and transactions."
  children = [
    benchmark.nist_csf_v10_pr_ac_1,
    benchmark.nist_csf_v10_pr_ac_4
  ]

  tags = local.nist_csf_v10_common_tags
}

benchmark "nist_csf_v10_pr_ac_1" {
  title       = "PR.AC-1"
  description = "Identities and credentials are issued, managed, verified, revoked, andaudited for authorized devices, users and processes."
  children = [
    control.compute_instance_with_no_default_service_account_with_full_access,
    control.compute_instance_with_no_default_service_account
  ]

  tags = local.nist_csf_v10_common_tags
}

benchmark "nist_csf_v10_pr_ac_4" {
  title       = "PR.AC-4"
  description = "Access permissions and authorizations are managed, incorporating the principles of least privilege and separation of duties"
  children = [
    control.compute_instance_with_no_public_ip_addresses,
    control.iam_service_account_without_admin_privilege,
    control.iam_user_not_assigned_service_account_user_role_project_level,
    control.iam_user_separation_of_duty_enforced,
    control.kms_key_not_publicly_accessible,
    control.kms_key_separation_of_duties_enforced,
    control.prevent_public_ip_cloudsql,
    control.require_bq_table_iam,
    control.require_bucket_policy_only,
    control.sql_instance_mysql_skip_show_database_flag_on,
    control.sql_instance_not_publicly_accessible,
    control.sql_instance_sql_contained_database_authentication_database_flag_off,
    control.sql_instance_sql_cross_db_ownership_chaining_database_flag_off,
    control.storage_bucket_log_retention_policy_lock_enabled,
    control.storage_bucket_not_publicly_accessible
  ]

  tags = local.nist_csf_v10_common_tags
}

benchmark "nist_csf_v10_pr_ip" {
  title       = "Information Protection Processes and Procedures (PR.IP)"
  description = "Security policies (that address purpose, scope, roles, responsibilities, management commitment, and coordination among organizational entities), processes, and procedures are maintained and used to manage protection of information systems and assets."
  children = [
    benchmark.nist_csf_v10_pr_ip_1,
    benchmark.nist_csf_v10_pr_ip_2,
    benchmark.nist_csf_v10_pr_ip_4
  ]

  tags = local.nist_csf_v10_common_tags
}

benchmark "nist_csf_v10_pr_ip_1" {
  title       = "PR.IP-1"
  description = "A baseline configuration of information technology/industrial control systems is created and maintained incorporating security principles (e.g. concept of least functionality)."
  children = [
    control.compute_network_contains_no_default_network,
    control.compute_network_contains_no_legacy_network,
    control.dns_managed_zone_dnssec_enabled,
    control.dnssec_prevent_rsasha1_ksk,
    control.sql_instance_mysql_local_infile_database_flag_off,
    control.sql_instance_sql_3625_trace_database_flag_on,
    control.sql_instance_sql_external_scripts_enabled_database_flag_off,
    control.sql_instance_sql_user_connections_database_flag_configured,
    control.sql_instance_sql_user_options_database_flag_not_configured
  ]

  tags = local.nist_csf_v10_common_tags
}

benchmark "nist_csf_v10_pr_ip_2" {
  title       = "PR.IP-2"
  description = "A System Development Life Cycle to manage systems is implemented."
  children = [
    control.iam_api_key_age_90,
    control.iam_api_key_restricts_apis,
    control.project_no_api_key
  ]

  tags = local.nist_csf_v10_common_tags
}

benchmark "nist_csf_v10_pr_ip_4" {
  title       = "PR.IP-4"
  description = "Backups of information are conducted, maintained, and tested."
  children = [
    control.sql_instance_automated_backups_enabled
  ]

  tags = local.nist_csf_v10_common_tags
}