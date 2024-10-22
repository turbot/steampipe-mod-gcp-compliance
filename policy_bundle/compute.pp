locals {
  policy_bundle_compute_common_tags = merge(local.gcp_compliance_common_tags, {
    service = "GCP/Compute"
  })
}

control "restrict_firewall_rule_rdp_world_open" {
  title = "Check for open firewall rules allowing RDP from the internet"
  query = query.compute_firewall_rule_rdp_access_restricted

  tags = merge(local.policy_bundle_compute_common_tags, {
    cft_scorecard_v1  = "true"
    nist_800_53_rev_5 = "true"
    severity          = "high"
    soc_2_2017        = "true"
  })
}

control "enable_network_flow_logs" {
  title = "Ensure VPC Flow logs is enabled for every subnet in VPC Network"
  query = query.compute_subnetwork_flow_log_enabled

  tags = merge(local.policy_bundle_compute_common_tags, {
    cft_scorecard_v1  = "true"
    nist_800_53_rev_5 = "true"
    nist_csf_v10      = "true"
    pci_dss_v321      = "true"
    severity          = "high"
    soc_2_2017        = "true"
  })
}

control "enable_network_private_google_access" {
  title = "Ensure Private Google Access is enabled for all subnetworks in VPC"
  query = query.compute_subnetwork_private_ip_google_access

  tags = merge(local.policy_bundle_compute_common_tags, {
    cft_scorecard_v1 = "true"
    severity         = "high"
  })
}

control "restrict_firewall_rule_ssh_world_open" {
  title = "Check for open firewall rules allowing SSH from the internet"
  query = query.compute_firewall_rule_ssh_access_restricted

  tags = merge(local.policy_bundle_compute_common_tags, {
    cft_scorecard_v1      = "true"
    forseti_security_v226 = "true"
    nist_800_53_rev_5     = "true"
    pci_dss_v321          = "true"
    severity              = "high"
    soc_2_2017            = "true"
  })
}

control "restrict_firewall_rule_world_open_tcp_udp_all_ports" {
  title = "Check for open firewall rules allowing TCP/UDP from the internet"
  query = query.compute_firewall_rule_rdp_access_restricted

  tags = merge(local.policy_bundle_compute_common_tags, {
    forseti_security_v226 = "true"
    pci_dss_v321          = "true"
    severity              = "high"
  })
}

control "compute_disk_encrypted_with_csk" {
  title       = "Ensure VM disks for critical VMs are encrypted with Customer-Supplied Encryption Keys (CSEK)"
  description = "Customer-Supplied Encryption Keys (CSEK) are a feature in Google Cloud Storage and Google Compute Engine. If you supply your own encryption keys, Google uses your key to protect the Google-generated keys used to encrypt and decrypt your data. By default, Google Compute Engine encrypts all data at rest. Compute Engine handles and manages this encryption for you without any additional actions on your part. However, if you wanted to control and manage this encryption yourself, you can provide your own encryption keys."
  query       = query.compute_disk_encrypted_with_csk

  tags = merge(local.policy_bundle_compute_common_tags, {
    hipaa             = "true"
    nist_800_53_rev_5 = "true"
    nist_csf_v10      = "true"
    soc_2_2017        = "true"
  })
}

control "compute_firewall_allow_connections_proxied_by_iap" {
  title       = "Ensure Firewall Rules for instances behind Identity Aware Proxy (IAP) only allow the traffic from Google Cloud Loadbalancer (GCLB) Health Check and Proxy Addresses"
  description = "Access to VMs should be restricted by firewall rules that allow only IAP traffic by ensuring only connections proxied by the IAP are allowed. To ensure that load balancing works correctly health checks should also be allowed."
  query       = query.compute_firewall_allow_connections_proxied_by_iap

  tags = local.policy_bundle_compute_common_tags
}

control "compute_firewall_allow_tcp_connections_proxied_by_iap" {
  title       = "Use Identity Aware Proxy (IAP) to Ensure Only Traffic From Google IP Addresses are 'Allowed'"
  description = "IAP authenticates the user requests to your apps via a Google single sign in. You can then manage these users with permissions to control access. It is recommended to use both IAP permissions and firewalls to restrict this access to your apps with sensitive information."
  query       = query.compute_firewall_allow_tcp_connections_proxied_by_iap

  tags = local.policy_bundle_compute_common_tags
}

control "compute_https_load_balancer_logging_enabled" {
  title       = "Ensure Logging is enabled for HTTP(S) Load Balancer"
  description = "Logging enabled on a HTTPS Load Balancer will show all network traffic and its destination."
  query       = query.compute_https_load_balancer_logging_enabled

  tags = merge(local.policy_bundle_compute_common_tags, {
    hipaa             = "true"
    nist_800_53_rev_5 = "true"
    nist_csf_v10      = "true"
  })
}

control "compute_instance_block_project_wide_ssh_enabled" {
  title       = "Ensure 'Block Project-wide SSH keys' is enabled for VM instances"
  description = "It is recommended to use Instance specific SSH key(s) instead of using common/shared project-wide SSH key(s) to access Instances."
  query       = query.compute_instance_block_project_wide_ssh_enabled

  tags = merge(local.policy_bundle_compute_common_tags, {
    nist_800_53_rev_5 = "true"
    nist_csf_v10      = "true"
    soc_2_2017        = "true"
  })
}

control "compute_instance_confidential_computing_enabled" {
  title       = "Ensure that Compute instances have Confidential Computing enabled"
  description = "Google Cloud encrypts data at-rest and in-transit, but customer data must be decrypted for processing. Confidential Computing is a breakthrough technology which encrypts data in-use—while it is being processed. Confidential Computing environments keep data encrypted in memory and elsewhere outside the central processing unit (CPU)."
  query       = query.compute_instance_confidential_computing_enabled

  tags = merge(local.policy_bundle_compute_common_tags, {
    nist_800_53_rev_5 = "true"
    nist_csf_v10      = "true"
    soc_2_2017        = "true"
  })
}

control "compute_instance_ip_forwarding_disabled" {
  title       = "Ensure that IP forwarding is not enabled on Instances"
  description = "Compute Engine instance cannot forward a packet unless the source IP address of the packet matches the IP address of the instance. Similarly, GCP won't deliver a packet whose destination IP address is different than the IP address of the instance receiving the packet. However, both capabilities are required if you want to use instances to help route packets."
  query       = query.compute_instance_ip_forwarding_disabled

  tags = merge(local.policy_bundle_compute_common_tags, {
    nist_800_53_rev_5 = "true"
    soc_2_2017        = "true"
  })
}

control "compute_instance_oslogin_enabled" {
  title       = "Ensure OS login is enabled for all instances in the Project"
  description = "Enabling OS login binds SSH certificates to IAM users and facilitates effective SSH certificate management."
  query       = query.compute_instance_oslogin_enabled

  tags = merge(local.policy_bundle_compute_common_tags, {
    nist_800_53_rev_5 = "true"
    soc_2_2017        = "true"
  })
}

control "compute_instance_serial_port_connection_disabled" {
  title       = "Ensure 'Enable connecting to serial ports' is not enabled for VM Instance"
  description = "Interacting with a serial port is often referred to as the serial console, which is similar to using a terminal window, in that input and output is entirely in text mode and there is no graphical interface or mouse support."
  query       = query.compute_instance_serial_port_connection_disabled

  tags = merge(local.policy_bundle_compute_common_tags, {
    nist_800_53_rev_5 = "true"
    soc_2_2017        = "true"
  })
}

control "compute_instance_shielded_vm_enabled" {
  title       = "Ensure Compute instances are launched with Shielded VM enabled"
  description = "To defend against advanced threats and ensure that the boot loader and firmware on your VMs are signed and untampered, it is recommended that Compute instances are launched with Shielded VM enabled."
  query       = query.compute_instance_shielded_vm_enabled

  tags = local.policy_bundle_compute_common_tags
}

control "compute_instance_with_no_default_service_account_with_full_access" {
  title       = "Ensure that instances are not configured to use the default service account with full access to all Cloud APIs"
  description = "To support principle of least privileges and prevent potential privilege escalation it is recommended that instances are not assigned to default service account Compute Engine default service account with Scope Allow full access to all Cloud APIs."
  query       = query.compute_instance_with_no_default_service_account_with_full_access

  tags = merge(local.policy_bundle_compute_common_tags, {
    nist_800_53_rev_5 = "true"
    nist_csf_v10      = "true"
    pci_dss_v321      = "true"
    soc_2_2017        = "true"
  })
}

control "compute_instance_with_no_default_service_account" {
  title       = "Ensure that instances are not configured to use the default service account"
  description = "It is recommended to configure your instance to not use the default Compute Engine service account because it has the Editor role on the project."
  query       = query.compute_instance_with_no_default_service_account

  tags = merge(local.policy_bundle_compute_common_tags, {
    nist_800_53_rev_5 = "true"
    nist_csf_v10      = "true"
    pci_dss_v321      = "true"
    soc_2_2017        = "true"
  })
}

control "compute_instance_with_no_public_ip_addresses" {
  title       = "Ensure that Compute instances do not have public IP addresses"
  description = "Compute instances should not be configured to have external IP addresses."
  query       = query.compute_instance_with_no_public_ip_addresses

  tags = merge(local.policy_bundle_compute_common_tags, {
    hipaa             = "true"
    nist_800_53_rev_5 = "true"
    nist_csf_v10      = "true"
    pci_dss_v321      = "true"
    soc_2_2017        = "true"
  })
}

control "compute_network_contains_no_default_network" {
  title       = "Ensure that the default network does not exist in a project"
  description = "To prevent the use of default network, a project should not have a default network."
  query       = query.compute_network_contains_no_default_network

  tags = merge(local.policy_bundle_compute_common_tags, {
    nist_800_53_rev_5 = "true"
    nist_csf_v10      = "true"
    soc_2_2017        = "true"
  })
}

control "compute_network_contains_no_legacy_network" {
  title       = "Ensure legacy networks do not exist for a project"
  description = "In order to prevent use of legacy networks, a project should not have a legacy network configured."
  query       = query.compute_network_contains_no_legacy_network

  tags = merge(local.policy_bundle_compute_common_tags, {
    nist_800_53_rev_5 = "true"
    nist_csf_v10      = "true"
    soc_2_2017        = "true"
  })
}

control "compute_network_dns_logging_enabled" {
  title       = "Ensure that Cloud DNS logging is enabled for all VPC networks"
  description = "Cloud DNS logging records the queries from the name servers within your VPC to Stackdriver. Logged queries can come from Compute Engine VMs, GKE containers, or other GCP resources provisioned within the VPC."
  query       = query.compute_network_dns_logging_enabled

  tags = merge(local.policy_bundle_compute_common_tags, {
    hipaa             = "true"
    nist_800_53_rev_5 = "true"
    nist_csf_v10      = "true"
    soc_2_2017        = "true"
  })
}

control "compute_ssl_policy_with_no_weak_cipher" {
  title       = "Ensure no HTTPS or SSL proxy load balancers permit SSL policies with weak cipher suites"
  description = "Secure Sockets Layer (SSL) policies determine what port Transport Layer Security (TLS) features clients are permitted to use when connecting to load balancers."
  query       = query.compute_ssl_policy_with_no_weak_cipher

  tags = merge(local.policy_bundle_compute_common_tags, {
    pci_dss_v321 = "true"
  })
}

control "compute_firewall_rule_ingress_access_restricted_to_dns_port_53" {
  title       = "Ensure no open firewall rules allow ingress from 0.0.00/0 to DNS port 53"
  description = "Firewall rules provide stateful filtering of ingress/egress network traffic to AWS resources. It is recommended that no security group allows unrestricted ingress access to DNS port 53."
  query       = query.compute_firewall_rule_ingress_access_restricted_to_dns_port_53

  tags = merge(local.policy_bundle_compute_common_tags, {
    pci_dss_v321 = "true"
  })
}

control "compute_firewall_rule_ingress_access_restricted_to_ftp_port_21" {
  title       = "Ensure no open firewall rules allow ingress from 0.0.00/0 to FTP port 21"
  description = "Firewall rules provide stateful filtering of ingress/egress network traffic to AWS resources. It is recommended that no security group allows unrestricted ingress access to FTP port 21."
  query       = query.compute_firewall_rule_ingress_access_restricted_to_ftp_port_21

  tags = merge(local.policy_bundle_compute_common_tags, {
    pci_dss_v321 = "true"
  })
}

control "compute_firewall_rule_ingress_access_restricted_to_http_port_80" {
  title       = "Ensure no open firewall rules allow ingress from 0.0.00/0 to HTTP port 80"
  description = "Firewall rules provide stateful filtering of ingress/egress network traffic to AWS resources. It is recommended that no security group allows unrestricted ingress access to HTTP port 80."
  query       = query.compute_firewall_rule_ingress_access_restricted_to_http_port_80

  tags = merge(local.policy_bundle_compute_common_tags, {
    pci_dss_v321 = "true"
  })
}

control "compute_firewall_rule_ingress_access_restricted_to_smtp_port_25" {
  title       = "Ensure no open firewall rules allow ingress from 0.0.00/0 to SMTP port 25"
  description = "Firewall rules provide stateful filtering of ingress/egress network traffic to AWS resources. It is recommended that no security group allows unrestricted ingress access to SMTP port 25."
  query       = query.compute_firewall_rule_ingress_access_restricted_to_smtp_port_25

  tags = merge(local.policy_bundle_compute_common_tags, {
    pci_dss_v321 = "true"
  })
}

control "compute_firewall_rule_ingress_access_restricted_to_microsoft_ds_port_445" {
  title       = "Ensure no open firewall rules allow ingress from 0.0.00/0 to Microsoft DS port 445"
  description = "Firewall rules provide stateful filtering of ingress/egress network traffic to AWS resources. It is recommended that no security group allows unrestricted ingress access to Microsoft DS port 445."
  query       = query.compute_firewall_rule_ingress_access_restricted_to_microsoft_ds_port_445

  tags = merge(local.policy_bundle_compute_common_tags, {
    pci_dss_v321 = "true"
  })
}

control "compute_firewall_rule_ingress_access_restricted_to_mongo_db_port_27017" {
  title       = "Ensure no open firewall rules allow ingress from 0.0.00/0 to MongoDB port 27017"
  description = "Firewall rules provide stateful filtering of ingress/egress network traffic to AWS resources. It is recommended that no security group allows unrestricted ingress access to MongoDB port 27017."
  query       = query.compute_firewall_rule_ingress_access_restricted_to_mongo_db_port_27017

  tags = local.policy_bundle_compute_common_tags
}

control "compute_firewall_rule_ingress_access_restricted_to_mysql_db_port_3306" {
  title       = "Ensure no open firewall rules allow ingress from 0.0.00/0 to MySQL DB port 3306"
  description = "Firewall rules provide stateful filtering of ingress/egress network traffic to AWS resources. It is recommended that no security group allows unrestricted ingress access to MySQL DB port 3306."
  query       = query.compute_firewall_rule_ingress_access_restricted_to_mysql_db_port_3306

  tags = merge(local.policy_bundle_compute_common_tags, {
    pci_dss_v321 = "true"
  })
}

