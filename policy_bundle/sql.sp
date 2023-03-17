locals {
  policy_bundle_sql_common_tags = merge(local.gcp_compliance_common_tags, {
    service = "GCP/SQL"
  })
}

control "sql_world_readable" {
  title = "Check if Cloud SQL instances are world readable"
  query = query.sql_instance_not_open_to_internet

  tags = merge(local.policy_bundle_sql_common_tags, {
    cft_scorecard_v1      = "true"
    forseti_security_v226 = "true"
    severity              = "high"
  })
}

control "prevent_public_ip_cloudsql" {
  title = "Prevent a public IP from being assigned to a Cloud SQL instance"
  query = query.sql_instance_with_no_public_ips

  tags = merge(local.policy_bundle_sql_common_tags, {
    cft_scorecard_v1 = "true"
    severity         = "high"
  })
}

control "require_ssl_sql" {
  title = "Check if Cloud SQL instances have SSL turned on"
  query = query.sql_instance_require_ssl_enabled

  tags = merge(local.policy_bundle_sql_common_tags, {
    cft_scorecard_v1 = "true"
    severity         = "high"
  })
}

query "sql_instance_not_open_to_internet" {
  sql = <<-EOQ
    select 
      -- Required Columns
      self_link as resource,
      case 
        when ip_configuration -> 'authorizedNetworks' @> '[{"name": "internet", "value": "0.0.0.0/0"}]' then 'alarm'
        else 'ok'
      end status,
      case 
        when ip_configuration -> 'authorizedNetworks' @> '[{"name": "internet", "value": "0.0.0.0/0"}]'
          then title || ' is open to internet.'
        else title || ' is not open to internet.'
      end reason
      -- Additional Dimensions
    ${local.tag_dimensions_sql}
    ${local.common_dimensions_sql}
    from
      gcp_sql_database_instance;
  EOQ
}

query "sql_instance_with_no_public_ips" {
  sql = <<-EOQ
    select 
      -- Required Columns
      self_link resource,
      case
        when ip_addresses @> '[{"type": "PRIMARY"}]' and backend_type = 'SECOND_GEN' then 'alarm'
        else 'ok'
      end status,
      case
        when ip_addresses @> '[{"type": "PRIMARY"}]' and backend_type = 'SECOND_GEN' 
          then title || ' associated with public IPs.'
        else title || ' not associated with public IPs.'
      end reason
      -- Additional Dimensions
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_sql_database_instance;
  EOQ
}

query "sql_instance_require_ssl_enabled" {
  sql = <<-EOQ
    select 
      -- Required Columns
      self_link resource,
      case
        when ip_configuration -> 'requireSsl' is null then 'alarm'
        else 'ok'
      end status,
      case
        when ip_configuration -> 'requireSsl' is null
          then title || ' does not enforce SSL connections.'
        else title || ' enforces SSL connections.'
      end reason
      -- Additional Dimensions
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_sql_database_instance;
  EOQ
}