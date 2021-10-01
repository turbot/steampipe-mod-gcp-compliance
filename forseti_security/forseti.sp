locals {
  forseti_security_common_tags = {
    forseti_security_v226   = "true"
    plugin                  = "gcp"
  }
}

benchmark "forseti_security" {
  title         = "Forseti Security v2.26.0"
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
  title         = "Check that CMEK rotation policy is in place and is sufficiently short"
  sql           = query.kms_key_rotated_within_100_day.sql

  tags = merge(local.forseti_security_common_tags, {
    severity  = "high"
  })
}

control "denylist_public_users" {
  title         = "Prevent public users from having access to resources via IAM"
  sql           = query.iam_user_denylist_public.sql

  tags = merge(local.forseti_security_common_tags, {
    severity  = "high"
  })
}

control "iam_restrict_service_account_key_age_one_hundred_days" {
  title         = "Check if service account keys are older than 100 days"
  sql           = query.iam_service_account_key_age_100.sql

  tags = merge(local.forseti_security_common_tags, {
    severity  = "high"
  })
}

control "only_my_domain" {
  title         = "Only allow members from my domain to be added to IAM roles"
  sql           = query.iam_user_uses_corporate_login_credentials.sql

  tags = merge(local.forseti_security_common_tags, {
    severity  = "high"
  })
}

control "require_bq_table_iam" {
  title         = "Check if BigQuery datasets are publicly readable"
  sql           = query.bigquery_dataset_not_publicly_accessible.sql

  tags = merge(local.forseti_security_common_tags, {
    severity  = "high"
  })
}

control "restrict_firewall_rule_world_open" {
  title         = "Check for open firewall rules allowing ingress from the internet"
  sql           = query.compute_firewall_rule_ssh_access_restricted.sql

  tags = merge(local.forseti_security_common_tags, {
    severity  = "high"
  })
}

control "restrict_firewall_rule_world_open_tcp_udp_all_ports" {
  title         = "Check for open firewall rules allowing TCP/UDP from the internet"
  sql           = query.compute_firewall_rule_rdp_access_restricted.sql

  tags = merge(local.forseti_security_common_tags, {
    severity  = "high"
  })
}

control "restrict_gmail_bigquery_dataset" {
  title         = "Enforce corporate domain by banning gmail.com addresses access to BigQuery datasets"
  sql           = query.bigquery_dataset_restrict_gmail.sql

  tags = merge(local.forseti_security_common_tags, {
    severity  = "high"
  })
}

control "restrict_googlegroups_bigquery_dataset" {
  title         = "Enforce corporate domain by banning googlegroups.com addresses access to BigQuery datasets"
  sql           = query.bigquery_dataset_restrict_googlegroups.sql

  tags = merge(local.forseti_security_common_tags, {
    severity  = "high"
  })
}

control "sql_world_readable" {
  title         = "Check if Cloud SQL instances are world readable"
  sql           = query.sql_instance_not_open_to_internet.sql

  tags = merge(local.forseti_security_common_tags, {
    severity  = "high"
  })
}