control "compute_firewall_rule_ingress_access_restricted_to_netbios_snn_port_139" {
  title       = "Ensure no open firewall rules allow ingress from 0.0.00/0 to NetBIOS SSN port 139"
  description = "Firewall rules provide stateful filtering of ingress/egress network traffic to AWS resources. It is recommended that no security group allows unrestricted ingress access to NetBIOS SSN port 139."
  query       = query.compute_firewall_rule_ingress_access_restricted_to_netbios_snn_port_139

  tags = local.policy_bundle_compute_common_tags
}

control "compute_firewall_rule_ingress_access_restricted_to_oracle_db_port_1521" {
  title       = "Ensure no open firewall rules allow ingress from 0.0.00/0 to Oracle DB port 1521"
  description = "Firewall rules provide stateful filtering of ingress/egress network traffic to AWS resources. It is recommended that no security group allows unrestricted ingress access to Oracle DB port 1521."
  query       = query.compute_firewall_rule_ingress_access_restricted_to_oracle_db_port_1521

  tags = merge(local.policy_bundle_compute_common_tags, {
    pci_dss_v321 = "true"
  })
}

control "compute_firewall_rule_ingress_access_restricted_to_pop3_port_110" {
  title       = "Ensure no open firewall rules allow ingress from 0.0.00/0 to POP3 port 110"
  description = "Firewall rules provide stateful filtering of ingress/egress network traffic to AWS resources. It is recommended that no security group allows unrestricted ingress access to POP3 port 110."
  query       = query.compute_firewall_rule_ingress_access_restricted_to_pop3_port_110

  tags = merge(local.policy_bundle_compute_common_tags, {
    pci_dss_v321 = "true"
  })
}

control "compute_firewall_rule_ingress_access_restricted_to_postgresql_port_5432" {
  title       = "Ensure no open firewall rules allow ingress from 0.0.00/0 to PostgreSQL port 5432"
  description = "Firewall rules provide stateful filtering of ingress/egress network traffic to AWS resources. It is recommended that no security group allows unrestricted ingress access to PostgreSQL port 5432."
  query       = query.compute_firewall_rule_ingress_access_restricted_to_postgresql_port_5432

  tags = merge(local.policy_bundle_compute_common_tags, {
    pci_dss_v321 = "true"
  })
}

control "compute_firewall_rule_ingress_access_restricted_to_telnet_port_23" {
  title       = "Ensure no open firewall rules allow ingress from 0.0.00/0 to Telnet port 23"
  description = "Firewall rules provide stateful filtering of ingress/egress network traffic to AWS resources. It is recommended that no security group allows unrestricted ingress access to Telnet port 23."
  query       = query.compute_firewall_rule_ingress_access_restricted_to_telnet_port_23

  tags = merge(local.policy_bundle_compute_common_tags, {
    pci_dss_v321 = "true"
  })
}

control "compute_network_auto_create_subnetwork_enabled" {
  title       = "Compute Networks should have auto create subnetwork enabled"
  description = "This control ensures that auto create subnetwork is enabled for Compute Network. Legacy network is not recommended, subnetworks cannot be created in a legacy network."
  query       = query.compute_network_auto_create_subnetwork_enabled

  tags = local.policy_bundle_compute_common_tags
}

control "compute_backend_bucket_no_dangling_storage_bucket" {
  title       = "Compute Backend Bucket should not have dangling storage bucket"
  description = "This control ensures that Compute Backend Bucket does not have dangling storage bucket."
  query       = query.compute_backend_bucket_no_dangling_storage_bucket

  tags = local.policy_bundle_compute_common_tags
}

control "compute_instance_preemptible_termination_disabled" {
  title       = "Compute Instance preemptible termination should be disabled"
  description = "This control ensures that Compute Instance preemptible termination is disabled. Compute Instance preemptible termination can lead to unexpected loss of service when the VM instance is terminated."
  query       = query.compute_instance_preemptible_termination_disabled

  tags = local.policy_bundle_compute_common_tags
}

control "compute_instance_with_custom_metadata" {
  title       = "Compute Instances should have custom metadata"
  description = "This control ensures that Compute Instance have custom metadata. Custom metadata facilitates simple identification and enhances searchability."
  query       = query.compute_instance_with_custom_metadata

  tags = local.policy_bundle_compute_common_tags
}

control "compute_instance_template_ip_forwarding_disabled" {
  title       = "Compute Instance template IP forwarding should be disabled"
  description = "Compute Engine instance template cannot forward a packet unless the source IP address of the packet matches the IP address of the instance. Similarly, GCP won't deliver a packet whose destination IP address is different than the IP address of the instance receiving the packet. However, both capabilities are required if you want to use instances to help route packets."
  query       = query.compute_instance_template_ip_forwarding_disabled

  tags = local.policy_bundle_compute_common_tags
}

control "compute_target_https_proxy_quic_protocol_enabled" {
  title       = "Compute Target HTTPS proxy QUIC protocol should be enabled"
  description = "This control ensures that Compute Target HTTPS proxy QUIC protocol is enabled. Activating the QUIC protocol in load balancer target HTTPS proxies offers the benefit of quicker connection establishment."
  query       = query.compute_target_https_proxy_quic_protocol_enabled

  tags = local.policy_bundle_compute_common_tags
}

control "compute_target_https_proxy_quic_protocol_no_default_ssl_policy" {
  title       = "Compute Target HTTPS proxy should use custom SSL policy"
  description = "This control ensures that Compute Target HTTPS proxy should use custom SSL policy."
  query       = query.compute_target_https_proxy_quic_protocol_no_default_ssl_policy

  tags = local.policy_bundle_compute_common_tags
}

control "compute_instance_no_disrupt_logging_permission" {
  title       = "Compute Instances should restrict disrupt logging permission"
  description = "This control ensures that Compute Instance does not disrupt logging permissions."
  query       = query.compute_instance_no_disrupt_logging_permission

  tags = local.policy_bundle_compute_common_tags
}

control "compute_instance_no_deployments_manager_permission" {
  title       = "Compute Instances should restrict deployments manager permission"
  description = "This control ensures that Compute Instance does not allow deployments manager permissions."
  query       = query.compute_instance_no_deployments_manager_permission

  tags = local.policy_bundle_compute_common_tags
}

control "compute_instance_no_database_write_permission" {
  title       = "Compute Instances should restrict database write permission"
  description = "This control ensures that Compute Instance does not allow database write permissions."
  query       = query.compute_instance_no_database_write_permission

  tags = local.policy_bundle_compute_common_tags
}

control "compute_instance_no_data_destruction_permission" {
  title       = "Compute Instances should restrict data destruction permission"
  description = "This control ensures that Compute Instance does not allow data destruction permissions."
  query       = query.compute_instance_no_data_destruction_permission

  tags = local.policy_bundle_compute_common_tags
}

control "compute_instance_no_service_account_impersonate_permission" {
  title       = "Compute Instances should restrict service account impersonate permission"
  description = "This control ensures that Compute Instance does not allow service account impersonate permissions."
  query       = query.compute_instance_no_service_account_impersonate_permission

  tags = local.policy_bundle_compute_common_tags
}

control "compute_instance_no_write_permission_on_deny_policy" {
  title       = "Compute Instances should restrict write permission on deny policy"
  description = "This control ensures that Compute Instance does not allow write permission on deny policies."
  query       = query.compute_instance_no_write_permission_on_deny_policy

  tags = local.policy_bundle_compute_common_tags
}

control "compute_instance_wth_no_high_level_basic_role" {
  title       = "Compute Instances should restrict high level basic role"
  description = "This control ensures that Compute Instance does not allow high level basic role."
  query       = query.compute_instance_wth_no_high_level_basic_role

  tags = local.policy_bundle_compute_common_tags
}

control "compute_target_https_uses_latest_tls_version" {
  title       = "Ensure HTTPS target use latest TLS version"
  description = "This control ensures that HTTP target use latest TLS version."
  query       = query.compute_target_https_uses_latest_tls_version

  tags = local.policy_bundle_compute_common_tags
}

control "compute_external_backend_service_iap_enabled" {
  title       = "Ensure external backend service has IAP enabled"
  description = "This control ensures that external backend service has IAP enabled."
  query       = query.compute_external_backend_service_iap_enabled

  tags = local.policy_bundle_compute_common_tags
}

control "compute_firewall_rule_restrict_ingress_all_with_no_specific_target" {
  title       = "Ensure no open firewall rules allow ingress from 0.0.00/0 to any port without any specific target"
  description = "Firewall rules provide stateful filtering of ingress/egress network traffic to AWS resources. It is recommended that no security group allows unrestricted ingress access to any port without any specific target."
  query       = query.compute_firewall_rule_restrict_ingress_all_with_no_specific_target

  tags = merge(local.policy_bundle_compute_common_tags, {
    pci_dss_v321 = "true"
  })
}

control "compute_firewall_rule_ingress_access_restricted_to_postgresql_port_10250" {
  title       = "Ensure no open firewall rules allow ingress from 0.0.00/0 to port 10250"
  description = "Firewall rules provide stateful filtering of ingress/egress network traffic to AWS resources. It is recommended that no security group allows unrestricted ingress access to port 10250."
  query       = query.compute_firewall_rule_ingress_access_restricted_to_postgresql_port_10250

  tags = local.policy_bundle_compute_common_tags
}

control "compute_firewall_rule_ingress_access_restricted_to_postgresql_port_10255" {
  title       = "Ensure no open firewall rules allow ingress from 0.0.00/0 to port 10255"
  description = "Firewall rules provide stateful filtering of ingress/egress network traffic to AWS resources. It is recommended that no security group allows unrestricted ingress access to port 10255."
  query       = query.compute_firewall_rule_ingress_access_restricted_to_postgresql_port_10255

  tags = local.policy_bundle_compute_common_tags
}

control "compute_firewall_rule_restrict_ingress_all" {
  title       = "Ensure no open firewall rules allow ingress from 0.0.00/0 to any port"
  description = "Firewall rules provide stateful filtering of ingress/egress network traffic to AWS resources. It is recommended that no security group allows unrestricted ingress access to any port."
  query       = query.compute_firewall_rule_restrict_ingress_all

  tags = merge(local.policy_bundle_compute_common_tags, {
    pci_dss_v321 = "true"
  })
}

control "compute_instance_no_iam_write_permission" {
  title       = "Compute Instances should restrict IAM write permission"
  description = "This is control ensures that Compute Instance does not allow IAM write permissions."
  query       = query.compute_instance_no_iam_write_permission

  tags = local.policy_bundle_compute_common_tags
}

control "compute_firewall_default_rule_restrict_ingress_access_except_http_and_https" {
  title       = "Ensure no open default firewall rules allow ingress from 0.0.00/0 to any port"
  description = "This control ensures that default firewall rules does not allow ingress from 0.0.00/0 to any port. This is not applicable to default HTTP and HTTPS firewall rule."
  query       = query.compute_firewall_default_rule_restrict_ingress_access_except_http_and_https

  tags = local.policy_bundle_compute_common_tags
}

control "compute_firewall_rule_ingress_access_restricted_to_tcp_port_9090" {
  title       = "Ensure no open firewall rules allow ingress from 0.0.00/0 to port TCP 9090"
  description = "Firewall rules provide stateful filtering of ingress/egress network traffic to AWS resources. It is recommended that no security group allows unrestricted ingress access to TCP port 9090."
  query       = query.compute_firewall_rule_ingress_access_restricted_to_tcp_port_9090

  tags = merge(local.policy_bundle_compute_common_tags, {
    pci_dss_v321 = "true"
  })
}

control "compute_firewall_rule_ingress_access_restricted_to_tcp_port_9200_9300" {
  title       = "Ensure no open firewall rules allow ingress from 0.0.00/0 to port TCP 9200 or 9300"
  description = "Firewall rules provide stateful filtering of ingress/egress network traffic to AWS resources. It is recommended that no security group allows unrestricted ingress access to TCP port 9200 or 9300."
  query       = query.compute_firewall_rule_ingress_access_restricted_to_tcp_port_9200_9300

  tags = merge(local.policy_bundle_compute_common_tags, {
    pci_dss_v321 = "true"
  })
}

control "compute_firewall_rule_logging_enabled" {
  title       = "Ensure compute firewall rule have logging enabled"
  description = "Firewall rules should have logging enabled. This control fails if logging is disabled for firewall rule."
  query       = query.compute_firewall_rule_logging_enabled

  tags = merge(local.policy_bundle_compute_common_tags, {
    pci_dss_v321 = "true"
  })
}

control "compute_firewall_rule_ingress_access_restricted_to_tcp_port_7000_7001" {
  title       = "Ensure no open firewall rules allow ingress from 0.0.00/0 to port TCP 7000 or 7001"
  description = "Firewall rules provide stateful filtering of ingress/egress network traffic to AWS resources. It is recommended that no security group allows unrestricted ingress access to TCP port 7000 or 7001."
  query       = query.compute_firewall_rule_ingress_access_restricted_to_tcp_port_7000_7001

  tags = merge(local.policy_bundle_compute_common_tags, {
    pci_dss_v321 = "true"
  })
}

control "compute_firewall_rule_ingress_access_restricted_to_tcp_port_7199" {
  title       = "Ensure no open firewall rules allow ingress from 0.0.00/0 to port TCP 7199"
  description = "Firewall rules provide stateful filtering of ingress/egress network traffic to AWS resources. It is recommended that no security group allows unrestricted ingress access to TCP port 7199."
  query       = query.compute_firewall_rule_ingress_access_restricted_to_tcp_port_7199

  tags = merge(local.policy_bundle_compute_common_tags, {
    pci_dss_v321 = "true"
  })
}

control "compute_firewall_rule_ingress_access_restricted_to_tcp_port_8888" {
  title       = "Ensure no open firewall rules allow ingress from 0.0.00/0 to port TCP 8888"
  description = "Firewall rules provide stateful filtering of ingress/egress network traffic to AWS resources. It is recommended that no security group allows unrestricted ingress access to TCP port 8888."
  query       = query.compute_firewall_rule_ingress_access_restricted_to_tcp_port_8888

  tags = merge(local.policy_bundle_compute_common_tags, {
    pci_dss_v321 = "true"
  })
}

control "compute_firewall_rule_ingress_access_restricted_to_tcp_port_9042" {
  title       = "Ensure no open firewall rules allow ingress from 0.0.00/0 to port TCP 9042"
  description = "Firewall rules provide stateful filtering of ingress/egress network traffic to AWS resources. It is recommended that no security group allows unrestricted ingress access to TCP port 9042."
  query       = query.compute_firewall_rule_ingress_access_restricted_to_tcp_port_9042

  tags = merge(local.policy_bundle_compute_common_tags, {
    pci_dss_v321 = "true"
  })
}

control "compute_firewall_rule_ingress_access_restricted_to_tcp_port_9160" {
  title       = "Ensure no open firewall rules allow ingress from 0.0.00/0 to port TCP 9160"
  description = "Firewall rules provide stateful filtering of ingress/egress network traffic to AWS resources. It is recommended that no security group allows unrestricted ingress access to TCP port 9160."
  query       = query.compute_firewall_rule_ingress_access_restricted_to_tcp_port_9160

  tags = merge(local.policy_bundle_compute_common_tags, {
    pci_dss_v321 = "true"
  })
}

