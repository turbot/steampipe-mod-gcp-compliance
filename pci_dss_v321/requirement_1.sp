locals {
  pci_dss_v321_requirement_1_common_tags = merge(local.pci_dss_v321_common_tags, {
    control_set = "1"
  })
}

benchmark "pci_dss_v321_requirement_1" {
  title       = "Requirement 1:  Install and maintain a firewall configuration to protect cardholder data"
  description = "This first requirement ensures that service providers and merchants maintain a secure network through the proper configuration of a firewall as well as routers if applicable. Properly configured firewalls protect your card data environment. Firewalls restrict incoming and outgoing network traffic through rules and criteria configured by your organization. Firewalls provide the first line of protection for your network. Organizations should establish firewalls and router standards, which allow for a standardized process for allowing or denying access rules to the network. Configuration rules should be reviewed bi-annually and ensure that there are no insecure access rules which can allow access to the card data environment."

  children = [
    benchmark.pci_dss_v321_requirement_1_2,
    benchmark.pci_dss_v321_requirement_1_3
  ]

  tags = local.pci_dss_v321_requirement_1_common_tags
}

benchmark "pci_dss_v321_requirement_1_2" {
  title       = "1.2 Build firewall and router configurations that restrict connections between untrusted networks and any system components in the cardholder data environment"
  description = "Customers are responsible for implementing firewall rules and limiting ingress and egress traffic to defined ports and protocols necessary for GCE instances and denying all other traffic."

  children = [
    benchmark.pci_dss_v321_requirement_1_2_1
  ]

  tags = merge(local.pci_dss_v321_requirement_1_common_tags, {
    pci_dss_v321_item_id = "1.2"
  })
}

benchmark "pci_dss_v321_requirement_1_2_1" {
  title       = "1.2.1  Restrict inbound and outbound traffic to that which is necessary for the cardholder data environment, and specifically deny all other traffic."
  description = "Customers are responsible for implementing GCP firewall rules and limiting inbound/outbound traffic to only business justified and necessary traffic. Customers must define explicit GCP firewall rules and deny all other traffic. Customers are responsible for verifying inbound and outbound traffic for their CDE which includes GCP GCE and GCS, and GCP VPCs. Customers are responsible for denying any traffic that is not explicitly required for the GCP Product to function."

  children = [
    control.compute_firewall_rule_restrict_ingress_all,
    control.compute_firewall_rule_ingress_access_restricted_to_tcp_port_9090,
    control.compute_firewall_rule_ingress_access_restricted_to_microsoft_ds_port_445,
    control.restrict_firewall_rule_world_open_tcp_udp_all_ports,
    control.restrict_firewall_rule_ssh_world_open,
    control.compute_firewall_rule_ingress_access_restricted_to_telnet_port_23,
    control.compute_firewall_rule_ingress_access_restricted_to_dns_port_53,
    control.compute_firewall_rule_ingress_access_restricted_to_ftp_port_21,
    control.compute_firewall_rule_ingress_access_restricted_to_http_port_80,
    control.compute_firewall_rule_ingress_access_restricted_to_mysql_db_port_3306,
    control.compute_firewall_rule_ingress_access_restricted_to_pop3_port_110,
    control.compute_firewall_rule_ingress_access_restricted_to_postgresql_port_5432,
    control.compute_firewall_rule_ingress_access_restricted_to_smtp_port_25,
    control.compute_instance_with_no_public_ip_addresses,
    control.compute_firewall_rule_ingress_access_restricted_to_tcp_port_9200_9300,
    control.compute_firewall_rule_ingress_access_restricted_to_tcp_port_7000_7001,
    control.compute_firewall_rule_ingress_access_restricted_to_tcp_port_7199,
    control.compute_firewall_rule_ingress_access_restricted_to_tcp_port_8888,
    control.compute_firewall_rule_ingress_access_restricted_to_tcp_port_9042,
    control.compute_firewall_rule_ingress_access_restricted_to_tcp_port_9160,
    control.compute_firewall_rule_ingress_access_restricted_to_tcp_port_61620_61621,
    control.compute_firewall_rule_ingress_access_restricted_to_tcp_port_6379,
    control.compute_firewall_rule_ingress_access_restricted_to_tcp_port_137_to_139,
    control.compute_firewall_rule_ingress_access_restricted_to_tcp_port_27017_to_27019,
    control.compute_firewall_rule_ingress_access_restricted_to_tcp_port_636,
    control.compute_firewall_rule_ingress_access_restricted_to_tcp_udp_port_389,
    control.compute_firewall_rule_ingress_access_restricted_to_tcp_udp_port_11211,
    control.compute_firewall_rule_ingress_access_restricted_to_tcp_udp_port_11214_to_11215,
    control.compute_firewall_rule_ingress_access_restricted_to_tcp_udp_port_2483_to_2484,
    control.compute_firewall_rule_ingress_access_restricted_to_oracle_db_port_1521,
    control.enable_gke_master_authorized_networks,
    control.sql_instance_not_publicly_accessible,
  ]

  tags = merge(local.pci_dss_v321_requirement_1_common_tags, {
    pci_dss_v321_item_id = "1.2.1"
  })
}


benchmark "pci_dss_v321_requirement_1_3" {
  title       = "1.3  Prohibit direct public access between the Internet and any system component in the cardholder data environment"
  description = "Customers are responsible for implementing firewall rules and limiting ingress traffic to defined ports and protocols necessary for GCE instances within their DMZ."

  children = [
    benchmark.pci_dss_v321_requirement_1_3_2,
    benchmark.pci_dss_v321_requirement_1_3_4,
    benchmark.pci_dss_v321_requirement_1_3_7,
    control.kubernetes_cluster_network_policy_enabled,
    control.kubernetes_cluster_subnetwork_private_ip_google_access_enabled,
  ]

  tags = merge(local.pci_dss_v321_requirement_4_common_tags, {
    pci_dss_v321_item_id = "1.3"
  })
}

benchmark "pci_dss_v321_requirement_1_3_2" {
  title       = "1.3.2 Limit inbound Internet traffic to IP addresses within the DMZ."
  description = "Customers are responsible for implementing firewall rules and limiting ingress traffic to defined ports and protocols necessary for GCE instances within their DMZ."

  children = [
    control.enable_gke_master_authorized_networks,
    control.allow_only_private_cluster
  ]

  tags = merge(local.pci_dss_v321_requirement_4_common_tags, {
    pci_dss_v321_item_id = "1.3.2"
  })
}

benchmark "pci_dss_v321_requirement_1_3_4" {
  title       = "1.3.4 Do not allow unauthorized outbound traffic from the cardholder data environment to the Internet"
  description = "Customers are responsible for implementing perimeter firewalls and configuring firewall rules and ACLs for their in-scope GCP Products. Customers are responsible for developing appropriate firewall rules or using additional firewall technologies to develop appropriate DMZ and internal networks."

  children = [
    control.enable_alias_ip_ranges
  ]

  tags = merge(local.pci_dss_v321_requirement_4_common_tags, {
    pci_dss_v321_item_id = "1.3.4"
  })
}


benchmark "pci_dss_v321_requirement_1_3_7" {
  title       = "1.3.7 Do not disclose private IP addresses and routing information to unauthorized parties"
  description = "Customers are responsible for developing appropriate configuration on GCP GCE to prevent the disclosure of IP Addresses and routing information."

  children = [
    control.enable_alias_ip_ranges
  ]

  tags = merge(local.pci_dss_v321_requirement_4_common_tags, {
    pci_dss_v321_item_id = "1.3.2"
  })
}