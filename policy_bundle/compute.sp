locals {
  policy_bundle_compute_common_tags = merge(local.gcp_compliance_common_tags, {
    service = "GCP/Compute"
  })
}

control "restrict_firewall_rule_rdp_world_open" {
  title = "Check for open firewall rules allowing RDP from the internet"
  query = query.compute_firewall_rule_rdp_access_restricted

  tags = merge(local.policy_bundle_compute_common_tags, {
    cft_scorecard_v1 = "true"
    severity         = "high"
  })
}

control "enable_network_flow_logs" {
  title = "Ensure VPC Flow logs is enabled for every subnet in VPC Network"
  query = query.compute_subnetwork_flow_log_enabled

  tags = merge(local.policy_bundle_compute_common_tags, {
    cft_scorecard_v1 = "true"
    severity         = "high"
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
    severity              = "high"
  })
}

control "restrict_firewall_rule_world_open_tcp_udp_all_ports" {
  title = "Check for open firewall rules allowing TCP/UDP from the internet"
  query = query.compute_firewall_rule_rdp_access_restricted

  tags = merge(local.policy_bundle_compute_common_tags, {
    forseti_security_v226 = "true"
    severity              = "high"
  })
}

control "compute_disk_encrypted_with_csk" {
  title       = "Ensure VM disks for critical VMs are encrypted with Customer-Supplied Encryption Keys (CSEK)"
  description = "Customer-Supplied Encryption Keys (CSEK) are a feature in Google Cloud Storage and Google Compute Engine. If you supply your own encryption keys, Google uses your key to protect the Google-generated keys used to encrypt and decrypt your data. By default, Google Compute Engine encrypts all data at rest. Compute Engine handles and manages this encryption for you without any additional actions on your part. However, if you wanted to control and manage this encryption yourself, you can provide your own encryption keys."
  query       = query.compute_disk_encrypted_with_csk

  tags = local.policy_bundle_compute_common_tags
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

  tags = local.policy_bundle_compute_common_tags
}

control "compute_instance_block_project_wide_ssh_enabled" {
  title       = "Ensure 'Block Project-wide SSH keys' is enabled for VM instances"
  description = "It is recommended to use Instance specific SSH key(s) instead of using common/shared project-wide SSH key(s) to access Instances."
  query       = query.compute_instance_block_project_wide_ssh_enabled

  tags = local.policy_bundle_compute_common_tags
}

control "compute_instance_confidential_computing_enabled" {
  title       = "Ensure that Compute instances have Confidential Computing enabled"
  description = "Google Cloud encrypts data at-rest and in-transit, but customer data must be decrypted for processing. Confidential Computing is a breakthrough technology which encrypts data in-use—while it is being processed. Confidential Computing environments keep data encrypted in memory and elsewhere outside the central processing unit (CPU)."
  query       = query.compute_instance_confidential_computing_enabled

  tags = local.policy_bundle_compute_common_tags
}

control "compute_instance_ip_forwarding_disabled" {
  title       = "Ensure that IP forwarding is not enabled on Instances"
  description = "Compute Engine instance cannot forward a packet unless the source IP address of the packet matches the IP address of the instance. Similarly, GCP won't deliver a packet whose destination IP address is different than the IP address of the instance receiving the packet. However, both capabilities are required if you want to use instances to help route packets."
  query       = query.compute_instance_ip_forwarding_disabled

  tags = local.policy_bundle_compute_common_tags
}

control "compute_instance_oslogin_enabled" {
  title       = "Ensure OS login is enabled for a Project"
  description = "Enabling OS login binds SSH certificates to IAM users and facilitates effective SSH certificate management."
  query       = query.compute_instance_oslogin_enabled

  tags = local.policy_bundle_compute_common_tags
}

control "compute_instance_serial_port_connection_disabled" {
  title       = "Ensure 'Enable connecting to serial ports' is not enabled for VM Instance"
  description = "Interacting with a serial port is often referred to as the serial console, which is similar to using a terminal window, in that input and output is entirely in text mode and there is no graphical interface or mouse support."
  query       = query.compute_instance_serial_port_connection_disabled

  tags = local.policy_bundle_compute_common_tags
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

  tags = local.policy_bundle_compute_common_tags
}

control "compute_instance_with_no_default_service_account" {
  title       = "Ensure that instances are not configured to use the default service account"
  description = "It is recommended to configure your instance to not use the default Compute Engine service account because it has the Editor role on the project."
  query       = query.compute_instance_with_no_default_service_account

  tags = local.policy_bundle_compute_common_tags
}

control "compute_instance_with_no_public_ip_addresses" {
  title       = "Ensure that Compute instances do not have public IP addresses"
  description = "Compute instances should not be configured to have external IP addresses."
  query       = query.compute_instance_with_no_public_ip_addresses

  tags = local.policy_bundle_compute_common_tags
}

control "compute_network_contains_no_default_network" {
  title       = "Ensure that the default network does not exist in a project"
  description = "To prevent the use of default network, a project should not have a default network."
  query       = query.compute_network_contains_no_default_network

  tags = local.policy_bundle_compute_common_tags
}

control "compute_network_contains_no_legacy_network" {
  title       = "Ensure legacy networks do not exist for a project"
  description = "In order to prevent use of legacy networks, a project should not have a legacy network configured."
  query       = query.compute_network_contains_no_legacy_network

  tags = local.policy_bundle_compute_common_tags
}

control "compute_network_dns_logging_enabled" {
  title       = "Ensure that Cloud DNS logging is enabled for all VPC networks"
  description = "Cloud DNS logging records the queries from the name servers within your VPC to Stackdriver. Logged queries can come from Compute Engine VMs, GKE containers, or other GCP resources provisioned within the VPC."
  query       = query.compute_network_dns_logging_enabled

  tags = local.policy_bundle_compute_common_tags
}

control "compute_ssl_policy_with_no_weak_cipher" {
  title       = "Ensure no HTTPS or SSL proxy load balancers permit SSL policies with weak cipher suites"
  description = "Secure Sockets Layer (SSL) policies determine what port Transport Layer Security (TLS) features clients are permitted to use when connecting to load balancers."
  query       = query.compute_ssl_policy_with_no_weak_cipher

  tags = local.policy_bundle_compute_common_tags
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
          ( allowed @> '[{"IPProtocol":"tcp","ports":["80","443"]}]'
            or allowed @> '[{"IPProtocol":"tcp","ports":["80"]}]'
            or allowed @> '[{"IPProtocol":"tcp","ports":["443"]}]'
          )
          and source_ranges ?& array['130.211.0.0/22', '35.235.240.0/20', '35.191.0.0/16'] then 'ok'
        else 'alarm'
      end as status,
      case
        when
          ( allowed @> '[{"IPProtocol":"tcp","ports":["80","443"]}]'
            or allowed @> '[{"IPProtocol":"tcp","ports":["80"]}]'
            or allowed @> '[{"IPProtocol":"tcp","ports":["443"]}]'
          )
          and source_ranges ?& array['130.211.0.0/22', '35.235.240.0/20', '35.191.0.0/16']
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
