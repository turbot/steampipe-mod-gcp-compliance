locals {
  all_controls_compute_common_tags = merge(local.all_controls_common_tags, {
    service = "GCP/Compute"
  })
}

benchmark "all_controls_compute" {
  title       = "Compute"
  description = "This section contains recommendations for configuring Compute resources."
  children = [
    control.compute_backend_bucket_no_dangling_storage_bucket,
    control.compute_disk_encrypted_with_csk,
    control.compute_external_backend_service_iap_enabled,
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
    control.compute_firewall_rule_ingress_access_restricted_to_telnet_port_23,
    control.compute_firewall_rule_restrict_ingress_all,
    control.compute_firewall_rule_restrict_ingress_all_with_no_specific_target,
    control.compute_https_load_balancer_logging_enabled,
    control.compute_instance_block_project_wide_ssh_enabled,
    control.compute_instance_confidential_computing_enabled,
    control.compute_instance_ip_forwarding_disabled,
    control.compute_instance_no_data_destruction_permission,
    control.compute_instance_no_database_write_permission,
    control.compute_instance_no_deployments_manager_permission,
    control.compute_instance_no_disrupt_logging_permission,
    control.compute_instance_no_iam_write_permission,
    control.compute_instance_no_service_account_impersonate_permission,
    control.compute_instance_no_write_permission_on_deny_policy,
    control.compute_instance_oslogin_enabled,
    control.compute_instance_preemptible_termination_disabled,
    control.compute_instance_serial_port_connection_disabled,
    control.compute_instance_shielded_vm_enabled,
    control.compute_instance_template_ip_forwarding_disabled,
    control.compute_instance_with_custom_metadata,
    control.compute_instance_with_no_default_service_account,
    control.compute_instance_with_no_default_service_account_with_full_access,
    control.compute_instance_with_no_public_ip_addresses,
    control.compute_instance_wth_no_high_level_basic_role,
    control.compute_network_auto_create_subnetwork_enabled,
    control.compute_network_contains_no_default_network,
    control.compute_network_contains_no_legacy_network,
    control.compute_network_dns_logging_enabled,
    control.compute_ssl_policy_with_no_weak_cipher,
    control.compute_target_https_proxy_quic_protocol_enabled,
    control.compute_target_https_proxy_quic_protocol_no_default_ssl_policy,
    control.compute_target_https_uses_latest_tls_version,
    control.enable_network_flow_logs,
    control.enable_network_private_google_access,
    control.restrict_firewall_rule_rdp_world_open,
    control.restrict_firewall_rule_ssh_world_open,
    control.restrict_firewall_rule_world_open_tcp_udp_all_ports
  ]

  tags = merge(local.all_controls_compute_common_tags, {
    type = "Benchmark"
  })
}
