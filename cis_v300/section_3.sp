locals {
  cis_v300_3_common_tags = merge(local.cis_v300_common_tags, {
    cis_section_id = "3"
  })
}

benchmark "cis_v300_3" {
  title         = "3 Networking"
  documentation = file("./cis_v300/docs/cis_v300_3.md")
  children = [
    control.cis_v300_3_1,
    control.cis_v300_3_2,
    control.cis_v300_3_3,
    control.cis_v300_3_4,
    control.cis_v300_3_5,
    control.cis_v300_3_6,
    control.cis_v300_3_7,
    control.cis_v300_3_8,
    control.cis_v300_3_9,
    control.cis_v300_3_10
  ]

  tags = merge(local.cis_v300_3_common_tags, {
    type = "Benchmark"
  })
}

control "cis_v300_3_1" {
  title         = "3.1 Ensure That the Default Network Does Not Exist in a Project"
  description   = "To prevent use of default network, a project should not have a default network."
  query         = query.compute_network_contains_no_default_network
  documentation = file("./cis_v300/docs/cis_v300_3_1.md")

  tags = merge(local.cis_v300_3_common_tags, {
    cis_item_id = "3.1"
    cis_level   = "2"
    cis_type    = "automated"
    service     = "GCP/Compute"
  })
}

control "cis_v300_3_2" {
  title         = "3.2 Ensure Legacy Networks Do Not Exist for Older Projects"
  description   = "In order to prevent use of legacy networks, a project should not have a legacy network configured."
  query         = query.compute_network_contains_no_legacy_network
  documentation = file("./cis_v300/docs/cis_v300_3_2.md")

  tags = merge(local.cis_v300_3_common_tags, {
    cis_item_id = "3.2"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/Compute"
  })
}

control "cis_v300_3_3" {
  title         = "3.3 Ensure That DNSSEC Is Enabled for Cloud DNS"
  description   = "Cloud Domain Name System (DNS) is a fast, reliable and cost-effective domain name system that powers millions of domains on the internet. Domain Name System Security Extensions (DNSSEC) in Cloud DNS enables domain owners to take easy steps to protect their domains against DNS hijacking and man-in-the-middle and other attacks."
  query         = query.dns_managed_zone_dnssec_enabled
  documentation = file("./cis_v300/docs/cis_v300_3_3.md")

  tags = merge(local.cis_v300_3_common_tags, {
    cis_item_id = "3.3"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/DNS"
  })
}

control "cis_v300_3_4" {
  title         = "3.4 Ensure That RSASHA1 Is Not Used for the Key-Signing Key in Cloud DNS DNSSEC"
  description   = "DNSSEC algorithm numbers in this registry may be used in CERT RRs. Zone signing (DNSSEC) and transaction security mechanisms (SIG(0) and TSIG) make use of particular subsets of these algorithms. The algorithm used for key signing should be a recommended one and it should be strong."
  query         = query.dns_managed_zone_key_signing_not_using_rsasha1
  documentation = file("./cis_v300/docs/cis_v300_3_4.md")

  tags = merge(local.cis_v300_3_common_tags, {
    cis_item_id = "3.4"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/DNS"
  })
}

control "cis_v300_3_5" {
  title         = "3.5 Ensure That RSASHA1 Is Not Used for the Zone-Signing Key in Cloud DNS DNSSEC"
  description   = "DNSSEC algorithm numbers in this registry may be used in CERT RRs. Zone signing (DNSSEC) and transaction security mechanisms (SIG(0) and TSIG) make use of particular subsets of these algorithms. The algorithm used for key signing should be a recommended one and it should be strong."
  query         = query.dns_managed_zone_zone_signing_not_using_rsasha1
  documentation = file("./cis_v300/docs/cis_v300_3_5.md")

  tags = merge(local.cis_v300_3_common_tags, {
    cis_item_id = "3.5"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/DNS"
  })
}

control "cis_v300_3_6" {
  title         = "3.6 Ensure That SSH Access Is Restricted From the Internet"
  description   = "GCP Firewall Rules are specific to a VPC Network. Each rule either allows or denies traffic when its conditions are met. Its conditions allow the user to specify the type of traffic, such as ports and protocols, and the source or destination of the traffic, including IP addresses, subnets, and instances."
  query         = query.compute_firewall_rule_ssh_access_restricted
  documentation = file("./cis_v300/docs/cis_v300_3_6.md")

  tags = merge(local.cis_v300_3_common_tags, {
    cis_item_id = "3.6"
    cis_level   = "2"
    cis_type    = "automated"
    service     = "GCP/Compute"
  })
}

control "cis_v300_3_7" {
  title         = "3.7 Ensure That RDP Access Is Restricted From the Internet "
  description   = "GCP Firewall Rules are specific to a VPC Network. Each rule either allows or denies traffic when its conditions are met. Its conditions allow users to specify the type of traffic, such as ports and protocols, and the source or destination of the traffic, including IP addresses, subnets, and instances."
  query         = query.compute_firewall_rule_rdp_access_restricted
  documentation = file("./cis_v300/docs/cis_v300_3_7.md")

  tags = merge(local.cis_v300_3_common_tags, {
    cis_item_id = "3.7"
    cis_level   = "2"
    cis_type    = "automated"
    service     = "GCP/Compute"
  })
}

control "cis_v300_3_8" {
  title         = "3.8 Ensure that VPC Flow Logs is Enabled for Every Subnet in a VPC Network"
  description   = "Flow Logs is a feature that enables users to capture information about the IP traffic going to and from network interfaces in the organization's VPC Subnets. Once a flow log is created, the user can view and retrieve its data in Stackdriver Logging. It is recommended that Flow Logs be enabled for every business-critical VPC subnet."
  query         = query.compute_subnetwork_flow_log_enabled
  documentation = file("./cis_v300/docs/cis_v300_3_8.md")

  tags = merge(local.cis_v300_3_common_tags, {
    cis_item_id = "3.8"
    cis_level   = "2"
    cis_type    = "automated"
    service     = "GCP/Compute"
  })
}

control "cis_v300_3_9" {
  title         = "3.9 Ensure No HTTPS or SSL Proxy Load Balancers Permit SSL Policies With Weak Cipher Suites"
  description   = "Secure Sockets Layer (SSL) policies determine what port Transport Layer Security (TLS) features clients are permitted to use when connecting to load balancers."
  query         = query.compute_ssl_policy_with_no_weak_cipher
  documentation = file("./cis_v300/docs/cis_v300_3_9.md")

  tags = merge(local.cis_v300_3_common_tags, {
    cis_item_id = "3.9"
    cis_level   = "1"
    cis_type    = "manual"
    service     = "GCP/Compute"
  })
}

control "cis_v300_3_10" {
  title         = "3.10 Use Identity Aware Proxy (IAP) to Ensure Only Traffic From Google IP Addresses are 'Allowed'"
  description   = "IAP authenticates the user requests to your apps via a Google single sign in. You can then manage these users with permissions to control access. It is recommended to use both IAP permissions and firewalls to restrict this access to your apps with sensitive information."
  query         = query.compute_firewall_allow_tcp_connections_proxied_by_iap
  documentation = file("./cis_v300/docs/cis_v300_3_10.md")

  tags = merge(local.cis_v300_3_common_tags, {
    cis_item_id = "3.10"
    cis_level   = "2"
    cis_type    = "manual"
    service     = "GCP/Compute"
  })
}
