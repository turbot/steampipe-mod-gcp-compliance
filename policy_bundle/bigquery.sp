locals {
  policy_bundle_bigquery_common_tags = merge(local.gcp_compliance_common_tags, {
    service = "GCP/BigQuery"
  })
}

control "require_bq_table_iam" {
  title         = "Check if BigQuery datasets are publicly readable"
  sql           = query.bigquery_dataset_not_publicly_accessible.sql

  tags = merge(local.policy_bundle_bigquery_common_tags, {
    cft_scorecard_v1        = "true"
    forseti_security_v226   = "true"
    severity                = "high"
  })
}

control "restrict_gmail_bigquery_dataset" {
  title         = "Enforce corporate domain by banning gmail.com addresses access to BigQuery datasets"
  sql           = query.bigquery_dataset_restrict_gmail.sql

  tags = merge(local.policy_bundle_bigquery_common_tags, {
    cft_scorecard_v1        = "true"
    forseti_security_v226   = "true"
    severity                = "high"
  })
}

control "restrict_googlegroups_bigquery_dataset" {
  title         = "Enforce corporate domain by banning googlegroups.com addresses access to BigQuery datasets"
  sql           = query.bigquery_dataset_restrict_googlegroups.sql

  tags = merge(local.policy_bundle_bigquery_common_tags, {
    cft_scorecard_v1        = "true"
    forseti_security_v226   = "true"
    severity                = "high"
  })
}