control "compute_firewall_rule_ingress_access_restricted_to_tcp_port_61620_61621" {
  title       = "Ensure no open firewall rules allow ingress from 0.0.00/0 to port TCP 61620 or 6162"
  description = "Firewall rules provide stateful filtering of ingress/egress network traffic to AWS resources. It is recommended that no security group allows unrestricted ingress access to TCP port 61620 or 6162."
  query       = query.compute_firewall_rule_ingress_access_restricted_to_tcp_port_61620_61621

  tags = merge(local.policy_bundle_compute_common_tags, {
    pci_dss_v321 = "true"
  })
}

control "compute_firewall_rule_ingress_access_restricted_to_tcp_port_6379" {
  title       = "Ensure no open firewall rules allow ingress from 0.0.00/0 to port TCP 6379"
  description = "Firewall rules provide stateful filtering of ingress/egress network traffic to AWS resources. It is recommended that no security group allows unrestricted ingress access to TCP port 6379."
  query       = query.compute_firewall_rule_ingress_access_restricted_to_tcp_port_6379

  tags = merge(local.policy_bundle_compute_common_tags, {
    pci_dss_v321 = "true"
  })
}

control "compute_firewall_rule_ingress_access_restricted_to_tcp_port_137_to_139" {
  title       = "Ensure no open firewall rules allow ingress from 0.0.00/0 to port TCP 137 to 139"
  description = "Firewall rules provide stateful filtering of ingress/egress network traffic to AWS resources. It is recommended that no security group allows unrestricted ingress access to TCP port 137 to 139."
  query       = query.compute_firewall_rule_ingress_access_restricted_to_tcp_port_137_to_139

  tags = merge(local.policy_bundle_compute_common_tags, {
    pci_dss_v321 = "true"
  })
}

control "compute_firewall_rule_ingress_access_restricted_to_tcp_port_27017_to_27019" {
  title       = "Ensure no open firewall rules allow ingress from 0.0.00/0 to port TCP 27017 to 27019"
  description = "Firewall rules provide stateful filtering of ingress/egress network traffic to AWS resources. It is recommended that no security group allows unrestricted ingress access to TCP port 27017 to 27019."
  query       = query.compute_firewall_rule_ingress_access_restricted_to_tcp_port_27017_to_27019

  tags = merge(local.policy_bundle_compute_common_tags, {
    pci_dss_v321 = "true"
  })
}

control "compute_firewall_rule_ingress_access_restricted_to_tcp_port_636" {
  title       = "Ensure no open firewall rules allow ingress from 0.0.00/0 to port TCP 636"
  description = "Firewall rules provide stateful filtering of ingress/egress network traffic to AWS resources. It is recommended that no security group allows unrestricted ingress access to TCP port 636."
  query       = query.compute_firewall_rule_ingress_access_restricted_to_tcp_port_636

  tags = merge(local.policy_bundle_compute_common_tags, {
    pci_dss_v321 = "true"
  })
}

control "compute_firewall_rule_ingress_access_restricted_to_tcp_udp_port_389" {
  title       = "Ensure no open firewall rules allow ingress from 0.0.00/0 to TCP or UDP port 389"
  description = "Firewall rules provide stateful filtering of ingress/egress network traffic to AWS resources. It is recommended that no security group allows unrestricted ingress access to TCP or UDP port 389."
  query       = query.compute_firewall_rule_ingress_access_restricted_to_tcp_udp_port_389

  tags = merge(local.policy_bundle_compute_common_tags, {
    pci_dss_v321 = "true"
  })
}

control "compute_firewall_rule_ingress_access_restricted_to_tcp_udp_port_11211" {
  title       = "Ensure no open firewall rules allow ingress from 0.0.00/0 to TCP or UDP port 11211"
  description = "Firewall rules provide stateful filtering of ingress/egress network traffic to AWS resources. It is recommended that no security group allows unrestricted ingress access to TCP or UDP port 11211."
  query       = query.compute_firewall_rule_ingress_access_restricted_to_tcp_udp_port_11211

  tags = merge(local.policy_bundle_compute_common_tags, {
    pci_dss_v321 = "true"
  })
}

control "compute_firewall_rule_ingress_access_restricted_to_tcp_udp_port_11214_to_11215" {
  title       = "Ensure no open firewall rules allow ingress from 0.0.00/0 to TCP or UDP port 11214 to 11215"
  description = "Firewall rules provide stateful filtering of ingress/egress network traffic to AWS resources. It is recommended that no security group allows unrestricted ingress access to TCP or UDP port 11214 to 11215."
  query       = query.compute_firewall_rule_ingress_access_restricted_to_tcp_udp_port_11214_to_11215

  tags = merge(local.policy_bundle_compute_common_tags, {
    pci_dss_v321 = "true"
  })
}

control "compute_firewall_rule_ingress_access_restricted_to_tcp_udp_port_2483_to_2484" {
  title       = "Ensure no open firewall rules allow ingress from 0.0.00/0 to TCP or UDP port 2483 to 24845"
  description = "Firewall rules provide stateful filtering of ingress/egress network traffic to AWS resources. It is recommended that no security group allows unrestricted ingress access to TCP or UDP port 2483 to 2484."
  query       = query.compute_firewall_rule_ingress_access_restricted_to_tcp_udp_port_2483_to_2484

  tags = merge(local.policy_bundle_compute_common_tags, {
    pci_dss_v321 = "true"
  })
}

query "compute_firewall_rule_ssh_access_restricted" {
  sql = <<-EOQ
    with ip_protocol_all as (
    select
      name
    from
      gcp_compute_firewall
    where
      direction = 'INGRESS'
      and action = 'Allow'
      and source_ranges ?& array['0.0.0.0/0']
      and (allowed @> '[{"IPProtocol":"all"}]' or allowed::text like '%!{"IPProtocol": "tcp"}%')
    ),
    ip_protocol_tcp as (
      select
        name
      from
        gcp_compute_firewall,
        jsonb_array_elements(allowed) as p,
        jsonb_array_elements_text(p -> 'ports') as port
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and source_ranges ?& array['0.0.0.0/0']
        and p ->> 'IPProtocol' = 'tcp'
        and (
          port = '22'
          or (
            port like '%-%'
            and split_part(port, '-', 1) :: integer <= 22
            and split_part(port, '-', 2) :: integer >= 22
          )
        )
    )
    select
      self_link resource,
      case
        when name in (select name from ip_protocol_tcp) then 'alarm'
        when name in (select name from ip_protocol_all) then 'alarm'
        else 'ok'
      end as status,
      case
        when name in (select name from ip_protocol_tcp) or name in (select name from ip_protocol_all)
          then title || ' allows SSH access from internet.'
        else title || ' restricts SSH access from internet.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;
  EOQ
}

query "compute_firewall_rule_rdp_access_restricted" {
  sql = <<-EOQ
    with ip_protocol_all as (
      select
        name
      from
        gcp_compute_firewall
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and source_ranges ?& array['0.0.0.0/0']
        and (allowed @> '[{"IPProtocol":"all"}]' or allowed::text like '%!{"IPProtocol": "tcp"}%')
    ),
    ip_protocol_tcp as (
      select
        name
      from
        gcp_compute_firewall,
        jsonb_array_elements(allowed) as p,
        jsonb_array_elements_text(p -> 'ports') as port
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and source_ranges ?& array['0.0.0.0/0']
        and p ->> 'IPProtocol' = 'tcp'
        and (
          port = '3389'
          or (
            port like '%-%'
            and split_part(port, '-', 1) :: integer <= 3389
            and split_part(port, '-', 2) :: integer >= 3389
          )
        )
    )
    select
      self_link resource,
      case
        when name in (select name from ip_protocol_tcp) then 'alarm'
        when name in (select name from ip_protocol_all) then 'alarm'
        else 'ok'
      end as status,
      case
        when name in (select name from ip_protocol_tcp) or name in (select name from ip_protocol_all)
          then title || ' allows RDP access from internet.'
        else title || ' restricts RDP access from internet.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;
  EOQ
}

query "compute_subnetwork_flow_log_enabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when enable_flow_logs then 'ok'
        else 'alarm'
      end as status,
      case
        when enable_flow_logs
          then title || ' flow logging enabled.'
        else title || ' flow logging disabled.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_subnetwork;
  EOQ
}

query "compute_subnetwork_private_ip_google_access" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when private_ip_google_access then 'ok'
        else 'alarm'
      end as status,
      case
        when private_ip_google_access then title || ' private Google Access is enabled.'
        else title || ' private Google Access is disabled.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_subnetwork;
  EOQ
}

# Non-Config rule query

query "compute_disk_encrypted_with_csk" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when disk_encryption_key_type = 'Customer supplied' then 'ok'
        else 'alarm'
      end as status,
      case
        when disk_encryption_key_type = 'Customer supplied'
          then title || ' encrypted with customer-supplied encryption keys (CSEK).'
        when disk_encryption_key_type = 'Customer managed'
          then title || ' encrypted with customer-managed encryption keys.'
        else title || ' encrypted with default Google-managed keys.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_compute_disk;
  EOQ
}

query "compute_firewall_allow_connections_proxied_by_iap" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when allowed @> '[{"IPProtocol":"tcp","ports":["80"]}]' and source_ranges ?& array['130.211.0.0/22', '35.191.0.0/16'] then 'ok'
        else 'alarm'
      end as status,
      case
        when allowed @> '[{"IPProtocol":"tcp","ports":["80"]}]' and source_ranges ?& array['130.211.0.0/22', '35.191.0.0/16']
          then title || ' only allows traffic proxied by IAP.'
        else title || ' not configured to only allow connections proxied by IAP.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;
  EOQ
}

query "compute_firewall_allow_tcp_connections_proxied_by_iap" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when
          ( allowed @> '[{"IPProtocol":"tcp","ports":["80","443","22","3389"]}]'
            or allowed @> '[{"IPProtocol":"tcp","ports":["80","443","22"]}]'
            or allowed @> '[{"IPProtocol":"tcp","ports":["80","443","3389"]}]'
            or allowed @> '[{"IPProtocol":"tcp","ports":["80","22","3389"]}]'
            or allowed @> '[{"IPProtocol":"tcp","ports":["3389","443","22"]}]'
            or allowed @> '[{"IPProtocol":"tcp","ports":["80","443"]}]'
            or allowed @> '[{"IPProtocol":"tcp","ports":["80","22"]}]'
            or allowed @> '[{"IPProtocol":"tcp","ports":["80","3389"]}]'
            or allowed @> '[{"IPProtocol":"tcp","ports":["22","443"]}]'
            or allowed @> '[{"IPProtocol":"tcp","ports":["3389","443"]}]'
            or allowed @> '[{"IPProtocol":"tcp","ports":["22","3389"]}]'
            or allowed @> '[{"IPProtocol":"tcp","ports":["443"]}]'
            or allowed @> '[{"IPProtocol":"tcp","ports":["22"]}]'
            or allowed @> '[{"IPProtocol":"tcp","ports":["80"]}]'
            or allowed @> '[{"IPProtocol":"tcp","ports":["3389"]}]'
          )
          and (source_ranges ?& array['130.211.0.0/22']
            or source_ranges ?& array['35.235.240.0/20']
            or source_ranges ?& array['35.191.0.0/16']
            or source_ranges ?& array['35.191.0.0/16', '130.211.0.0/22']
            or source_ranges ?& array['35.191.0.0/16', '35.235.240.0/20']
            or source_ranges ?& array['130.211.0.0/22', '35.235.240.0/20']
            or source_ranges ?& array['130.211.0.0/22', '35.235.240.0/20', '35.191.0.0/16'])
          then 'ok'
        else 'alarm'
      end as status,
      case
        when
          ( allowed @> '[{"IPProtocol":"tcp","ports":["80","443","22","3389"]}]'
            or allowed @> '[{"IPProtocol":"tcp","ports":["80","443","22"]}]'
            or allowed @> '[{"IPProtocol":"tcp","ports":["80","443","3389"]}]'
            or allowed @> '[{"IPProtocol":"tcp","ports":["80","22","3389"]}]'
            or allowed @> '[{"IPProtocol":"tcp","ports":["3389","443","22"]}]'
            or allowed @> '[{"IPProtocol":"tcp","ports":["80","443"]}]'
            or allowed @> '[{"IPProtocol":"tcp","ports":["80","22"]}]'
            or allowed @> '[{"IPProtocol":"tcp","ports":["80","3389"]}]'
            or allowed @> '[{"IPProtocol":"tcp","ports":["22","443"]}]'
            or allowed @> '[{"IPProtocol":"tcp","ports":["3389","443"]}]'
            or allowed @> '[{"IPProtocol":"tcp","ports":["22","3389"]}]'
            or allowed @> '[{"IPProtocol":"tcp","ports":["443"]}]'
            or allowed @> '[{"IPProtocol":"tcp","ports":["22"]}]'
            or allowed @> '[{"IPProtocol":"tcp","ports":["80"]}]'
            or allowed @> '[{"IPProtocol":"tcp","ports":["3389"]}]'
          )
          and (source_ranges ?& array['130.211.0.0/22']
            or source_ranges ?& array['35.235.240.0/20']
            or source_ranges ?& array['35.191.0.0/16']
            or source_ranges ?& array['35.191.0.0/16', '130.211.0.0/22']
            or source_ranges ?& array['35.191.0.0/16', '35.235.240.0/20']
            or source_ranges ?& array['130.211.0.0/22', '35.235.240.0/20']
            or source_ranges ?& array['130.211.0.0/22', '35.235.240.0/20', '35.191.0.0/16'])
          then title || ' IAP configured to allow traffic from Google IP addresses.'
        else title || ' IAP not configured to allow traffic from Google IP addresses.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;
  EOQ
}

query "compute_https_load_balancer_logging_enabled" {
  sql = <<-EOQ
    select
      m.self_link as resource,
      case
        when s.self_link is null then 'skip'
        when s.log_config_enable then 'ok'
        else 'alarm'
      end as status,
      case
        when s.self_link is null then m.name || ' uses backend bucket.'
        when s.log_config_enable then m.name || ' logging enabled.'
        else m.name || ' logging disabled.'
      end as reason
      ${replace(local.common_dimensions_qualifier_sql, "__QUALIFIER__", "m.")}
    from
      gcp_compute_url_map as m
      left join gcp_compute_backend_service as s on s.self_link = m.default_service;
  EOQ
}

query "compute_instance_block_project_wide_ssh_enabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when name like 'gke-%' and labels ? 'goog-gke-node' then 'skip'
        when metadata -> 'items' @> '[{"key": "block-project-ssh-keys", "value": "true"}]' then 'ok'
        else 'alarm'
      end as status,
      case
        when name like 'gke-%' and labels ? 'goog-gke-node'
          then title || ' created by GKE.'
        when metadata -> 'items' @> '[{"key": "block-project-ssh-keys", "value": "true"}]'
          then title || ' has "Block Project-wide SSH keys" enabled.'
        else title || ' has "Block Project-wide SSH keys" disabled.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_compute_instance;
  EOQ
}

