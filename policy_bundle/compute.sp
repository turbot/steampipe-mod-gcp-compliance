locals {
  policy_bundle_compute_common_tags = merge(local.gcp_compliance_common_tags, {
    service = "GCP/Compute"
  })
}

control "restrict_firewall_rule_world_open" {
  title = "Check for open firewall rules allowing ingress from the internet"
  query = query.compute_firewall_rule_ssh_access_restricted.sql

  tags = merge(local.policy_bundle_compute_common_tags, {
    cft_scorecard_v1      = "true"
    forseti_security_v226 = "true"
    severity              = "high"
  })
}

control "restrict_firewall_rule_rdp_world_open" {
  title = "Check for open firewall rules allowing RDP from the internet"
  query = query.compute_firewall_rule_rdp_access_restricted.sql

  tags = merge(local.policy_bundle_compute_common_tags, {
    cft_scorecard_v1 = "true"
    severity         = "high"
  })
}

control "enable_network_flow_logs" {
  title = "Ensure VPC Flow logs is enabled for every subnet in VPC Network"
  query = query.compute_subnetwork_flow_log_enabled.sql

  tags = merge(local.policy_bundle_compute_common_tags, {
    cft_scorecard_v1 = "true"
    severity         = "high"
  })
}

control "enable_network_private_google_access" {
  title = "Ensure Private Google Access is enabled for all subnetworks in VPC"
  query = query.compute_subnetwork_private_ip_google_access.sql

  tags = merge(local.policy_bundle_compute_common_tags, {
    cft_scorecard_v1 = "true"
    severity         = "high"
  })
}

control "restrict_firewall_rule_ssh_world_open" {
  title = "Check for open firewall rules allowing SSH from the internet"
  query = query.compute_firewall_rule_ssh_access_restricted.sql

  tags = merge(local.policy_bundle_compute_common_tags, {
    cft_scorecard_v1 = "true"
    severity         = "high"
  })
}

control "restrict_firewall_rule_world_open_tcp_udp_all_ports" {
  title = "Check for open firewall rules allowing TCP/UDP from the internet"
  query = query.compute_firewall_rule_rdp_access_restricted.sql

  tags = merge(local.policy_bundle_compute_common_tags, {
    forseti_security_v226 = "true"
    severity              = "high"
  })
}
