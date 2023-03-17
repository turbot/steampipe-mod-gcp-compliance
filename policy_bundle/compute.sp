locals {
  policy_bundle_compute_common_tags = merge(local.gcp_compliance_common_tags, {
    service = "GCP/Compute"
  })
}

control "restrict_firewall_rule_world_open" {
  title = "Check for open firewall rules allowing ingress from the internet"
  query = query.compute_firewall_rule_ssh_access_restricted

  tags = merge(local.policy_bundle_compute_common_tags, {
    cft_scorecard_v1      = "true"
    forseti_security_v226 = "true"
    severity              = "high"
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
// two controls using same query
control "restrict_firewall_rule_ssh_world_open" {
  title = "Check for open firewall rules allowing SSH from the internet"
  query = query.compute_firewall_rule_ssh_access_restricted

  tags = merge(local.policy_bundle_compute_common_tags, {
    cft_scorecard_v1 = "true"
    severity         = "high"
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
      -- Required Columns
      self_link resource,
      case
        when name in (select name from ip_protocol_tcp) then 'alarm'
        when name in (select name from ip_protocol_all) then 'alarm'
        else 'ok'
      end status,
      case
        when name in (select name from ip_protocol_tcp) or name in (select name from ip_protocol_all)
          then title || ' allows SSH access from internet.'
        else title || ' restricts SSH access from internet.'
      end reason
      -- Additional Dimensions
      ${local.tag_dimensions_sql}
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
      -- Required Columns
      self_link resource,
      case
        when name in (select name from ip_protocol_tcp) then 'alarm'
        when name in (select name from ip_protocol_all) then 'alarm'
        else 'ok'
      end status,
      case
        when name in (select name from ip_protocol_tcp) or name in (select name from ip_protocol_all)
          then title || ' allows RDP access from internet.'
        else title || ' restricts RDP access from internet.'
      end reason
      -- Additional Dimensions
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_compute_firewall;
  EOQ
}

query "compute_subnetwork_flow_log_enabled" {
  sql = <<-EOQ
    select
      -- Required Columns
      self_link resource,
      case
        when enable_flow_logs then 'ok'
        else 'alarm'
      end status,
      case
        when enable_flow_logs
          then title || ' flow logging enabled.'
        else title || ' flow logging disabled.'
      end reason
      -- Additional Dimensions
      ${local.common_dimensions_sql}
    from
      gcp_compute_subnetwork;
  EOQ
}

query "compute_subnetwork_private_ip_google_access" {
  sql = <<-EOQ
    select
      -- Required Columns
      self_link resource,
      case
        when private_ip_google_access then 'ok'
        else 'alarm'
      end status,
      case
        when private_ip_google_access then title || ' private Google Access is enabled.'
        else title || ' private Google Access is disabled.'
      end reason
      -- Additional Dimensions
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_compute_subnetwork;
  EOQ
}