query "compute_instance_confidential_computing_enabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when confidential_instance_config @> '{"enableConfidentialCompute": true}' then 'ok'
        else 'alarm'
      end as status,
      case
        when confidential_instance_config @> '{"enableConfidentialCompute": true}'
          then title || ' confidential computing enabled.'
        else title || ' confidential computing not enabled.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_compute_instance;
  EOQ
}

query "compute_instance_ip_forwarding_disabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when name like 'gke-%' and labels ? 'goog-gke-node' then 'skip'
        when can_ip_forward then 'alarm'
        else 'ok'
      end as status,
      case
        when name like 'gke-%' and labels ? 'goog-gke-node'
          then title || ' created by GKE.'
        when can_ip_forward
          then title || ' IP forwarding enabled.'
        else title || ' IP forwarding not enabled.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_compute_instance;
  EOQ
}

query "compute_instance_oslogin_enabled" {
  sql = <<-EOQ
    select
      i.self_link resource,
      case
        when m.common_instance_metadata -> 'items' is null or not (m.common_instance_metadata -> 'items' @> '[{"key":"enable-oslogin"}]') then 'alarm'
        when m.common_instance_metadata -> 'items' @> '[{"key":"enable-oslogin","value":"FALSE"}]' then 'alarm'
        when m.common_instance_metadata -> 'items' @> '[{"key":"enable-oslogin","value":"TRUE"}]' and i.metadata -> 'items' @> '[{"key":"enable-oslogin","value":"FALSE"}]' then 'alarm'
        else 'ok'
      end as status,
      case
        when
          m.common_instance_metadata -> 'items' is null
          or not(m.common_instance_metadata -> 'items' @> '[{"key":"enable-oslogin"}]')
          or m.common_instance_metadata -> 'items' @> '[{"key": "enable-oslogin", "value": "FALSE"}]'
          then i.title || ' has OS login disabled at project level.'
        when m.common_instance_metadata -> 'items' @> '[{"key":"enable-oslogin","value":"TRUE"}]' and i.metadata -> 'items' @> '[{"key":"enable-oslogin","value":"FALSE"}]'
          then i.title || ' OS login settings is disabled.'
        when m.common_instance_metadata -> 'items' @> '[{"key":"enable-oslogin","value":"TRUE"}]' and i.metadata -> 'items' is null
          then i.title || ' inherits OS login settings from project level.'
        else i.title || ' OS login enabled.'
      end as reason
      ${replace(local.tag_dimensions_qualifier_sql, "__QUALIFIER__", "i.")}
      ${replace(local.common_dimensions_qualifier_sql, "__QUALIFIER__", "i.")}
    from
      gcp_compute_instance i
      left join gcp_compute_project_metadata m on i.project = m.project;
  EOQ
}

query "compute_instance_serial_port_connection_disabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when metadata -> 'items' @> '[{"key": "serial-port-enable", "value": "true"}]' then 'alarm'
        else 'ok'
      end as status,
      case
        when metadata -> 'items' @> '[{"key": "serial-port-enable", "value": "true"}]'
          then title || ' serial port connections enabled.'
        else title || ' serial port connections disabled.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_compute_instance;
  EOQ
}

query "compute_instance_shielded_vm_enabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when shielded_instance_config @> '{"enableVtpm": true, "enableIntegrityMonitoring": true}' then 'ok'
        else 'alarm'
      end as status,
      case
        when shielded_instance_config @> '{"enableVtpm": true, "enableIntegrityMonitoring": true}'
          then title || ' shielded VM enabled.'
        else title || ' shielded VM not enabled.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_compute_instance;
  EOQ
}

query "compute_instance_with_no_default_service_account_with_full_access" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when name like 'gke-%' and labels ? 'goog-gke-node' then 'skip'
        when account ->> 'email' like '%-compute@developer.gserviceaccount.com' and account -> 'scopes' ? 'https://www.googleapis.com/auth/cloud-platform' then 'alarm'
        else 'ok'
      end as status,
      case
        when name like 'gke-%' and labels ? 'goog-gke-node'
          then title || ' created by GKE.'
        when account ->> 'email' like '%-compute@developer.gserviceaccount.com' and account -> 'scopes' ? 'https://www.googleapis.com/auth/cloud-platform'
          then title || ' configured with default service account with full access.'
        else title || ' not configured with default service account with full access.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_compute_instance,
      jsonb_array_elements(service_accounts) account;
  EOQ
}

query "compute_instance_with_no_default_service_account" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when name like 'gke-%' and labels ? 'goog-gke-node' then 'skip'
        when account ->> 'email' like '%-compute@developer.gserviceaccount.com' then 'alarm'
        else 'ok'
      end as status,
      case
        when name like 'gke-%' and labels ? 'goog-gke-node'
          then title || ' created by GKE.'
        when account ->> 'email' like '%-compute@developer.gserviceaccount.com'
          then title || ' configured to use default service account.'
        else title || ' not configured with default service account.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_compute_instance,
      jsonb_array_elements(service_accounts) account;
  EOQ
}

query "compute_instance_with_no_public_ip_addresses" {
  sql = <<-EOQ
    with instance_without_access_config as (
      select
        name
      from
        gcp_compute_instance,
        jsonb_array_elements(network_interfaces) nic
      where
        nic ->> 'accessConfigs' is null
    ),
    instance_with_access_config as (
      select
        name
      from
        gcp_compute_instance,
        jsonb_array_elements(network_interfaces) nic,
        jsonb_array_elements(nic -> 'accessConfigs') d
      where
        d ->> 'natIP' is null
    )
    select
      self_link resource,
      case
        when name like 'gke-%' and labels ? 'goog-gke-node' then 'skip'
        when name in (select name from instance_without_access_config) then 'ok'
        when name in (select name from instance_with_access_config) then 'ok'
        else 'alarm'
      end as status,
      case
        when name like 'gke-%' and labels ? 'goog-gke-node'
          then title || ' created by GKE.'
        when name in (select name from instance_without_access_config) or name in (select name from instance_with_access_config)
          then title || ' not associated with public IP addresses.'
        else title || ' associated with public IP addresses.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_compute_instance;
  EOQ
}

query "compute_network_contains_no_default_network" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when name = 'default' then 'alarm'
        else 'ok'
      end as status,
      case
        when name = 'default'
          then title || ' is a default network.'
        else title || ' not a default network.'
      end as reason
      ${local.common_dimensions_global_sql}
    from
      gcp_compute_network;
  EOQ
}

query "compute_network_contains_no_legacy_network" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when ipv4_range is not null then 'alarm'
        else 'ok'
      end as status,
      case
        when ipv4_range is not null
          then title || ' is a legacy network.'
        else title || ' not a legacy network.'
      end as reason
      ${local.common_dimensions_global_sql}
    from
      gcp_compute_network;
  EOQ
}

query "compute_network_dns_logging_enabled" {
  sql = <<-EOQ
    with associated_networks as (
      select
        split_part(network ->> 'networkUrl', 'networks/', 2) network_name,
        enable_logging
      from
        gcp_dns_policy,
        jsonb_array_elements(networks) network
    )
    select
      net.self_link resource,
      case
        when p.network_name is null then 'alarm'
        when not p.enable_logging then 'alarm'
        else 'ok'
      end as status,
      case
        when p.network_name is null then net.title || ' not associated with DNS policy.'
        when not p.enable_logging then net.title || ' associated with DNS policy with logging disabled.'
        else net.title || ' associated with DNS policy with logging enabled.'
      end as reason
      ${local.common_dimensions_global_sql}
    from
      gcp_compute_network net
    left join associated_networks p on net.name = p.network_name;
  EOQ
}

query "compute_ssl_policy_with_no_weak_cipher" {
  sql = <<-EOQ
    with all_proxies as (
      select
        name,
        _ctx,
        self_link,
        split_part(kind, '#', 2) proxy_type,
        ssl_policy,
        title,
        location,
        project
      from
        gcp_compute_target_ssl_proxy
      union
      select
        name,
        _ctx,
        self_link,
        split_part(kind, '#', 2) proxy_type,
        ssl_policy,
        title,
        location,
        project
      from
        gcp_compute_target_https_proxy
    ),
    ssl_policy_without_weak_cipher as (
      select
        self_link
      from
        gcp_compute_ssl_policy
      where
        (profile = 'MODERN' and min_tls_version = 'TLS_1_2')
        or profile = 'RESTRICTED'
        or (profile = 'CUSTOM' and not (enabled_features ?| array['TLS_RSA_WITH_AES_128_GCM_SHA256', 'TLS_RSA_WITH_AES_256_GCM_SHA384', 'TLS_RSA_WITH_AES_128_CBC_SHA', 'TLS_RSA_WITH_AES_256_CBC_SHA', 'TLS_RSA_WITH_3DES_EDE_CBC_SHA']))
    )
    select
      self_link resource,
      case
        when ssl_policy is null or ssl_policy in (select self_link from ssl_policy_without_weak_cipher) then 'ok'
        else 'alarm'
      end as status,
      case
        when ssl_policy is null
          then proxy_type || ' ' || title || ' has no SSL policy.'
        when ssl_policy is null or ssl_policy in (select self_link from ssl_policy_without_weak_cipher)
          then proxy_type || ' ' || title || ' SSL policy contains CIS compliant cipher.'
        else proxy_type || ' ' || title || ' SSL policy contains weak cipher.'
      end as reason
      ${local.common_dimensions_global_sql}
    from all_proxies;
  EOQ
}

query "compute_firewall_rule_ingress_access_restricted_to_dns_port_53" {
  sql = <<-EOQ
    with ip_protocol_all as (
      select
        name
      from
        gcp_compute_firewall
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (
          allowed @> '[{"IPProtocol":"all"}]'
          or (allowed @> '[{"IPProtocol":"tcp"}]' and allowed -> 0 -> 'ports' is null)
          or (allowed @> '[{"IPProtocol":"udp"}]' and allowed -> 0 -> 'ports' is null)
        )
    ),
    ip_protocol_tcp_udp as (
      select
        name
      from
        gcp_compute_firewall,
        jsonb_array_elements(allowed) as p,
        jsonb_array_elements_text(p -> 'ports') as port
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (p ->> 'IPProtocol' = 'tcp' or  p ->> 'IPProtocol' = 'udp')
        and (
          port = '53'
          or (
            port like '%-%'
            and split_part(port, '-', 1) :: integer <= 53
            and split_part(port, '-', 2) :: integer >= 53
          )
        )
    )
    select
      self_link resource,
      case
        when name in (select name from ip_protocol_tcp_udp) then 'alarm'
        when name in (select name from ip_protocol_all) then 'alarm'
        else 'ok'
      end as status,
      case
        when name in (select name from ip_protocol_tcp_udp) or name in (select name from ip_protocol_all)
          then title || ' allows access from internet to DNS port 53.'
        else title || ' restricts access from internet to DNS port 53.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;
  EOQ
}

query "compute_firewall_rule_ingress_access_restricted_to_ftp_port_21" {
  sql = <<-EOQ
    with ip_protocol_all as (
      select
        name
      from
        gcp_compute_firewall
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (
          allowed @> '[{"IPProtocol":"all"}]'
          or (allowed @> '[{"IPProtocol":"tcp"}]' and allowed -> 0 -> 'ports' is null)
          or (allowed @> '[{"IPProtocol":"udp"}]' and allowed -> 0 -> 'ports' is null)
        )
    ),
    ip_protocol_tcp_udp as (
      select
        name
      from
        gcp_compute_firewall,
        jsonb_array_elements(allowed) as p,
        jsonb_array_elements_text(p -> 'ports') as port
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (p ->> 'IPProtocol' = 'tcp' or  p ->> 'IPProtocol' = 'udp')
        and (
          port = '21'
          or (
            port like '%-%'
            and split_part(port, '-', 1) :: integer <= 21
            and split_part(port, '-', 2) :: integer >= 21
          )
        )
    )
    select
      self_link resource,
      case
        when name in (select name from ip_protocol_tcp_udp) then 'alarm'
        when name in (select name from ip_protocol_all) then 'alarm'
        else 'ok'
      end as status,
      case
        when name in (select name from ip_protocol_tcp_udp) or name in (select name from ip_protocol_all)
          then title || ' allows access from internet to port 21.'
        else title || ' restricts access from internet to port 21.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;
  EOQ
}

query "compute_firewall_rule_ingress_access_restricted_to_http_port_80" {
  sql = <<-EOQ
    with ip_protocol_all as (
      select
        name
      from
        gcp_compute_firewall
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (
          allowed @> '[{"IPProtocol":"all"}]'
          or (allowed @> '[{"IPProtocol":"tcp"}]' and allowed -> 0 -> 'ports' is null)
          or (allowed @> '[{"IPProtocol":"udp"}]' and allowed -> 0 -> 'ports' is null)
        )
    ),
    ip_protocol_tcp_udp as (
      select
        name
      from
        gcp_compute_firewall,
        jsonb_array_elements(allowed) as p,
        jsonb_array_elements_text(p -> 'ports') as port
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (p ->> 'IPProtocol' = 'tcp' or  p ->> 'IPProtocol' = 'udp')
        and (
          port = '80'
          or (
            port like '%-%'
            and split_part(port, '-', 1) :: integer <= 80
            and split_part(port, '-', 2) :: integer >= 80
          )
        )
    )
    select
      self_link resource,
      case
        when name in (select name from ip_protocol_tcp_udp) then 'alarm'
        when name in (select name from ip_protocol_all) then 'alarm'
        else 'ok'
      end as status,
      case
        when name in (select name from ip_protocol_tcp_udp) or name in (select name from ip_protocol_all)
          then title || ' allows access from internet to HTTP port 80.'
        else title || ' restricts access from internet to HTTP port 80.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;
  EOQ
}

query "compute_firewall_rule_ingress_access_restricted_to_smtp_port_25" {
  sql = <<-EOQ
    with ip_protocol_all as (
      select
        name
      from
        gcp_compute_firewall
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (
          allowed @> '[{"IPProtocol":"all"}]'
          or (allowed @> '[{"IPProtocol":"tcp"}]' and allowed -> 0 -> 'ports' is null)
          or (allowed @> '[{"IPProtocol":"udp"}]' and allowed -> 0 -> 'ports' is null)
        )
    ),
    ip_protocol_tcp_udp as (
      select
        name
      from
        gcp_compute_firewall,
        jsonb_array_elements(allowed) as p,
        jsonb_array_elements_text(p -> 'ports') as port
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (p ->> 'IPProtocol' = 'tcp' or  p ->> 'IPProtocol' = 'udp')
        and (
          port = '25'
          or (
            port like '%-%'
            and split_part(port, '-', 1) :: integer <= 25
            and split_part(port, '-', 2) :: integer >= 25
          )
        )
    )
    select
      self_link resource,
      case
        when name in (select name from ip_protocol_tcp_udp) then 'alarm'
        when name in (select name from ip_protocol_all) then 'alarm'
        else 'ok'
      end as status,
      case
        when name in (select name from ip_protocol_tcp_udp) or name in (select name from ip_protocol_all)
          then title || ' allows access from internet to SMTP port 25.'
        else title || ' restricts access from internet to SMTP port 25.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;
  EOQ
}

