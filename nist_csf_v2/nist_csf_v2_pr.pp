benchmark "nist_csf_v2_pr" {
  title       = "PROTECT (PR)"
  description = "Safeguards to manage the organization's cybersecurity risks are used."
  children = [
    benchmark.nist_csf_v2_pr_aa,
    benchmark.nist_csf_v2_pr_ds,
    benchmark.nist_csf_v2_pr_ps,
    benchmark.nist_csf_v2_pr_ir
  ]
}

benchmark "nist_csf_v2_pr_aa" {
  title       = "PR.AA"
  description = "Identity Management, Authentication, and Access Control (PR.AA): Access to physical and logical assets is limited to authorized users, services, and hardware and managed commensurate with the assessed risk of unauthorized access."
  children = [
    benchmark.nist_csf_v2_pr_aa_01,
    benchmark.nist_csf_v2_pr_aa_02,
    benchmark.nist_csf_v2_pr_aa_03,
    benchmark.nist_csf_v2_pr_aa_04,
    benchmark.nist_csf_v2_pr_aa_05,
    benchmark.nist_csf_v2_pr_aa_06
  ]
}

benchmark "nist_csf_v2_pr_aa_01" {
  title       = "PR.AA-01"
  description = "Identities and credentials for authorized users, services, and hardware are managed by the organization."
  children = [
    control.denylist_public_users,
    control.iam_api_key_age_90,
    control.iam_api_key_restricts_apis,
    control.iam_api_key_restricts_websites_hosts_apps,
    control.iam_restrict_service_account_key_age_one_hundred_days,
    control.iam_service_account_gcp_managed_key,
    control.iam_service_account_key_age_90,
    control.iam_service_account_without_admin_privilege,
    control.iam_user_kms_separation_of_duty_enforced,
    control.iam_user_not_assigned_service_account_user_role_project_level,
    control.iam_user_separation_of_duty_enforced,
    control.kms_key_not_publicly_accessible,
    control.kms_key_rotated_within_90_day,
    control.kms_key_separation_of_duties_enforced,
    control.kms_key_users_limited_to_3
  ]
}

benchmark "nist_csf_v2_pr_aa_02" {
  title       = "PR.AA-02"
  description = "Identities are proofed and bound to credentials based on the context of interactions."
  children = [
    control.iam_user_kms_separation_of_duty_enforced,
    control.iam_user_separation_of_duty_enforced,
    control.kms_key_separation_of_duties_enforced,
    control.kubernetes_cluster_client_certificate_authentication_enabled,
    control.sql_instance_sql_contained_database_authentication_database_flag_off
  ]
}

benchmark "nist_csf_v2_pr_aa_03" {
  title       = "PR.AA-03"
  description = "Users, services, and hardware are authenticated."
  children = [
    control.denylist_public_users,
    control.iam_api_key_age_90,
    control.iam_api_key_restricts_apis,
    control.iam_api_key_restricts_websites_hosts_apps,
    control.iam_service_account_gcp_managed_key,
    control.iam_service_account_key_age_90,
    control.iam_service_account_without_admin_privilege,
    control.iam_user_not_assigned_service_account_user_role_project_level,
    control.kubernetes_cluster_client_certificate_authentication_enabled,
    control.sql_instance_sql_contained_database_authentication_database_flag_off
  ]
}

benchmark "nist_csf_v2_pr_aa_04" {
  title       = "PR.AA-04"
  description = "Identity assertions are protected, conveyed, and verified."
  children = [
    control.compute_https_load_balancer_logging_enabled,
    control.compute_ssl_policy_with_no_weak_cipher,
    control.compute_target_https_uses_latest_tls_version,
    control.kms_key_not_publicly_accessible,
    control.kms_key_rotated_within_90_day,
    control.kms_key_separation_of_duties_enforced,
    control.kms_key_users_limited_to_3,
    control.require_ssl_sql
  ]
}

benchmark "nist_csf_v2_pr_aa_05" {
  title       = "PR.AA-05"
  description = "Access permissions, entitlements, and authorizations are defined in a policy, managed, enforced, and reviewed, and incorporate the principles of least privilege and separation of duties."
  children = [
    control.denylist_public_users,
    control.iam_api_key_age_90,
    control.iam_api_key_restricts_apis,
    control.iam_api_key_restricts_websites_hosts_apps,
    control.iam_restrict_service_account_key_age_one_hundred_days,
    control.iam_service_account_gcp_managed_key,
    control.iam_service_account_key_age_90,
    control.iam_service_account_without_admin_privilege,
    control.iam_user_kms_separation_of_duty_enforced,
    control.iam_user_not_assigned_service_account_user_role_project_level,
    control.iam_user_separation_of_duty_enforced,
    control.logging_metric_alert_storage_iam_permission_changes
  ]
}

