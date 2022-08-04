locals {
  cis_v120_3_common_tags = merge(local.cis_v130_common_tags, {
    cis_section_id = "3"
  })
}

benchmark "cis_v120_3" {
  title         = "3 Networking"
  documentation = file("./cis_v120/docs/cis_v120_3.md")
  children = [
    control.cis_v120_3_1,
    control.cis_v120_3_2,
    control.cis_v120_3_3,
    control.cis_v120_3_4,
    control.cis_v120_3_5,
    control.cis_v120_3_6,
    control.cis_v120_3_7,
    control.cis_v120_3_8,
    control.cis_v120_3_9,
    control.cis_v120_3_10
  ]

  tags = merge(local.cis_v120_3_common_tags, {
    type = "Benchmark"
  })
}

control "cis_v120_3_1" {
  title         = "3.1 Ensure that the default network does not exist in a project"
  description   = "To prevent use of default network, a project should not have a default network."
  sql           = query.compute_network_contains_no_default_network.sql
  documentation = file("./cis_v120/docs/cis_v120_3_1.md")

  tags = merge(local.cis_v120_3_common_tags, {
    cis_item_id = "3.1"
    cis_level   = "2"
    cis_type    = "automated"
    service     = "GCP/Compute"
  })
}

control "cis_v120_3_2" {
  title         = "3.2 Ensure legacy networks do not exist for a project"
  description   = "In order to prevent use of legacy networks, a project should not have a legacy network configured."
  sql           = query.compute_network_contains_no_legacy_network.sql
  documentation = file("./cis_v120/docs/cis_v120_3_2.md")

  tags = merge(local.cis_v120_3_common_tags, {
    cis_item_id = "3.2"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/Compute"
  })
}

control "cis_v120_3_3" {
  title         = "3.3 Ensure that DNSSEC is enabled for Cloud DNS"
  description   = "Cloud Domain Name System (DNS) is a fast, reliable and cost-effective domain name system that powers millions of domains on the internet. Domain Name System Security Extensions (DNSSEC) in Cloud DNS enables domain owners to take easy steps to protect their domains against DNS hijacking and man-in-the-middle and other attacks."
  sql           = query.dns_managed_zone_dnssec_enabled.sql
  documentation = file("./cis_v120/docs/cis_v120_3_3.md")

  tags = merge(local.cis_v120_3_common_tags, {
    cis_item_id = "3.3"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/DNS"
  })
}

control "cis_v120_3_4" {
  title         = "3.4 Ensure that RSASHA1 is not used for the key-signing key in Cloud DNS DNSSEC"
  description   = "DNSSEC algorithm numbers in this registry may be used in CERT RRs. Zone signing (DNSSEC) and transaction security mechanisms (SIG(0) and TSIG) make use of particular subsets of these algorithms. The algorithm used for key signing should be a recommended one and it should be strong."
  sql           = query.dns_managed_zone_key_signing_not_using_rsasha1.sql
  documentation = file("./cis_v120/docs/cis_v120_3_4.md")

  tags = merge(local.cis_v120_3_common_tags, {
    cis_item_id = "3.4"
    cis_level   = "1"
    cis_type    = "manual"
    service     = "GCP/DNS"
  })
}

control "cis_v120_3_5" {
  title         = "3.5 Ensure that RSASHA1 is not used for the zone-signing key in Cloud DNS DNSSEC"
  description   = "DNSSEC algorithm numbers in this registry may be used in CERT RRs. Zone signing (DNSSEC) and transaction security mechanisms (SIG(0) and TSIG) make use of particular subsets of these algorithms. The algorithm used for key signing should be a recommended one and it should be strong."
  sql           = query.dns_managed_zone_zone_signing_not_using_rsasha1.sql
  documentation = file("./cis_v120/docs/cis_v120_3_5.md")

  tags = merge(local.cis_v120_3_common_tags, {
    cis_item_id = "3.5"
    cis_level   = "1"
    cis_type    = "manual"
    service     = "GCP/DNS"
  })
}

control "cis_v120_3_6" {
  title         = "3.6 Ensure that SSH access is restricted from the internet"
  description   = "GCP Firewall Rules are specific to a VPC Network. Each rule either allows or denies traffic when its conditions are met. Its conditions allow the user to specify the type of traffic, such as ports and protocols, and the source or destination of the traffic, including IP addresses, subnets, and instances."
  sql           = query.compute_firewall_rule_ssh_access_restricted.sql
  documentation = file("./cis_v120/docs/cis_v120_3_6.md")

  tags = merge(local.cis_v120_3_common_tags, {
    cis_item_id = "3.6"
    cis_level   = "2"
    cis_type    = "automated"
    service     = "GCP/Compute"
  })
}

control "cis_v120_3_7" {
  title         = "3.7 Ensure that RDP access is restricted from the Internet"
  description   = "GCP Firewall Rules are specific to a VPC Network. Each rule either allows or denies traffic when its conditions are met. Its conditions allow users to specify the type of traffic, such as ports and protocols, and the source or destination of the traffic, including IP addresses, subnets, and instances."
  sql           = query.compute_firewall_rule_rdp_access_restricted.sql
  documentation = file("./cis_v120/docs/cis_v120_3_7.md")

  tags = merge(local.cis_v120_3_common_tags, {
    cis_item_id = "3.7"
    cis_level   = "2"
    cis_type    = "automated"
    service     = "GCP/Compute"
  })
}

control "cis_v120_3_8" {
  title         = "3.8 Ensure that VPC Flow Logs is enabled for every subnet in a VPC Network"
  description   = "Flow Logs is a feature that enables users to capture information about the IP traffic going to and from network interfaces in the organization's VPC Subnets. Once a flow log is created, the user can view and retrieve its data in Stackdriver Logging. It is recommended that Flow Logs be enabled for every business-critical VPC subnet."
  sql           = query.compute_subnetwork_flow_log_enabled.sql
  documentation = file("./cis_v120/docs/cis_v120_3_8.md")

  tags = merge(local.cis_v120_3_common_tags, {
    cis_item_id = "3.8"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/Compute"
  })
}

control "cis_v120_3_9" {
  title         = "3.9 Ensure no HTTPS or SSL proxy load balancers permit SSL policies with weak cipher suites"
  description   = "Secure Sockets Layer (SSL) policies determine what port Transport Layer Security (TLS) features clients are permitted to use when connecting to load balancers."
  sql           = query.compute_ssl_policy_with_no_weak_cipher.sql
  documentation = file("./cis_v120/docs/cis_v120_3_9.md")

  tags = merge(local.cis_v120_3_common_tags, {
    cis_item_id = "3.9"
    cis_level   = "1"
    cis_type    = "manual"
    service     = "GCP/Compute"
  })
}

control "cis_v120_3_10" {
  title         = "3.10 Ensure Firewall Rules for instances behind Identity Aware Proxy (IAP) only allow the traffic from Google Cloud Loadbalancer (GCLB) Health Check and Proxy Addresses"
  description   = "Access to VMs should be restricted by firewall rules that allow only IAP traffic by ensuring only connections proxied by the IAP are allowed. To ensure that load balancing works correctly health checks should also be allowed."
  sql           = query.compute_firewall_allow_connections_proxied_by_iap.sql
  documentation = file("./cis_v120/docs/cis_v120_3_10.md")

  tags = merge(local.cis_v120_3_common_tags, {
    cis_item_id = "3.10"
    cis_level   = "2"
    cis_type    = "manual"
    service     = "GCP/Compute"
  })
}
