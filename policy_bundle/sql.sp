locals {
  policy_bundle_sql_common_tags = {
    service = "sql"
  }
}

control "sql_world_readable" {
  title         = "Check if Cloud SQL instances are world readable"
  sql           = query.sql_instance_not_open_to_internet.sql

  tags = merge(local.policy_bundle_sql_common_tags, {
    cft_scorecard_v1        = "true"
    forseti_security_v226   = "true"
    severity                = "high"
  })
}

control "prevent_public_ip_cloudsql" {
  title         = "Prevent a public IP from being assigned to a Cloud SQL instance"
  sql           = query.sql_instance_with_no_public_ips.sql

  tags = merge(local.policy_bundle_sql_common_tags, {
    cft_scorecard_v1   = "true"
    severity           = "high"
  })
}

control "require_ssl_sql" {
  title         = "Check if Cloud SQL instances have SSL turned on"
  sql           = query.sql_instance_require_ssl_enabled.sql

  tags = merge(local.policy_bundle_sql_common_tags, {
    cft_scorecard_v1   = "true"
    severity           = "high"
  })
}