benchmark "nist_csf_v2_pr_aa_06" {
  title       = "PR.AA-06"
  description = "Physical access to assets is managed, monitored, and enforced commensurate with risk."
  children = [
    control.project_access_approval_settings_enabled
  ]
}

benchmark "nist_csf_v2_pr_ds" {
  title       = "PR.DS"
  description = "Data Security (PR.DS): Data are managed consistent with the organization's risk strategy to protect the confidentiality, integrity, and availability of information."
  children = [
    benchmark.nist_csf_v2_pr_ds_01,
    benchmark.nist_csf_v2_pr_ds_02,
    benchmark.nist_csf_v2_pr_ds_10,
    benchmark.nist_csf_v2_pr_ds_11
  ]
}

benchmark "nist_csf_v2_pr_ds_01" {
  title       = "PR.DS-01"
  description = "The confidentiality, integrity, and availability of data-at-rest are protected."
  children = [
    control.cmek_rotation_one_hundred_days,
    control.compute_disk_encrypted_with_csk,
    control.dataproc_cluster_encryption_with_cmek,
    control.kms_key_not_publicly_accessible,
    control.kms_key_rotated_within_90_day,
    control.kms_key_separation_of_duties_enforced,
    control.kms_key_users_limited_to_3,
    control.sql_instance_automated_backups_enabled,
    control.sql_instance_not_publicly_accessible,
    control.sql_instance_postgresql_cloudsql_pgaudit_database_flag_enabled,
    control.storage_bucket_log_object_versioning_enabled,
    control.storage_bucket_log_retention_policy_enabled,
    control.storage_bucket_not_publicly_accessible
  ]
}

benchmark "nist_csf_v2_pr_ds_02" {
  title       = "PR.DS-02"
  description = "The confidentiality, integrity, and availability of data-in-transit are protected."
  children = [
    control.compute_firewall_default_rule_restrict_ingress_access_except_http_and_https,
    control.compute_https_load_balancer_logging_enabled,
    control.compute_ssl_policy_with_no_weak_cipher,
    control.compute_target_https_uses_latest_tls_version,
    control.require_ssl_sql
  ]
}

benchmark "nist_csf_v2_pr_ds_10" {
  title       = "PR.DS-10"
  description = "The confidentiality, integrity, and availability of data-in-use are protected."
  children = [
    control.compute_instance_confidential_computing_enabled,
    control.kubernetes_cluster_shielded_instance_integrity_monitoring_enabled
  ]
}

benchmark "nist_csf_v2_pr_ds_11" {
  title       = "PR.DS-11"
  description = "Backups of data are created, protected, maintained, and tested."
  children = [
    control.logging_bucket_retention_policy_enabled,
    control.sql_instance_automated_backups_enabled,
    control.storage_bucket_log_object_versioning_enabled,
    control.storage_bucket_log_retention_policy_enabled,
    control.storage_bucket_log_retention_policy_lock_enabled
  ]
}

benchmark "nist_csf_v2_pr_ps" {
  title       = "PR.PS"
  description = "Platform Security (PR.PS): The hardware, software (e.g., firmware, operating systems, applications), and services of physical and virtual platforms are managed consistent with the organization's risk strategy to protect their confidentiality, integrity, and availability."
  children = [
    benchmark.nist_csf_v2_pr_ps_01,
    benchmark.nist_csf_v2_pr_ps_02,
    benchmark.nist_csf_v2_pr_ps_03,
    benchmark.nist_csf_v2_pr_ps_04,
    benchmark.nist_csf_v2_pr_ps_05,
    benchmark.nist_csf_v2_pr_ps_06
  ]
}

benchmark "nist_csf_v2_pr_ps_01" {
  title       = "PR.PS-01"
  description = "Configuration management practices are established and applied."
  children = [
    control.compute_instance_oslogin_enabled,
    control.kubernetes_cluster_binary_authorization_enabled,
    control.kubernetes_cluster_shielded_instance_integrity_monitoring_enabled,
    control.kubernetes_cluster_shielded_node_secure_boot_enabled,
    control.kubernetes_cluster_shielded_nodes_enabled,
    control.logging_metric_alert_audit_configuration_changes,
    control.logging_metric_alert_sql_instance_configuration_changes
  ]
}

benchmark "nist_csf_v2_pr_ps_02" {
  title       = "PR.PS-02"
  description = "Software is maintained, replaced, and removed commensurate with risk."
  children = [
    control.enable_auto_repair,
    control.enable_auto_upgrade,
    control.kubernetes_cluster_with_less_than_three_node_auto_upgrade_enabled
  ]
}