query "compute_firewall_rule_ingress_access_restricted_to_microsoft_ds_port_445" {
  sql = <<-EOQ
    with ip_protocol_all as (
      select
        name
      from
        gcp_compute_firewall
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (
          allowed @> '[{"IPProtocol":"all"}]'
          or (allowed @> '[{"IPProtocol":"tcp"}]' and allowed -> 0 -> 'ports' is null)
          or (allowed @> '[{"IPProtocol":"udp"}]' and allowed -> 0 -> 'ports' is null)
        )
    ),
    ip_protocol_tcp_udp as (
      select
        name
      from
        gcp_compute_firewall,
        jsonb_array_elements(allowed) as p,
        jsonb_array_elements_text(p -> 'ports') as port
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (p ->> 'IPProtocol' = 'tcp' or  p ->> 'IPProtocol' = 'udp')
        and (
          port = '445'
          or (
            port like '%-%'
            and split_part(port, '-', 1) :: integer <= 445
            and split_part(port, '-', 2) :: integer >= 445
          )
        )
    )
    select
      self_link resource,
      case
        when name in (select name from ip_protocol_tcp_udp) then 'alarm'
        when name in (select name from ip_protocol_all) then 'alarm'
        else 'ok'
      end as status,
      case
        when name in (select name from ip_protocol_tcp_udp) or name in (select name from ip_protocol_all)
          then title || ' allows access from internet to Microsoft DS port 445.'
        else title || ' restricts access from internet to Microsof DS port 445.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;
  EOQ
}

query "compute_firewall_rule_ingress_access_restricted_to_mongo_db_port_27017" {
  sql = <<-EOQ
    with ip_protocol_all as (
      select
        name
      from
        gcp_compute_firewall
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (
          allowed @> '[{"IPProtocol":"all"}]'
          or (allowed @> '[{"IPProtocol":"tcp"}]' and allowed -> 0 -> 'ports' is null)
          or (allowed @> '[{"IPProtocol":"udp"}]' and allowed -> 0 -> 'ports' is null)
        )
    ),
    ip_protocol_tcp_udp as (
      select
        name
      from
        gcp_compute_firewall,
        jsonb_array_elements(allowed) as p,
        jsonb_array_elements_text(p -> 'ports') as port
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (p ->> 'IPProtocol' = 'tcp' or  p ->> 'IPProtocol' = 'udp')
        and (
          port = '27017'
          or (
            port like '%-%'
            and split_part(port, '-', 1) :: integer <= 27017
            and split_part(port, '-', 2) :: integer >= 27017
          )
        )
    )
    select
      self_link resource,
      case
        when name in (select name from ip_protocol_tcp_udp) then 'alarm'
        when name in (select name from ip_protocol_all) then 'alarm'
        else 'ok'
      end as status,
      case
        when name in (select name from ip_protocol_tcp_udp) or name in (select name from ip_protocol_all)
          then title || ' allows access from internet to MongoDB port 27017.'
        else title || ' restricts access from internet to MongoDB port 27017.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;
  EOQ
}

query "compute_firewall_rule_ingress_access_restricted_to_mysql_db_port_3306" {
  sql = <<-EOQ
    with ip_protocol_all as (
      select
        name
      from
        gcp_compute_firewall
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (
          allowed @> '[{"IPProtocol":"all"}]'
          or (allowed @> '[{"IPProtocol":"tcp"}]' and allowed -> 0 -> 'ports' is null)
          or (allowed @> '[{"IPProtocol":"udp"}]' and allowed -> 0 -> 'ports' is null)
        )
    ),
    ip_protocol_tcp_udp as (
      select
        name
      from
        gcp_compute_firewall,
        jsonb_array_elements(allowed) as p,
        jsonb_array_elements_text(p -> 'ports') as port
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (p ->> 'IPProtocol' = 'tcp' or  p ->> 'IPProtocol' = 'udp')
        and (
          port = '3306'
          or (
            port like '%-%'
            and split_part(port, '-', 1) :: integer <= 3306
            and split_part(port, '-', 2) :: integer >= 3306
          )
        )
    )
    select
      self_link resource,
      case
        when name in (select name from ip_protocol_tcp_udp) then 'alarm'
        when name in (select name from ip_protocol_all) then 'alarm'
        else 'ok'
      end as status,
      case
        when name in (select name from ip_protocol_tcp_udp) or name in (select name from ip_protocol_all)
          then title || ' allows access from internet to MySQL port 3306.'
        else title || ' restricts access from internet to MySQL port 3306.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;
  EOQ
}

query "compute_firewall_rule_ingress_access_restricted_to_netbios_snn_port_139" {
  sql = <<-EOQ
    with ip_protocol_all as (
      select
        name
      from
        gcp_compute_firewall
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (
          allowed @> '[{"IPProtocol":"all"}]'
          or (allowed @> '[{"IPProtocol":"tcp"}]' and allowed -> 0 -> 'ports' is null)
          or (allowed @> '[{"IPProtocol":"udp"}]' and allowed -> 0 -> 'ports' is null)
        )
    ),
    ip_protocol_tcp_udp as (
      select
        name
      from
        gcp_compute_firewall,
        jsonb_array_elements(allowed) as p,
        jsonb_array_elements_text(p -> 'ports') as port
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (p ->> 'IPProtocol' = 'tcp' or  p ->> 'IPProtocol' = 'udp')
        and (
          port = '139'
          or (
            port like '%-%'
            and split_part(port, '-', 1) :: integer <= 139
            and split_part(port, '-', 2) :: integer >= 139
          )
        )
    )
    select
      self_link resource,
      case
        when name in (select name from ip_protocol_tcp_udp) then 'alarm'
        when name in (select name from ip_protocol_all) then 'alarm'
        else 'ok'
      end as status,
      case
        when name in (select name from ip_protocol_tcp_udp) or name in (select name from ip_protocol_all)
          then title || ' allows access from internet to NetBIOS SSN port 139.'
        else title || ' restricts access from internet to NetBIOS SSN port 139.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;
  EOQ
}

query "compute_firewall_rule_ingress_access_restricted_to_oracle_db_port_1521" {
  sql = <<-EOQ
    with ip_protocol_all as (
      select
        name
      from
        gcp_compute_firewall
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (
          allowed @> '[{"IPProtocol":"all"}]'
          or (allowed @> '[{"IPProtocol":"tcp"}]' and allowed -> 0 -> 'ports' is null)
          or (allowed @> '[{"IPProtocol":"udp"}]' and allowed -> 0 -> 'ports' is null)
        )
    ),
    ip_protocol_tcp_udp as (
      select
        name
      from
        gcp_compute_firewall,
        jsonb_array_elements(allowed) as p,
        jsonb_array_elements_text(p -> 'ports') as port
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (p ->> 'IPProtocol' = 'tcp' or  p ->> 'IPProtocol' = 'udp')
        and (
          port = '1521'
          or (
            port like '%-%'
            and split_part(port, '-', 1) :: integer <= 1521
            and split_part(port, '-', 2) :: integer >= 1521
          )
        )
    )
    select
      self_link resource,
      case
        when name in (select name from ip_protocol_tcp_udp) then 'alarm'
        when name in (select name from ip_protocol_all) then 'alarm'
        else 'ok'
      end as status,
      case
        when name in (select name from ip_protocol_tcp_udp) or name in (select name from ip_protocol_all)
          then title || ' allows access from internet to Oracle DB port 1521.'
        else title || ' restricts access from internet to Oracle DB port 1521.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;
  EOQ
}

query "compute_firewall_rule_ingress_access_restricted_to_pop3_port_110" {
  sql = <<-EOQ
    with ip_protocol_all as (
      select
        name
      from
        gcp_compute_firewall
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (
          allowed @> '[{"IPProtocol":"all"}]'
          or (allowed @> '[{"IPProtocol":"tcp"}]' and allowed -> 0 -> 'ports' is null)
          or (allowed @> '[{"IPProtocol":"udp"}]' and allowed -> 0 -> 'ports' is null)
        )
    ),
    ip_protocol_tcp_udp as (
      select
        name
      from
        gcp_compute_firewall,
        jsonb_array_elements(allowed) as p,
        jsonb_array_elements_text(p -> 'ports') as port
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (p ->> 'IPProtocol' = 'tcp' or  p ->> 'IPProtocol' = 'udp')
        and (
          port = '110'
          or (
            port like '%-%'
            and split_part(port, '-', 1) :: integer <= 110
            and split_part(port, '-', 2) :: integer >= 110
          )
        )
    )
    select
      self_link resource,
      case
        when name in (select name from ip_protocol_tcp_udp) then 'alarm'
        when name in (select name from ip_protocol_all) then 'alarm'
        else 'ok'
      end as status,
      case
        when name in (select name from ip_protocol_tcp_udp) or name in (select name from ip_protocol_all)
          then title || ' allows access from internet to POP3 port 110.'
        else title || ' restricts access from internet to POP3 port 110.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;
  EOQ
}

query "compute_firewall_rule_ingress_access_restricted_to_postgresql_port_5432" {
  sql = <<-EOQ
    with ip_protocol_all as (
      select
        name
      from
        gcp_compute_firewall
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (
          allowed @> '[{"IPProtocol":"all"}]'
          or (allowed @> '[{"IPProtocol":"tcp"}]' and allowed -> 0 -> 'ports' is null)
          or (allowed @> '[{"IPProtocol":"udp"}]' and allowed -> 0 -> 'ports' is null)
        )
    ),
    ip_protocol_tcp_udp as (
      select
        name
      from
        gcp_compute_firewall,
        jsonb_array_elements(allowed) as p,
        jsonb_array_elements_text(p -> 'ports') as port
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (p ->> 'IPProtocol' = 'tcp' or  p ->> 'IPProtocol' = 'udp')
        and (
          port = '5432'
          or (
            port like '%-%'
            and split_part(port, '-', 1) :: integer <= 5432
            and split_part(port, '-', 2) :: integer >= 5432
          )
        )
    )
    select
      self_link resource,
      case
        when name in (select name from ip_protocol_tcp_udp) then 'alarm'
        when name in (select name from ip_protocol_all) then 'alarm'
        else 'ok'
      end as status,
      case
        when name in (select name from ip_protocol_tcp_udp) or name in (select name from ip_protocol_all)
          then title || ' allows access from internet to PostgreSQL port 5432.'
        else title || ' restricts access from internet to PostgreSQL port 5432.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;
  EOQ
}

query "compute_firewall_rule_ingress_access_restricted_to_telnet_port_23" {
  sql = <<-EOQ
    with ip_protocol_all as (
      select
        name
      from
        gcp_compute_firewall
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (
          allowed @> '[{"IPProtocol":"all"}]'
          or (allowed @> '[{"IPProtocol":"tcp"}]' and allowed -> 0 -> 'ports' is null)
          or (allowed @> '[{"IPProtocol":"udp"}]' and allowed -> 0 -> 'ports' is null)
        )
    ),
    ip_protocol_tcp_udp as (
      select
        name
      from
        gcp_compute_firewall,
        jsonb_array_elements(allowed) as p,
        jsonb_array_elements_text(p -> 'ports') as port
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (p ->> 'IPProtocol' = 'tcp' or  p ->> 'IPProtocol' = 'udp')
        and (
          port = '23'
          or (
            port like '%-%'
            and split_part(port, '-', 1) :: integer <= 23
            and split_part(port, '-', 2) :: integer >= 23
          )
        )
    )
    select
      self_link resource,
      case
        when name in (select name from ip_protocol_tcp_udp) then 'alarm'
        when name in (select name from ip_protocol_all) then 'alarm'
        else 'ok'
      end as status,
      case
        when name in (select name from ip_protocol_tcp_udp) or name in (select name from ip_protocol_all)
          then title || ' allows access from internet to Telnet port 23.'
        else title || ' restricts access from internet to Telnet port 23.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;
  EOQ
}

query "compute_network_auto_create_subnetwork_enabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when auto_create_subnetworks then 'ok'
        else 'alarm'
      end as status,
      case
        when auto_create_subnetworks then title || ' auto create subnetwork enabled.'
        else title || ' auto create subnetwork disabled.'
      end as reason
      ${local.common_dimensions_global_sql}
    from
      gcp_compute_network;
  EOQ
}

query "compute_backend_bucket_no_dangling_storage_bucket" {
  sql = <<-EOQ
    select
      b.self_link resource,
      case
        when s.name is not null then 'ok'
        else 'alarm'
      end as status,
      case
        when s.name is not null then b.title || ' has no dangling storage bucket.'
        else b.title || ' has dangling storage bucket.'
      end as reason
      ${replace(local.tag_dimensions_qualifier_sql, "__QUALIFIER__", "b.")}
      ${replace(local.common_dimensions_qualifier_sql, "__QUALIFIER__", "b.")}
    from
      gcp_compute_backend_bucket as b
      left join gcp_storage_bucket as s on s.name = b.name and s.project = b.project;
  EOQ
}

query "compute_instance_preemptible_termination_disabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when name like 'gke-%' then 'skip'
        when scheduling ->> 'preemptible' = 'true' then 'alarm'
        else 'ok'
      end as status,
      case
        when name like 'gke-%' and labels ? 'goog-gke-node'
          then title || ' created by GKE.'
        when scheduling ->> 'preemptible' = 'true' then title || ' preemptible termination enabled.'
        else title || ' preemptible termination disabled.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_compute_instance;
  EOQ
}

query "compute_instance_with_custom_metadata" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when name like 'gke-%' then 'skip'
        when metadata is not null then 'ok'
        else 'alarm'
      end as status,
      case
        when name like 'gke-%' and labels ? 'goog-gke-node'
          then title || ' created by GKE.'
        when metadata is not null then title || ' has custom metadata.'
        else title || ' has no custom metadata.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_compute_instance;
  EOQ
}

query "compute_instance_template_ip_forwarding_disabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when instance_can_ip_forward then 'alarm'
        else 'ok'
      end as status,
      case
        when instance_can_ip_forward then title || ' IP forwarding enabled.'
        else title || ' IP forwarding disabled.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_compute_instance_template;
  EOQ
}

query "compute_target_https_proxy_quic_protocol_enabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when quic_override = 'ENABLE' then 'ok'
        else 'alarm'
      end as status,
      case
        when quic_override = 'ENABLE' then title || ' QUIC override protocol enabled.'
        else title || ' QUIC override protocol disabled.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_compute_target_https_proxy;
  EOQ
}

query "compute_target_https_proxy_quic_protocol_no_default_ssl_policy" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when ssl_policy = '' then 'alarm'
        else 'ok'
      end as status,
      case
        when ssl_policy = '' then title || ' using default SSL policy.'
        else title || ' using custom SSL policy.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_compute_target_https_proxy;
  EOQ
}

