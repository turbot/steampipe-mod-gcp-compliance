locals {
  forseti_security_common_tags = {
    benchmark   = "forseti_security"
    version     = "v2.26.0"
    plugin      = "gcp"
  }
}

benchmark "forseti_security" {
  title         = "Forseti Security"
  description   = "Forseti Security Benchmark covers foundational security elements of Google Cloud Platform."
  documentation = file("./forseti_security/docs/forseti_security_overview.md")
  tags          = local.forseti_security_common_tags
  children = [
      control.cmek_rotation_one_hundred_days,
      control.denylist_public_users,
      control.iam_restrict_service_account_key_age_one_hundred_days,
      control.only_my_domain,
      control.require_bq_table_iam,
      control.restrict_firewall_rule_world_open,
      control.restrict_firewall_rule_world_open_tcp_udp_all_ports,
      control.restrict_gmail_bigquery_dataset,
      control.restrict_googlegroups_bigquery_dataset,
      control.sql_world_readable
  ]
}

control "cmek_rotation_one_hundred_days" {
  title         = "CMEK should be rotated within 100 days"
  description   = "Checks that CMEK rotation policy is in place and is sufficiently short."
  sql           = query.kms_key_rotated_within_100_day.sql

  tags = merge(local.forseti_security_common_tags, {
    severity  = "high"
  })
}

control "denylist_public_users" {
  title         = "Deny public users IAM access"
  description   = "Prevent public users from having access to resources via IAM."
  sql           = query.iam_user_denylist_public.sql

  tags = merge(local.forseti_security_common_tags, {
    severity  = "high"
  })
}

control "iam_restrict_service_account_key_age_one_hundred_days" {
  title         = "Service account keys older than 100 days"
  description   = "Checks if service account keys are older than 100 days."
  sql           = query.iam_service_account_key_age_100.sql

  tags = merge(local.forseti_security_common_tags, {
    severity  = "high"
  })
}

control "only_my_domain" {
  title         = "Domain members to be added to IAM roles"
  description   = "Only allow members from my domain to be added to IAM roles."
  sql           = query.iam_user_uses_corporate_login_credentials.sql

  tags = merge(local.forseti_security_common_tags, {
    severity  = "high"
  })
}

control "require_bq_table_iam" {
  title         = "BigQuery datasets public readability"
  description   = "Checks if BigQuery datasets are publicly readable or allAuthenticatedUsers."
  sql           = query.bigquery_dataset_not_publicly_accessible.sql

  tags = merge(local.forseti_security_common_tags, {
    severity  = "high"
  })
}

control "restrict_firewall_rule_world_open" {
  title         = "Check open firewall rules allowing ingress"
  description   = "Checks for open firewall rules allowing ingress from the internet."
  sql           = query.compute_firewall_rule_ssh_access_restricted.sql

  tags = merge(local.forseti_security_common_tags, {
    severity  = "high"
  })
}

control "restrict_firewall_rule_world_open_tcp_udp_all_ports" {
  title         = "Check open firewall rules allowing TCP/UDP"
  description   = "Checks for open firewall rules allowing TCP/UDP from the internet."
  sql           = query.compute_firewall_rule_rdp_access_restricted.sql

  tags = merge(local.forseti_security_common_tags, {
    severity  = "high"
  })
}

control "restrict_gmail_bigquery_dataset" {
  title         = "Restrict gmail BigQuery dataset access"
  description   = "Enforce corporate domain by banning gmail.com addresses access to BigQuery datasets."
  sql           = query.bigquery_dataset_restrict_gmail.sql

  tags = merge(local.forseti_security_common_tags, {
    severity  = "high"
  })
}

control "restrict_googlegroups_bigquery_dataset" {
  title         = "Restrict google groups BigQuery dataset access"
  description   = "Enforce corporate domain by banning googlegroups.com addresses access to BigQuery datasets."
  sql           = query.bigquery_dataset_restrict_googlegroups.sql

  tags = merge(local.forseti_security_common_tags, {
    severity  = "high"
  })
}

control "sql_world_readable" {
  title         = "Cloud SQL instances world readable"
  description   = "Checks if Cloud SQL instances are world readable."
  sql           = query.sql_instance_not_open_to_internet.sql

  tags = merge(local.forseti_security_common_tags, {
    severity  = "high"
  })
}