benchmark "nist_csf_v2_pr_ps_03" {
  title       = "PR.PS-03"
  description = "Hardware is maintained, replaced, and removed commensurate with risk."
  children = [
    control.kubernetes_cluster_shielded_instance_integrity_monitoring_enabled,
    control.kubernetes_cluster_shielded_node_secure_boot_enabled,
    control.kubernetes_cluster_shielded_nodes_enabled
  ]
}

benchmark "nist_csf_v2_pr_ps_04" {
  title       = "PR.PS-04"
  description = "Log records are generated and made available for continuous monitoring."
  children = [
    control.compute_firewall_rule_logging_enabled,
    control.compute_https_load_balancer_logging_enabled,
    control.compute_network_dns_logging_enabled,
    control.enable_network_flow_logs,
    control.kubernetes_cluster_logging_enabled,
    control.kubernetes_cluster_monitoring_enabled,
    control.logging_bucket_retention_policy_enabled,
    control.logging_metric_alert_audit_configuration_changes,
    control.logging_metric_alert_custom_role_changes_with_iam_admin_undelete_role,
    control.logging_metric_alert_custom_role_changes,
    control.logging_metric_alert_firewall_rule_changes,
    control.logging_metric_alert_network_changes,
    control.logging_metric_alert_network_route_changes,
    control.logging_metric_alert_project_ownership_assignment,
    control.logging_metric_alert_sql_instance_configuration_changes,
    control.logging_metric_alert_storage_iam_permission_changes,
    control.logging_sink_configured_for_all_resource,
    control.storage_bucket_log_object_versioning_enabled,
    control.storage_bucket_log_retention_policy_enabled,
    control.storage_bucket_log_retention_policy_lock_enabled
  ]
}

benchmark "nist_csf_v2_pr_ps_05" {
  title       = "PR.PS-05"
  description = "Installation and execution of unauthorized software are prevented."
  children = [
    control.kubernetes_cluster_binary_authorization_enabled,
    control.kubernetes_cluster_shielded_node_secure_boot_enabled,
    control.kubernetes_cluster_shielded_nodes_enabled
  ]
}

benchmark "nist_csf_v2_pr_ps_06" {
  title       = "PR.PS-06"
  description = "Secure software development practices are integrated, and their performance is monitored throughout the software development life cycle."
  children = [
    control.kubernetes_cluster_binary_authorization_enabled,
    control.project_service_container_scanning_api_enabled
  ]
}

benchmark "nist_csf_v2_pr_ir" {
  title       = "PR.IR"
  description = "Technology Infrastructure Resilience (PR.IR): Security architectures are managed with the organization's risk strategy to protect asset confidentiality, integrity, and availability, and organizational resilience."
  children = [
    benchmark.nist_csf_v2_pr_ir_01,
    benchmark.nist_csf_v2_pr_ir_02,
    benchmark.nist_csf_v2_pr_ir_03,
    benchmark.nist_csf_v2_pr_ir_04
  ]
}