query "compute_instance_no_disrupt_logging_permission" {
  sql = <<-EOQ
    with role_with_disrupt_logging_permission as (
      select
        distinct name,
        project
      from
        gcp_iam_role,
        jsonb_array_elements_text(included_permissions) as p
      where
        not is_gcp_managed
        and p in ('logging.buckets.delete', 'logging.buckets.update', 'logging.logMetrics.delete', 'logging.logMetrics.update', 'logging.logs.delete', 'logging.sinks.delete', 'logging.sinks.update')
      ), policy_with_disrupt_logging_permission as (
      select
        distinct entity,
        project
      from
        gcp_iam_policy,
        jsonb_array_elements(bindings) as p,
        jsonb_array_elements_text(p -> 'members') as entity
      where
        p ->> 'role' in ('roles/logging.bucketWriter', 'roles/logging.configWriter', 'roles/logging.admin')
        or p ->> 'role' in (select name from role_with_disrupt_logging_permission)
    ), compute_instance_with_disrupt_logging_service_permission as (
      select
        distinct self_link
      from
        gcp_compute_instance as i,
        jsonb_array_elements(service_accounts) as e
        left join policy_with_disrupt_logging_permission as b on b.entity = concat('serviceAccount:' || (e ->> 'email'))
      where
        b.entity is not null
    )
    select
      i.self_link as resource,
      case
        when p.self_link is not null then 'alarm'
        else 'ok'
      end as status,
      case
        when p.self_link is not null then i.title || ' allow disrupt logging permission.'
        else i.title || ' restrict disrupt logging permission.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_compute_instance as i
      left join compute_instance_with_disrupt_logging_service_permission as p on p.self_link = i.self_link;
  EOQ
}

query "compute_instance_no_deployments_manager_permission" {
  sql = <<-EOQ
    with role_with_deployments_manager_permission as (
      select
        distinct name,
        project
      from
        gcp_iam_role,
        jsonb_array_elements_text(included_permissions) as p
      where
        not is_gcp_managed
        and p in ('deploymentmanager.deployments.create', 'deploymentmanager.deployments.update')
      ), policy_with_deployments_manager_permission as (
      select
        distinct entity,
        project
      from
        gcp_iam_policy,
        jsonb_array_elements(bindings) as p,
        jsonb_array_elements_text(p -> 'members') as entity
      where
        p ->> 'role' in ('roles/deploymentmanager.editor')
        or p ->> 'role' in (select name from role_with_deployments_manager_permission)
    ), compute_instance_with_deployments_manage_permission as (
      select
        distinct self_link
      from
        gcp_compute_instance as i,
        jsonb_array_elements(service_accounts) as e
        left join policy_with_deployments_manager_permission as b on b.entity = concat('serviceAccount:' || (e ->> 'email'))
      where
        b.entity is not null
    )
    select
      i.self_link as resource,
      case
        when p.self_link is not null then 'alarm'
        else 'ok'
      end as status,
      case
        when p.self_link is not null then i.title || ' allow deployment managers permission.'
        else i.title || ' restrict deployment managers permission.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_compute_instance as i
      left join compute_instance_with_deployments_manage_permission as p on p.self_link = i.self_link;
  EOQ
}

query "compute_instance_no_database_write_permission" {
  sql = <<-EOQ
    with role_with_deployments_manager_permission as (
      select
        distinct name,
        project
      from
        gcp_iam_role,
        jsonb_array_elements_text(included_permissions) as p
      where
        not is_gcp_managed
        and p in ('cloudsql.databases.update', 'cloudsql.instances.update', 'datastore.databases.update', 'datastore.entities.update', 'datastore.indexes.update', 'spanner.databases.update','spanner.databases.write','spanner.instances.update', 'bigtable.clusters.update', 'bigtable.instances.update', 'bigtable.tables.update', 'redis.instances.update', 'memcache.instances.update', 'datamigration.migrationjobs.update', 'datamigration.connectionprofiles.update', 'datamigration.conversionworkspaces.update', 'alloydb.clusters.update', 'alloydb.instances.update', 'gcp.redisenterprise.com-databases.update', 'gcp.redisenterprise.com-subscriptions.update')
      ), policy_with_deployments_manager_permission as (
      select
        distinct entity,
        project
      from
        gcp_iam_policy,
        jsonb_array_elements(bindings) as p,
        jsonb_array_elements_text(p -> 'members') as entity
      where
        p ->> 'role' in ('roles/cloudsql.admin', 'roles/cloudsql.instanceUser', 'roles/datastore.indexAdmin', 'roles/datastore.owner', 'roles/datastore.user', 'roles/alloydb.admin', 'roles/bigtable.admin', 'roles/datamigration.admin', 'roles/datamigration.serviceAgent', 'roles/memcache.admin', 'roles/redis.admin', 'roles/redisenterprisecloud.admin', 'roles/spanner.admin', 'roles/spanner.databaseAdmin')
        or p ->> 'role' in (select name from role_with_deployments_manager_permission)
    ), compute_instance_with_deployments_manage_permission as (
      select
        distinct self_link
      from
        gcp_compute_instance as i,
        jsonb_array_elements(service_accounts) as e
        left join policy_with_deployments_manager_permission as b on b.entity = concat('serviceAccount:' || (e ->> 'email'))
      where
        b.entity is not null
    )
    select
      i.self_link as resource,
      case
        when p.self_link is not null then 'alarm'
        else 'ok'
      end as status,
      case
        when p.self_link is not null then i.title || ' allow database write permission.'
        else i.title || ' restrict database write permission.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_compute_instance as i
      left join compute_instance_with_deployments_manage_permission as p on p.self_link = i.self_link;
  EOQ
}

query "compute_instance_no_data_destruction_permission" {
  sql = <<-EOQ
    with role_with_data_destruction_permission as (
      select
        distinct name,
        project
      from
        gcp_iam_role,
        jsonb_array_elements_text(included_permissions) as p
      where
        not is_gcp_managed
        and p in ( 'compute.instances.delete', 'compute.disks.delete', 'compute.snapshots.delete', 'compute.images.delete', 'storage.buckets.delete', 'cloudsql.databases.delete', 'cloudsql.instances.delete', 'file.instances.delete')
      ), policy_with_data_destruction_permission as (
      select
        distinct entity,
        project
      from
        gcp_iam_policy,
        jsonb_array_elements(bindings) as p,
        jsonb_array_elements_text(p -> 'members') as entity
      where
        p ->> 'role' in ('roles/cloudsql.admin', 'roles/cloudsql.instanceUser', 'roles/compute.admin' , 'roles/compute.instanceAdmin.v1')
        or p ->> 'role' in (select name from role_with_data_destruction_permission)
    ), compute_instance_with_data_destruction_permission as (
      select
        distinct self_link
      from
        gcp_compute_instance as i,
        jsonb_array_elements(service_accounts) as e
        left join policy_with_data_destruction_permission as b on b.entity = concat('serviceAccount:' || (e ->> 'email'))
      where
        b.entity is not null
    )
    select
      i.self_link as resource,
      case
        when p.self_link is not null then 'alarm'
        else 'ok'
      end as status,
      case
        when p.self_link is not null then i.title || ' allow data destruction permission.'
        else i.title || ' restrict data destruction permission.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_compute_instance as i
      left join compute_instance_with_data_destruction_permission as p on p.self_link = i.self_link;
  EOQ
}

query "compute_instance_no_service_account_impersonate_permission" {
  sql = <<-EOQ
    with role_with_service_account_impersonate_permission as (
      select
        distinct name,
        project
      from
        gcp_iam_role,
        jsonb_array_elements_text(included_permissions) as p
      where
        not is_gcp_managed
        and p in ('iam.serviceAccounts.getAccessToken', 'iam.serviceAccounts.signBlob', 'iam.serviceAccounts.signJwt', 'iam.serviceAccounts.implicitDelegation', 'iam.serviceAccounts.getOpenIdToken', 'iam.serviceAccounts.actAs')
      ), policy_with_service_account_impersonate_permission as (
      select
        distinct entity,
        project
      from
        gcp_iam_policy,
        jsonb_array_elements(bindings) as p,
        jsonb_array_elements_text(p -> 'members') as entity
      where
        p ->> 'role' in ('roles/iam.securityAdmin' )
        or p ->> 'role' in (select name from role_with_service_account_impersonate_permission)
    ), compute_instance_with_service_account_impersonate_permission as (
      select
        distinct self_link
      from
        gcp_compute_instance as i,
        jsonb_array_elements(service_accounts) as e
        left join policy_with_service_account_impersonate_permission as b on b.entity = concat('serviceAccount:' || (e ->> 'email'))
      where
        b.entity is not null
    )
    select
      i.self_link as resource,
      case
        when p.self_link is not null then 'alarm'
        else 'ok'
      end as status,
      case
        when p.self_link is not null then i.title || ' allow service account impersonate permission.'
        else i.title || ' restrict service account impersonate permission.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_compute_instance as i
      left join compute_instance_with_service_account_impersonate_permission as p on p.self_link = i.self_link;
  EOQ
}

query "compute_instance_no_write_permission_on_deny_policy" {
  sql = <<-EOQ
    with role_with_write_permission_on_deny_policy as (
      select
        distinct name,
        project
      from
        gcp_iam_role,
        jsonb_array_elements_text(included_permissions) as p
      where
        not is_gcp_managed
        and p in ( 'iam.denypolicies.delete', 'iam.denypolicies.update')
      ), policy_with_write_permission_on_deny_policy as (
      select
        distinct entity,
        project
      from
        gcp_iam_policy,
        jsonb_array_elements(bindings) as p,
        jsonb_array_elements_text(p -> 'members') as entity
      where
        p ->> 'role' in (select name from role_with_write_permission_on_deny_policy)
    ), compute_instance_with_write_permission_on_deny_policy as (
      select
        distinct self_link
      from
        gcp_compute_instance as i,
        jsonb_array_elements(service_accounts) as e
        left join policy_with_write_permission_on_deny_policy as b on b.entity = concat('serviceAccount:' || (e ->> 'email'))
      where
        b.entity is not null
    )
    select
      i.self_link as resource,
      case
        when p.self_link is not null then 'alarm'
        else 'ok'
      end as status,
      case
        when p.self_link is not null then i.title || ' allow write permission on_deny policies.'
        else i.title || ' restrict swrite permission on_deny policies.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_compute_instance as i
      left join compute_instance_with_write_permission_on_deny_policy as p on p.self_link = i.self_link;
  EOQ
}

query "compute_instance_wth_no_high_level_basic_role" {
  sql = <<-EOQ
    with policy_with_high_level_basic_role as (
      select
        distinct entity,
        project
      from
        gcp_iam_policy,
        jsonb_array_elements(bindings) as p,
        jsonb_array_elements_text(p -> 'members') as entity
      where
        p ->> 'role' in ( 'roles/owner' , 'roles/editor' )
    ), compute_instance_with_high_level_basic_role as (
      select
        distinct self_link
      from
        gcp_compute_instance as i,
        jsonb_array_elements(service_accounts) as e
        left join policy_with_high_level_basic_role as b on b.entity = concat('serviceAccount:' || (e ->> 'email'))
      where
        b.entity is not null
    )
    select
      i.self_link as resource,
      case
        when i.name like 'gke-%' and labels ? 'goog-gke-node' then 'skip'
        when p.self_link is not null then 'alarm'
        else 'ok'
      end as status,
      case
        when i.name like 'gke-%' and labels ? 'goog-gke-node' then title || ' created by GKE.'
        when p.self_link is not null then i.title || ' allow high level basic role.'
        else i.title || ' restrict high level basic role.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_compute_instance as i
      left join compute_instance_with_high_level_basic_role as p on p.self_link = i.self_link;
  EOQ
}

query "compute_target_https_uses_latest_tls_version" {
  sql = <<-EOQ
    with all_proxies as (
      select
        name,
        _ctx,
        self_link,
        split_part(kind, '#', 2) proxy_type,
        ssl_policy,
        title,
        location,
        project
      from
        gcp_compute_target_https_proxy
    ),ssl_policy_with_no_latest_tls as (
      select
        self_link
      from
        gcp_compute_ssl_policy
      where
        (profile = 'MODERN' or profile = 'CUSTOM')
        and min_tls_version = 'TLS_1_2'
    )
    select
      self_link resource,
      case
        when ssl_policy = '' or ssl_policy in (select self_link from ssl_policy_with_no_latest_tls) then 'ok'
        else 'alarm'
      end as status,
      case
        when  ssl_policy = '' then  title || ' has no SSL policy.'
        when ssl_policy in (select self_link from ssl_policy_with_no_latest_tls) then title || ' uses latest TLS version.'
        else title || ' not uses letest TLS version.'
      end as reason
      ${local.common_dimensions_global_sql}
    from
      gcp_compute_target_https_proxy;
  EOQ
}

query "compute_external_backend_service_iap_enabled" {
  sql = <<-EOQ
    select
      self_link as resource,
      case
        when not load_balancing_scheme like 'EXTERNAL%' then 'skip'
        when (iap -> 'enabled')::bool then 'ok'
        else 'alarm'
      end as status,
      case
        when not load_balancing_scheme like 'EXTERNAL%' then name || ' is external backend service.'
        when (iap -> 'enabled')::bool then name || ' IAP enabled.'
        else name || ' IAP disabled.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_backend_service;
  EOQ
}

query "compute_firewall_rule_restrict_ingress_all_with_no_specific_target" {
  sql = <<-EOQ
    with ip_protocol_all as (
      select
       distinct name
      from
        gcp_compute_firewall
      where
        direction = 'INGRESS'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and target_tags is null
        and allowed is not null
        and target_service_accounts is null
      )
    select
      self_link resource,
      case
        when name in (select name from ip_protocol_all) then 'alarm'
        else 'ok'
      end as status,
      case
        when name in (select name from ip_protocol_all) then title || ' allows ingress from internet with no specific target.'
        else title || ' restricts ingress from internet with no specific target.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;
  EOQ
}

query "compute_firewall_rule_ingress_access_restricted_to_postgresql_port_10250" {
  sql = <<-EOQ
    with ip_protocol_all as (
      select
        name
      from
        gcp_compute_firewall
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (
          allowed @> '[{"IPProtocol":"all"}]'
          or (allowed @> '[{"IPProtocol":"tcp"}]' and allowed -> 0 -> 'ports' is null)
          or (allowed @> '[{"IPProtocol":"udp"}]' and allowed -> 0 -> 'ports' is null)
        )
    ),
    ip_protocol_tcp_udp as (
      select
        name
      from
        gcp_compute_firewall,
        jsonb_array_elements(allowed) as p,
        jsonb_array_elements_text(p -> 'ports') as port
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (p ->> 'IPProtocol' = 'tcp' or  p ->> 'IPProtocol' = 'udp')
        and (
          port = '10250'
          or (
            port like '%-%'
            and split_part(port, '-', 1) :: integer <= 10250
            and split_part(port, '-', 2) :: integer >= 10250
          )
        )
    )
    select
      self_link resource,
      case
        when name in (select name from ip_protocol_tcp_udp) then 'alarm'
        when name in (select name from ip_protocol_all) then 'alarm'
        else 'ok'
      end as status,
      case
        when name in (select name from ip_protocol_tcp_udp) or name in (select name from ip_protocol_all)
          then title || ' allows access from internet to DNS port 10250.'
        else title || ' restricts access from internet to DNS port 10250.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;
  EOQ
}

