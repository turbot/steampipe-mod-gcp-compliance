locals {
  cft_scorecard_common_tags = {
    benchmark   = "cft_scorecard"
    version     = "v1"
    plugin      = "gcp"
  }
}

benchmark "cft_scorecard" {
  title         = "CFT Scorecard v1"
  description   = "Forseti Security Benchmark covers foundational security elements of Google Cloud Platform."
  documentation = file("./cft_scorecard_v1/docs/cft_scorecard_overview.md")
  tags          = local.cft_scorecard_common_tags
  children = [
    #   control.denylist_public_users,
      control.require_bq_table_iam,
      control.restrict_firewall_rule_world_open,
      control.restrict_firewall_rule_rdp_world_open,
    #   control.restrict_gmail_bigquery_dataset,
    #   control.restrict_googlegroups_bigquery_dataset,
      control.sql_world_readable,
      control.require_ssl_sql,
      control.restrict_firewall_rule_ssh_world_open,
      control.require_bucket_policy_only,
      control.prevent_public_ip_cloudsql,
      control.dnssec_prevent_rsasha1_ksk,
      control.dnssec_prevent_rsasha1_zsk,
      control.enable_network_flow_logs,
      control.enable_network_private_google_access
    #   control.allow_only_private_cluster,
    #   control.disable_gke_dashboard
  ]
}

# control "denylist_public_users" {
#   title         = "Deny public users IAM access"
#   description   = "Prevent public users from having access to resources via IAM."
#   sql           = query.iam_user_denylist_public.sql

#   tags = merge(local.cft_scorecard_common_tags, {
#     severity  = "high"
#   })
# }

control "require_bq_table_iam" {
  title         = "BigQuery datasets public readability"
  description   = "Checks if BigQuery datasets are publicly readable or allAuthenticatedUsers."
  sql           = query.bigquery_dataset_not_publicly_accessible.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity  = "high"
  })
}

control "restrict_firewall_rule_world_open" {
  title         = "Check open firewall rules allowing ingress"
  description   = "Checks for open firewall rules allowing ingress from the internet."
  sql           = query.compute_firewall_rule_ssh_access_restricted.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity  = "high"
  })
}

control "restrict_firewall_rule_rdp_world_open" {
  title         = "Check open firewall rules allowing RDP"
  description   = "Checks for open firewall rules allowing RDP from the internet."
  sql           = query.compute_firewall_rule_rdp_access_restricted.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity  = "high"
  })
}

control "restrict_firewall_rule_ssh_world_open" {
  title         = "Check open firewall rules allowing SSH"
  description   = "Checks for open firewall rules allowing SSH from the internet."
  sql           = query.compute_firewall_rule_ssh_access_restricted.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity  = "high"
  })
}

# control "restrict_gmail_bigquery_dataset" {
#   title         = "Restrict gmail BigQuery dataset access"
#   description   = "Enforce corporate domain by banning gmail.com addresses access to BigQuery datasets."
#   sql           = query.bigquery_dataset_restrict_gmail.sql

#   tags = merge(local.cft_scorecard_common_tags, {
#     severity  = "high"
#   })
# }

# control "restrict_googlegroups_bigquery_dataset" {
#   title         = "Restrict google groups BigQuery dataset access"
#   description   = "Enforce corporate domain by banning googlegroups.com addresses access to BigQuery datasets."
#   sql           = query.bigquery_dataset_restrict_googlegroups.sql

#   tags = merge(local.cft_scorecard_common_tags, {
#     severity  = "high"
#   })
# }

control "sql_world_readable" {
  title         = "Cloud SQL instances world readable"
  description   = "Checks if Cloud SQL instances are world readable."
  sql           = query.sql_instance_not_open_to_internet.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity  = "high"
  })
}

control "prevent_public_ip_cloudsql" {
  title         = "Cloud SQL instance assigned public IP"
  description   = "Prevents a public IP from being assigned to a Cloud SQL instance."
  sql           = query.sql_instance_with_no_public_ips.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity  = "high"
  })
}

control "require_ssl_sql" {
  title         = "Cloud SQL instances SSL enabled"
  description   = "Checks if Cloud SQL instances have SSL turned on."
  sql           = query.sql_instance_require_ssl_enabled.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity  = "high"
  })
}

control "require_bucket_policy_only" {
  title         = "Cloud Storage buckets Bucket Only Policy turned on"
  description   = "Checks if Cloud Storage buckets have Bucket Only Policy turned on."
  sql           = query.storage_bucket_bucket_policy_only_enabled.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity  = "high"
  })
}

control "dnssec_prevent_rsasha1_ksk" {
  title         = "Cloud DNS key-signing key not RSASHA1"
  description   = "Ensure that RSASHA1 is not used for key-signing key in Cloud DNS."
  sql           = query.dns_managed_zone_key_signing_not_using_rsasha1.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity  = "high"
  })
}

control "dnssec_prevent_rsasha1_zsk" {
  title         = "Cloud DNS zone-signing key not RSASHA1"
  description   = "Ensure that RSASHA1 is not used for zone-signing key in Cloud DNS."
  sql           = query.dns_managed_zone_zone_signing_not_using_rsasha1.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity  = "high"
  })
}

control "enable_network_flow_logs" {
  title         = "VPC network subnet flow log enabled"
  description   = "Ensure VPC Flow logs is enabled for every subnet in VPC Network."
  sql           = query.compute_subnetwork_flow_log_enabled.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity  = "high"
  })
}

control "enable_network_private_google_access" {
  title         = "VPC subnetwork private Google access"
  description   = "Ensure Private Google Access is enabled for all subnetworks in VPC."
  sql           = query.compute_subnetwork_private_ip_google_access.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity  = "high"
  })
}