benchmark "nist_csf_v2_pr_ir_01" {
  title       = "PR.IR-01"
  description = "Networks and environments are protected from unauthorized logical access and usage."
  children = [
    control.cloudfunction_function_vpc_connector_enabled,
    control.compute_firewall_allow_connections_proxied_by_iap,
    control.compute_firewall_allow_tcp_connections_proxied_by_iap,
    control.compute_firewall_default_rule_restrict_ingress_access_except_http_and_https,
    control.compute_firewall_rule_ingress_access_restricted_to_dns_port_53,
    control.compute_firewall_rule_ingress_access_restricted_to_ftp_port_21,
    control.compute_firewall_rule_ingress_access_restricted_to_http_port_80,
    control.compute_firewall_rule_ingress_access_restricted_to_microsoft_ds_port_445,
    control.compute_firewall_rule_ingress_access_restricted_to_mongo_db_port_27017,
    control.compute_firewall_rule_ingress_access_restricted_to_mysql_db_port_3306,
    control.compute_firewall_rule_ingress_access_restricted_to_netbios_snn_port_139,
    control.compute_firewall_rule_ingress_access_restricted_to_oracle_db_port_1521,
    control.compute_firewall_rule_ingress_access_restricted_to_pop3_port_110,
    control.compute_firewall_rule_ingress_access_restricted_to_postgresql_port_10250,
    control.compute_firewall_rule_ingress_access_restricted_to_postgresql_port_10255,
    control.compute_firewall_rule_ingress_access_restricted_to_postgresql_port_5432,
    control.compute_firewall_rule_ingress_access_restricted_to_smtp_port_25,
    control.compute_firewall_rule_ingress_access_restricted_to_tcp_port_137_to_139,
    control.compute_firewall_rule_ingress_access_restricted_to_tcp_port_27017_to_27019,
    control.compute_firewall_rule_ingress_access_restricted_to_tcp_port_61620_61621,
    control.compute_firewall_rule_ingress_access_restricted_to_tcp_port_636,
    control.compute_firewall_rule_ingress_access_restricted_to_tcp_port_6379,
    control.compute_firewall_rule_ingress_access_restricted_to_tcp_port_7000_7001,
    control.compute_firewall_rule_ingress_access_restricted_to_tcp_port_7199,
    control.compute_firewall_rule_ingress_access_restricted_to_tcp_port_8888,
    control.compute_firewall_rule_ingress_access_restricted_to_tcp_port_9042,
    control.compute_firewall_rule_ingress_access_restricted_to_tcp_port_9090,
    control.compute_firewall_rule_ingress_access_restricted_to_tcp_port_9160,
    control.compute_firewall_rule_ingress_access_restricted_to_tcp_port_9200_9300,
    control.compute_firewall_rule_ingress_access_restricted_to_tcp_udp_port_11211,
    control.compute_firewall_rule_ingress_access_restricted_to_tcp_udp_port_11214_to_11215,
    control.compute_firewall_rule_ingress_access_restricted_to_tcp_udp_port_2483_to_2484,
    control.compute_firewall_rule_ingress_access_restricted_to_tcp_udp_port_389,
    control.compute_firewall_rule_ingress_access_restricted_to_telnet_port_23,
    control.compute_firewall_rule_logging_enabled,
    control.compute_firewall_rule_restrict_ingress_all_with_no_specific_target,
    control.compute_firewall_rule_restrict_ingress_all,
    control.compute_network_auto_create_subnetwork_enabled,
    control.compute_network_contains_no_default_network,
    control.compute_network_contains_no_legacy_network,
    control.compute_network_dns_logging_enabled,
    control.enable_gke_master_authorized_networks,
    control.enable_network_flow_logs,
    control.enable_network_private_google_access,
    control.kubernetes_cluster_network_policy_enabled,
    control.kubernetes_cluster_no_default_network,
    control.kubernetes_cluster_private_nodes_configured,
    control.kubernetes_cluster_subnetwork_private_ip_google_access_enabled,
    control.logging_metric_alert_firewall_rule_changes,
    control.logging_metric_alert_network_changes,
    control.logging_metric_alert_network_route_changes,
    control.restrict_firewall_rule_rdp_world_open,
    control.restrict_firewall_rule_ssh_world_open,
    control.restrict_firewall_rule_world_open_tcp_udp_all_ports
  ]
}

benchmark "nist_csf_v2_pr_ir_02" {
  title       = "PR.IR-02"
  description = "The organization's technology assets are protected from environmental threats."
  children = [
    control.compute_instance_shielded_vm_enabled,
    control.kubernetes_cluster_shielded_instance_integrity_monitoring_enabled,
    control.kubernetes_cluster_shielded_node_secure_boot_enabled,
    control.kubernetes_cluster_shielded_nodes_enabled,
    control.sql_instance_automated_backups_enabled,
    control.storage_bucket_log_object_versioning_enabled,
    control.storage_bucket_log_retention_policy_enabled,
    control.storage_bucket_log_retention_policy_lock_enabled
  ]
}

benchmark "nist_csf_v2_pr_ir_03" {
  title       = "PR.IR-03"
  description = "Mechanisms are implemented to achieve resilience requirements in normal and adverse situations."
  children = [
    control.compute_instance_shielded_vm_enabled,
    control.enable_auto_repair,
    control.enable_auto_upgrade,
    control.kubernetes_cluster_shielded_instance_integrity_monitoring_enabled,
    control.kubernetes_cluster_shielded_node_secure_boot_enabled,
    control.kubernetes_cluster_shielded_nodes_enabled,
    control.kubernetes_cluster_with_less_than_three_node_auto_upgrade_enabled,
    control.logging_bucket_retention_policy_enabled,
    control.sql_instance_automated_backups_enabled,
    control.storage_bucket_log_object_versioning_enabled,
    control.storage_bucket_log_retention_policy_enabled,
    control.storage_bucket_log_retention_policy_lock_enabled
  ]
}

benchmark "nist_csf_v2_pr_ir_04" {
  title       = "PR.IR-04"
  description = "Adequate resource capacity to ensure availability is maintained."
  children = [
    control.enable_auto_repair,
    control.enable_auto_upgrade,
    control.kubernetes_cluster_with_less_than_three_node_auto_upgrade_enabled,
    control.sql_instance_automated_backups_enabled,
    control.storage_bucket_log_object_versioning_enabled,
    control.storage_bucket_log_retention_policy_enabled,
    control.storage_bucket_log_retention_policy_lock_enabled
  ]
}