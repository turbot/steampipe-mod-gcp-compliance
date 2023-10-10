locals {
  all_controls_compute_common_tags = merge(local.all_controls_common_tags, {
    service = "GCP/Compute"
  })
}

benchmark "all_controls_compute" {
  title       = "Compute"
  description = "This section contains recommendations for configuring Compute resources."
  children = [
    control.compute_disk_encrypted_with_csk,
    control.compute_firewall_allow_connections_proxied_by_iap,
    control.compute_firewall_allow_tcp_connections_proxied_by_iap,
    control.compute_https_load_balancer_logging_enabled,
    control.compute_instance_block_project_wide_ssh_enabled,
    control.compute_instance_confidential_computing_enabled,
    control.compute_instance_ip_forwarding_disabled,
    control.compute_instance_oslogin_enabled,
    control.compute_instance_serial_port_connection_disabled,
    control.compute_instance_shielded_vm_enabled,
    control.compute_instance_with_no_default_service_account_with_full_access,
    control.compute_instance_with_no_default_service_account,
    control.compute_instance_with_no_public_ip_addresses,
    control.compute_network_contains_no_default_network,
    control.compute_network_contains_no_legacy_network,
    control.compute_network_dns_logging_enabled,
    control.compute_ssl_policy_with_no_weak_cipher,
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