query "compute_firewall_rule_ingress_access_restricted_to_postgresql_port_10255" {
  sql = <<-EOQ
    with ip_protocol_all as (
      select
        name
      from
        gcp_compute_firewall
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (
          allowed @> '[{"IPProtocol":"all"}]'
          or (allowed @> '[{"IPProtocol":"tcp"}]' and allowed -> 0 -> 'ports' is null)
          or (allowed @> '[{"IPProtocol":"udp"}]' and allowed -> 0 -> 'ports' is null)
        )
    ),
    ip_protocol_tcp_udp as (
      select
        name
      from
        gcp_compute_firewall,
        jsonb_array_elements(allowed) as p,
        jsonb_array_elements_text(p -> 'ports') as port
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (p ->> 'IPProtocol' = 'tcp' or  p ->> 'IPProtocol' = 'udp')
        and (
          port = '10255'
          or (
            port like '%-%'
            and split_part(port, '-', 1) :: integer <= 10255
            and split_part(port, '-', 2) :: integer >= 10255
          )
        )
    )
    select
      self_link resource,
      case
        when name in (select name from ip_protocol_tcp_udp) then 'alarm'
        when name in (select name from ip_protocol_all) then 'alarm'
        else 'ok'
      end as status,
      case
        when name in (select name from ip_protocol_tcp_udp) or name in (select name from ip_protocol_all)
          then title || ' allows access from internet to DNS port 10255.'
        else title || ' restricts access from internet to DNS port 10255.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;
  EOQ
}

query "compute_firewall_rule_restrict_ingress_all" {
  sql = <<-EOQ
    with ip_protocol_all as (
      select
       distinct name
      from
        gcp_compute_firewall
      where
        direction = 'INGRESS'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
         and allowed @> '[{"IPProtocol":"all"}]'
      )
    select
      self_link resource,
      case
        when name in (select name from ip_protocol_all) then 'alarm'
        else 'ok'
      end as status,
      case
        when name in (select name from ip_protocol_all) then title || ' allows ingress from internet to all ports.'
        else title || ' restricts ingress from internet to all ports.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;
  EOQ
}

query "compute_instance_no_iam_write_permission" {
  sql = <<-EOQ
    with role_with_iam_write_permission as (
      select
        distinct name,
        project
      from
        gcp_iam_role,
        jsonb_array_elements_text(included_permissions) as p
      where
        not is_gcp_managed
        and p in ( 'accessapproval.requests.approve','accessapproval.requests.dismiss','accessapproval.settings.delete','accessapproval.settings.update','accesscontextmanager.accessLevels.create','accesscontextmanager.accessLevels.delete','accesscontextmanager.accessLevels.replaceAll','accesscontextmanager.accessLevels.update','accesscontextmanager.accessPolicies.create','accesscontextmanager.accessPolicies.delete','accesscontextmanager.accessPolicies.setIamPolicy','accesscontextmanager.accessPolicies.update','accesscontextmanager.gcpUserAccessBindings.create','accesscontextmanager.gcpUserAccessBindings.delete','accesscontextmanager.gcpUserAccessBindings.update','accesscontextmanager.policies.create','accesscontextmanager.policies.delete','accesscontextmanager.policies.setIamPolicy','accesscontextmanager.policies.update','iam.roles.create','iam.roles.delete','iam.roles.undelete', 'iam.roles.update','iam.serviceAccounts.getAccessToken','iam.serviceAccountKeys.create','iam.serviceAccountKeys.delete','iam.serviceAccounts.create','iam.serviceAccounts.delete','iam.serviceAccounts.disable','iam.serviceAccounts.enable','iam.serviceAccounts.setIamPolicy','iam.serviceAccounts.undelete','iam.serviceAccounts.update','iam.serviceAccounts.implicitDelegation','iam.serviceAccounts.signBlob','iam.serviceAccounts.signJwt','iam.serviceAccounts.actAs','compute.backendServices.setIamPolicy','compute.disks.removeResourcePolicies','compute.disks.setIamPolicy','compute.firewallPolicies.setIamPolicy','compute.globalOperations.setIamPolicy','compute.images.setIamPolicy','compute.instanceTemplates.setIamPolicy','compute.instances.removeResourcePolicies','compute.instances.setIamPolicy','compute.instances.setServiceAccount','compute.machineImages.setIamPolicy','compute.maintenancePolicies.setIamPolicy','compute.snapshots.setIamPolicy')
      ), policy_with_iam_write_permission as (
      select
        distinct entity,
        project
      from
        gcp_iam_policy,
        jsonb_array_elements(bindings) as p,
        jsonb_array_elements_text(p -> 'members') as entity
      where
        p ->> 'role' in (select name from role_with_iam_write_permission )
    ), compute_instance_with_iam_write_permission as (
      select
        distinct self_link
      from
        gcp_compute_instance as i,
        jsonb_array_elements(service_accounts) as e
        left join policy_with_iam_write_permission as b on b.entity = concat('serviceAccount:' || (e ->> 'email'))
      where
        b.entity is not null
    )
    select
      i.self_link as resource,
      case
        when p.self_link is not null then 'alarm'
        else 'ok'
      end as status,
      case
        when p.self_link is not null then i.title || ' allow IAM write permission.'
        else i.title || ' restrict IAM write permission'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_compute_instance as i
      left join compute_instance_with_iam_write_permission as p on p.self_link = i.self_link;
  EOQ
}

query "compute_firewall_default_rule_restrict_ingress_access_except_http_and_https" {
  sql = <<-EOQ
    with default_firewall_rule as (
      select
       distinct name
      from
        gcp_compute_firewall
      where
        direction = 'INGRESS'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::/0']
        )
         and name in ('default-allow-ssh', 'default-allow-icmp', 'default-allow-internal', 'default-allow-rdp')
      )
    select
      self_link resource,
      case
        when not name like 'default-%' then 'skip'
        when name in (select name from default_firewall_rule) then 'alarm'
        else 'ok'
      end as status,
      case
        when not name like 'default-%' then title || ' is not default firewall.'
        when name in (select name from default_firewall_rule) then title || ' is default firewall with public access.'
        else title || ' is default firewall with no public access.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;
  EOQ
}

query "compute_firewall_rule_ingress_access_restricted_to_tcp_port_9090" {
  sql = <<-EOQ
    with ip_protocol_all as (
      select
        name
      from
        gcp_compute_firewall
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (
          allowed @> '[{"IPProtocol":"all"}]'
          or (allowed @> '[{"IPProtocol":"tcp"}]' and allowed -> 0 -> 'ports' is null)
        )
    ),
    ip_protocol_tcp_udp as (
      select
        name
      from
        gcp_compute_firewall,
        jsonb_array_elements(allowed) as p,
        jsonb_array_elements_text(p -> 'ports') as port
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (p ->> 'IPProtocol' = 'tcp')
        and (
          port = '9090'
          or (
            port like '%-%'
            and split_part(port, '-', 1) :: integer <= 9090
            and split_part(port, '-', 2) :: integer >= 9090
          )
        )
    )
    select
      self_link resource,
      case
        when name in (select name from ip_protocol_tcp_udp) then 'alarm'
        when name in (select name from ip_protocol_all) then 'alarm'
        else 'ok'
      end as status,
      case
        when name in (select name from ip_protocol_tcp_udp) or name in (select name from ip_protocol_all)
          then title || ' allows access from internet to TCP port 9090.'
        else title || ' restricts access from internet to TCP port 9090.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;
  EOQ
}

query "compute_firewall_rule_ingress_access_restricted_to_tcp_port_9200_9300" {
  sql = <<-EOQ
    with ip_protocol_all as (
      select
        name
      from
        gcp_compute_firewall
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (
          allowed @> '[{"IPProtocol":"all"}]'
          or (allowed @> '[{"IPProtocol":"tcp"}]' and allowed -> 0 -> 'ports' is null)
        )
    ),
    ip_protocol_tcp_udp as (
      select
        name
      from
        gcp_compute_firewall,
        jsonb_array_elements(allowed) as p,
        jsonb_array_elements_text(p -> 'ports') as port
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (p ->> 'IPProtocol' = 'tcp')
        and (
          port = '9200'
          or port = '9300'
          or (
            port like '%-%'
            and (
              (split_part(port, '-', 1) :: integer <= 9200 and split_part(port, '-', 2) :: integer >= 9200)
              or (split_part(port, '-', 1) :: integer <= 9300 and split_part(port, '-', 2) :: integer >= 9300)
            )
          )
        )
    )
    select
      self_link resource,
      case
        when name in (select name from ip_protocol_tcp_udp) then 'alarm'
        when name in (select name from ip_protocol_all) then 'alarm'
        else 'ok'
      end as status,
      case
        when name in (select name from ip_protocol_tcp_udp) or name in (select name from ip_protocol_all)
          then title || ' allows access from internet to TCP port 9200 or 9300.'
        else title || ' restricts access from internet to TCP port 9200 or 9300.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;
  EOQ
}

query "compute_firewall_rule_logging_enabled" {
  sql = <<-EOQ
    select
      self_link as resource,
      case
        when log_config_enable then 'ok'
        else 'alarm'
      end as status,
      case
        when log_config_enable then name || ' logging enabled.'
        else name || ' logging disabled.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;
  EOQ
}

query "compute_firewall_rule_ingress_access_restricted_to_tcp_port_7000_7001" {
  sql = <<-EOQ
   with ip_protocol_all as (
      select
        name
      from
        gcp_compute_firewall
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (
          allowed @> '[{"IPProtocol":"all"}]'
          or (allowed @> '[{"IPProtocol":"tcp"}]' and allowed -> 0 -> 'ports' is null)
        )
    ),
    ip_protocol_tcp_udp as (
      select
        name
      from
        gcp_compute_firewall,
        jsonb_array_elements(allowed) as p,
        jsonb_array_elements_text(p -> 'ports') as port
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (p ->> 'IPProtocol' = 'tcp')
        and (
          port = '7000'
          or port = '7001'
          or (
            port like '%-%'
            and (
              (split_part(port, '-', 1) :: integer <= 7000 and split_part(port, '-', 2) :: integer >= 7000)
              or (split_part(port, '-', 1) :: integer <= 7001 and split_part(port, '-', 2) :: integer >= 7001)
            )
          )
        )
    )
    select
      self_link resource,
      case
        when name in (select name from ip_protocol_tcp_udp) then 'alarm'
        when name in (select name from ip_protocol_all) then 'alarm'
        else 'ok'
      end as status,
      case
        when name in (select name from ip_protocol_tcp_udp) or name in (select name from ip_protocol_all)
          then title || ' allows access from internet to TCP port 7000 or 7001.'
        else title || ' restricts access from internet to TCP port 7000 or 7001.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;
  EOQ
}

query "compute_firewall_rule_ingress_access_restricted_to_tcp_port_7199" {
  sql = <<-EOQ
    with ip_protocol_all as (
      select
        name
      from
        gcp_compute_firewall
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (
          allowed @> '[{"IPProtocol":"all"}]'
          or (allowed @> '[{"IPProtocol":"tcp"}]' and allowed -> 0 -> 'ports' is null)
        )
    ),
    ip_protocol_tcp_udp as (
      select
        name
      from
        gcp_compute_firewall,
        jsonb_array_elements(allowed) as p,
        jsonb_array_elements_text(p -> 'ports') as port
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (p ->> 'IPProtocol' = 'tcp')
        and (
          port = '7199'
          or (
            port like '%-%'
            and split_part(port, '-', 1) :: integer <= 7199
            and split_part(port, '-', 2) :: integer >= 7199
          )
        )
    )
    select
      self_link resource,
      case
        when name in (select name from ip_protocol_tcp_udp) then 'alarm'
        when name in (select name from ip_protocol_all) then 'alarm'
        else 'ok'
      end as status,
      case
        when name in (select name from ip_protocol_tcp_udp) or name in (select name from ip_protocol_all)
          then title || ' allows access from internet to TCP port 7199.'
        else title || ' restricts access from internet to TCP port 7199.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;
  EOQ
}

query "compute_firewall_rule_ingress_access_restricted_to_tcp_port_8888" {
  sql = <<-EOQ
    with ip_protocol_all as (
      select
        name
      from
        gcp_compute_firewall
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (
          allowed @> '[{"IPProtocol":"all"}]'
          or (allowed @> '[{"IPProtocol":"tcp"}]' and allowed -> 0 -> 'ports' is null)
        )
    ),
    ip_protocol_tcp_udp as (
      select
        name
      from
        gcp_compute_firewall,
        jsonb_array_elements(allowed) as p,
        jsonb_array_elements_text(p -> 'ports') as port
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (p ->> 'IPProtocol' = 'tcp')
        and (
          port = '8888'
          or (
            port like '%-%'
            and split_part(port, '-', 1) :: integer <= 8888
            and split_part(port, '-', 2) :: integer >= 8888
          )
        )
    )
    select
      self_link resource,
      case
        when name in (select name from ip_protocol_tcp_udp) then 'alarm'
        when name in (select name from ip_protocol_all) then 'alarm'
        else 'ok'
      end as status,
      case
        when name in (select name from ip_protocol_tcp_udp) or name in (select name from ip_protocol_all)
          then title || ' allows access from internet to TCP port 8888.'
        else title || ' restricts access from internet to TCP port 8888.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;
  EOQ
}

query "compute_firewall_rule_ingress_access_restricted_to_tcp_port_9042" {
  sql = <<-EOQ
    with ip_protocol_all as (
      select
        name
      from
        gcp_compute_firewall
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (
          allowed @> '[{"IPProtocol":"all"}]'
          or (allowed @> '[{"IPProtocol":"tcp"}]' and allowed -> 0 -> 'ports' is null)
        )
    ),
    ip_protocol_tcp_udp as (
      select
        name
      from
        gcp_compute_firewall,
        jsonb_array_elements(allowed) as p,
        jsonb_array_elements_text(p -> 'ports') as port
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (p ->> 'IPProtocol' = 'tcp')
        and (
          port = '9042'
          or (
            port like '%-%'
            and split_part(port, '-', 1) :: integer <= 9042
            and split_part(port, '-', 2) :: integer >= 9042
          )
        )
    )
    select
      self_link resource,
      case
        when name in (select name from ip_protocol_tcp_udp) then 'alarm'
        when name in (select name from ip_protocol_all) then 'alarm'
        else 'ok'
      end as status,
      case
        when name in (select name from ip_protocol_tcp_udp) or name in (select name from ip_protocol_all)
          then title || ' allows access from internet to TCP port 9042.'
        else title || ' restricts access from internet to TCP port 9042.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;
  EOQ
}

query "compute_firewall_rule_ingress_access_restricted_to_tcp_port_9160" {
  sql = <<-EOQ
    with ip_protocol_all as (
      select
        name
      from
        gcp_compute_firewall
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (
          allowed @> '[{"IPProtocol":"all"}]'
          or (allowed @> '[{"IPProtocol":"tcp"}]' and allowed -> 0 -> 'ports' is null)
        )
    ),
    ip_protocol_tcp_udp as (
      select
        name
      from
        gcp_compute_firewall,
        jsonb_array_elements(allowed) as p,
        jsonb_array_elements_text(p -> 'ports') as port
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (p ->> 'IPProtocol' = 'tcp')
        and (
          port = '9160'
          or (
            port like '%-%'
            and split_part(port, '-', 1) :: integer <= 9160
            and split_part(port, '-', 2) :: integer >= 9160
          )
        )
    )
    select
      self_link resource,
      case
        when name in (select name from ip_protocol_tcp_udp) then 'alarm'
        when name in (select name from ip_protocol_all) then 'alarm'
        else 'ok'
      end as status,
      case
        when name in (select name from ip_protocol_tcp_udp) or name in (select name from ip_protocol_all)
          then title || ' allows access from internet to TCP port 9160.'
        else title || ' restricts access from internet to TCP port 9160.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;
  EOQ
}

query "compute_firewall_rule_ingress_access_restricted_to_tcp_port_61620_61621" {
  sql = <<-EOQ
   with ip_protocol_all as (
      select
        name
      from
        gcp_compute_firewall
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (
          allowed @> '[{"IPProtocol":"all"}]'
          or (allowed @> '[{"IPProtocol":"tcp"}]' and allowed -> 0 -> 'ports' is null)
        )
    ),
    ip_protocol_tcp_udp as (
      select
        name
      from
        gcp_compute_firewall,
        jsonb_array_elements(allowed) as p,
        jsonb_array_elements_text(p -> 'ports') as port
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (p ->> 'IPProtocol' = 'tcp')
        and (
          port = '61620'
          or port = '61621'
          or (
            port like '%-%'
            and (
              (split_part(port, '-', 1) :: integer <= 61620 and split_part(port, '-', 2) :: integer >= 61620)
              or (split_part(port, '-', 1) :: integer <= 61621 and split_part(port, '-', 2) :: integer >= 61621)
            )
          )
        )
    )
    select
      self_link resource,
      case
        when name in (select name from ip_protocol_tcp_udp) then 'alarm'
        when name in (select name from ip_protocol_all) then 'alarm'
        else 'ok'
      end as status,
      case
        when name in (select name from ip_protocol_tcp_udp) or name in (select name from ip_protocol_all)
          then title || ' allows access from internet to TCP port 61620 or 61621.'
        else title || ' restricts access from internet to TCP port 61620 or 61621.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;
  EOQ
}

query "compute_firewall_rule_ingress_access_restricted_to_tcp_port_6379" {
  sql = <<-EOQ
    with ip_protocol_all as (
      select
        name
      from
        gcp_compute_firewall
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (
          allowed @> '[{"IPProtocol":"all"}]'
          or (allowed @> '[{"IPProtocol":"tcp"}]' and allowed -> 0 -> 'ports' is null)
        )
    ),
    ip_protocol_tcp_udp as (
      select
        name
      from
        gcp_compute_firewall,
        jsonb_array_elements(allowed) as p,
        jsonb_array_elements_text(p -> 'ports') as port
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (p ->> 'IPProtocol' = 'tcp')
        and (
          port = '6379'
          or (
            port like '%-%'
            and split_part(port, '-', 1) :: integer <= 6379
            and split_part(port, '-', 2) :: integer >= 6379
          )
        )
    )
    select
      self_link resource,
      case
        when name in (select name from ip_protocol_tcp_udp) then 'alarm'
        when name in (select name from ip_protocol_all) then 'alarm'
        else 'ok'
      end as status,
      case
        when name in (select name from ip_protocol_tcp_udp) or name in (select name from ip_protocol_all)
          then title || ' allows access from internet to TCP port 6379.'
        else title || ' restricts access from internet to TCP port 6379.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;
  EOQ
}

query "compute_firewall_rule_ingress_access_restricted_to_tcp_port_137_to_139" {
  sql = <<-EOQ
    with ip_protocol_all as (
      select
        name
      from
        gcp_compute_firewall
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (
          allowed @> '[{"IPProtocol":"all"}]'
          or (allowed @> '[{"IPProtocol":"tcp"}]' and allowed -> 0 -> 'ports' is null)
        )
    ),
    ip_protocol_tcp_udp as (
      select
        name
      from
        gcp_compute_firewall,
        jsonb_array_elements(allowed) as p,
        jsonb_array_elements_text(p -> 'ports') as port
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (p ->> 'IPProtocol' = 'tcp')
        and (
          port = '137'
          or port = '138'
          or port = '139'
          or (
            port like '%-%'
            and (
              (split_part(port, '-', 1) :: integer <= 137 and split_part(port, '-', 2) :: integer >= 137)
              or (split_part(port, '-', 1) :: integer <= 138 and split_part(port, '-', 2) :: integer >= 138)
              or (split_part(port, '-', 1) :: integer <= 139 and split_part(port, '-', 2) :: integer >= 139)
            )
          )
        )
    )
    select
      self_link resource,
      case
        when name in (select name from ip_protocol_tcp_udp) then 'alarm'
        when name in (select name from ip_protocol_all) then 'alarm'
        else 'ok'
      end as status,
      case
        when name in (select name from ip_protocol_tcp_udp) or name in (select name from ip_protocol_all)
          then title || ' allows access from internet to TCP port 137-139.'
        else title || ' restricts access from internet to TCP port 137-139.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;

  EOQ
}

query "compute_firewall_rule_ingress_access_restricted_to_tcp_port_27017_to_27019" {
  sql = <<-EOQ
    with ip_protocol_all as (
      select
        name
      from
        gcp_compute_firewall
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (
          allowed @> '[{"IPProtocol":"all"}]'
          or (allowed @> '[{"IPProtocol":"tcp"}]' and allowed -> 0 -> 'ports' is null)
        )
    ),
    ip_protocol_tcp_udp as (
      select
        name
      from
        gcp_compute_firewall,
        jsonb_array_elements(allowed) as p,
        jsonb_array_elements_text(p -> 'ports') as port
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (p ->> 'IPProtocol' = 'tcp')
        and (
          port = '27017'
          or port = '27018'
          or port = '27019'
          or (
            port like '%-%'
            and (
              (split_part(port, '-', 1) :: integer <= 27017 and split_part(port, '-', 2) :: integer >= 27017)
              or (split_part(port, '-', 1) :: integer <= 27018 and split_part(port, '-', 2) :: integer >= 27018)
              or (split_part(port, '-', 1) :: integer <= 27019 and split_part(port, '-', 2) :: integer >= 27019)
            )
          )
        )
    )
    select
      self_link resource,
      case
        when name in (select name from ip_protocol_tcp_udp) then 'alarm'
        when name in (select name from ip_protocol_all) then 'alarm'
        else 'ok'
      end as status,
      case
        when name in (select name from ip_protocol_tcp_udp) or name in (select name from ip_protocol_all)
          then title || ' allows access from internet to TCP port 27017-27019.'
        else title || ' restricts access from internet to TCP port 27017-27019.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;
  EOQ
}

query "compute_firewall_rule_ingress_access_restricted_to_tcp_udp_port_389" {
  sql = <<-EOQ
    with ip_protocol_all as (
      select
        name
      from
        gcp_compute_firewall
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (
          allowed @> '[{"IPProtocol":"all"}]'
          or (allowed @> '[{"IPProtocol":"tcp"}]' and allowed -> 0 -> 'ports' is null)
          or (allowed @> '[{"IPProtocol":"udp"}]' and allowed -> 0 -> 'ports' is null)
        )
    ),
    ip_protocol_tcp_udp as (
      select
        name
      from
        gcp_compute_firewall,
        jsonb_array_elements(allowed) as p,
        jsonb_array_elements_text(p -> 'ports') as port
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (p ->> 'IPProtocol' = 'tcp' or  p ->> 'IPProtocol' = 'udp')
        and (
          port = '389'
          or (
            port like '%-%'
            and split_part(port, '-', 1) :: integer <= 389
            and split_part(port, '-', 2) :: integer >= 389
          )
        )
    )
    select
      self_link resource,
      case
        when name in (select name from ip_protocol_tcp_udp) then 'alarm'
        when name in (select name from ip_protocol_all) then 'alarm'
        else 'ok'
      end as status,
      case
        when name in (select name from ip_protocol_tcp_udp) or name in (select name from ip_protocol_all)
          then title || ' allows access from internet to TCP or UDP port 389.'
        else title || ' restricts access from internet to TCP or UDP port 389.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;
  EOQ
}

query "compute_firewall_rule_ingress_access_restricted_to_tcp_port_636" {
  sql = <<-EOQ
    with ip_protocol_all as (
      select
        name
      from
        gcp_compute_firewall
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (
          allowed @> '[{"IPProtocol":"all"}]'
          or (allowed @> '[{"IPProtocol":"tcp"}]' and allowed -> 0 -> 'ports' is null)
        )
    ),
    ip_protocol_tcp_udp as (
      select
        name
      from
        gcp_compute_firewall,
        jsonb_array_elements(allowed) as p,
        jsonb_array_elements_text(p -> 'ports') as port
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (p ->> 'IPProtocol' = 'tcp')
        and (
          port = '636'
          or (
            port like '%-%'
            and split_part(port, '-', 1) :: integer <= 636
            and split_part(port, '-', 2) :: integer >= 636
          )
        )
    )
    select
      self_link resource,
      case
        when name in (select name from ip_protocol_tcp_udp) then 'alarm'
        when name in (select name from ip_protocol_all) then 'alarm'
        else 'ok'
      end as status,
      case
        when name in (select name from ip_protocol_tcp_udp) or name in (select name from ip_protocol_all)
          then title || ' allows access from internet to TCP port 636.'
        else title || ' restricts access from internet to TCP port 636.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;
  EOQ
}

query "compute_firewall_rule_ingress_access_restricted_to_tcp_udp_port_11211" {
  sql = <<-EOQ
    with ip_protocol_all as (
      select
        name
      from
        gcp_compute_firewall
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (
          allowed @> '[{"IPProtocol":"all"}]'
          or (allowed @> '[{"IPProtocol":"tcp"}]' and allowed -> 0 -> 'ports' is null)
          or (allowed @> '[{"IPProtocol":"udp"}]' and allowed -> 0 -> 'ports' is null)
        )
    ),
    ip_protocol_tcp_udp as (
      select
        name
      from
        gcp_compute_firewall,
        jsonb_array_elements(allowed) as p,
        jsonb_array_elements_text(p -> 'ports') as port
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (p ->> 'IPProtocol' = 'tcp' or  p ->> 'IPProtocol' = 'udp')
        and (
          port = '11211'
          or (
            port like '%-%'
            and split_part(port, '-', 1) :: integer <= 11211
            and split_part(port, '-', 2) :: integer >= 11211
          )
        )
    )
    select
      self_link resource,
      case
        when name in (select name from ip_protocol_tcp_udp) then 'alarm'
        when name in (select name from ip_protocol_all) then 'alarm'
        else 'ok'
      end as status,
      case
        when name in (select name from ip_protocol_tcp_udp) or name in (select name from ip_protocol_all)
          then title || ' allows access from internet to TCP or UDP port 11211.'
        else title || ' restricts access from internet to TCP or UDP port 11211.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;
  EOQ
}

query "compute_firewall_rule_ingress_access_restricted_to_tcp_udp_port_11214_to_11215" {
  sql = <<-EOQ
    with ip_protocol_all as (
      select
        name
      from
        gcp_compute_firewall
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (
          allowed @> '[{"IPProtocol":"all"}]'
          or (allowed @> '[{"IPProtocol":"tcp"}]' and allowed -> 0 -> 'ports' is null)
          or (allowed @> '[{"IPProtocol":"udp"}]' and allowed -> 0 -> 'ports' is null)
        )
    ),
    ip_protocol_tcp_udp_11214_11215 as (
      select
        name
      from
        gcp_compute_firewall,
        jsonb_array_elements(allowed) as p,
        jsonb_array_elements_text(p -> 'ports') as port
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (p ->> 'IPProtocol' = 'tcp' or  p ->> 'IPProtocol' = 'udp')
        and (
          port = '11214'
          or port = '11215'
          or (
            port like '%-%'
            and split_part(port, '-', 1) :: integer <= 11214
            and split_part(port, '-', 2) :: integer >= 11214
            and split_part(port, '-', 1) :: integer <= 11215
            and split_part(port, '-', 2) :: integer >= 11215
          )
        )
    )
    select
      self_link resource,
      case
        when name in (select name from ip_protocol_tcp_udp_11214_11215) then 'alarm'
        when name in (select name from ip_protocol_all) then 'alarm'
        else 'ok'
      end as status,
      case
        when name in (select name from ip_protocol_tcp_udp_11214_11215) then title || ' allows access from internet to TCP or UDP ports 11214-11215.'
        when name in (select name from ip_protocol_all) then title || ' allows access from internet to all protocols.'
        else title || ' restricts access from internet to TCP or UDP ports 11214-11215.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;
  EOQ
}

query "compute_firewall_rule_ingress_access_restricted_to_tcp_udp_port_2483_to_2484" {
  sql = <<-EOQ
    with ip_protocol_all as (
      select
        name
      from
        gcp_compute_firewall
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (
          allowed @> '[{"IPProtocol":"all"}]'
          or (allowed @> '[{"IPProtocol":"tcp"}]' and allowed -> 0 -> 'ports' is null)
          or (allowed @> '[{"IPProtocol":"udp"}]' and allowed -> 0 -> 'ports' is null)
        )
    ),
    ip_protocol_tcp_udp_2483_2484 as (
      select
        name
      from
        gcp_compute_firewall,
        jsonb_array_elements(allowed) as p,
        jsonb_array_elements_text(p -> 'ports') as port
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and (
          source_ranges ?& array['0.0.0.0/0']
          or source_ranges ?& array['::0']
          or source_ranges ?& array['0.0.0.0']
          or source_ranges ?& array['::/0']
          or source_ranges ?& array['::']
        )
        and (p ->> 'IPProtocol' = 'tcp' or  p ->> 'IPProtocol' = 'udp')
        and (
          port = '2483'
          or port = '2484'
          or (
            port like '%-%'
            and split_part(port, '-', 1) :: integer <= 2483
            and split_part(port, '-', 2) :: integer >= 2483
            and split_part(port, '-', 1) :: integer <= 2484
            and split_part(port, '-', 2) :: integer >= 2484
          )
        )
    )
    select
      self_link resource,
      case
        when name in (select name from ip_protocol_tcp_udp_2483_2484) then 'alarm'
        when name in (select name from ip_protocol_all) then 'alarm'
        else 'ok'
      end as status,
      case
        when name in (select name from ip_protocol_tcp_udp_2483_2484) then title || ' allows access from internet to TCP or UDP ports 2483-2484.'
        when name in (select name from ip_protocol_all) then title || ' allows access from internet to all protocols.'
        else title || ' restricts access from internet to TCP or UDP ports 2483-2484.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;
  EOQ
}
