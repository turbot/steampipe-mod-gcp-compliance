locals {
  policy_bundle_bigquery_common_tags = merge(local.gcp_compliance_common_tags, {
    service = "GCP/BigQuery"
  })
}

control "require_bq_table_iam" {
  title = "Check if BigQuery datasets are publicly readable"
  query = query.bigquery_dataset_not_publicly_accessible

  tags = merge(local.policy_bundle_bigquery_common_tags, {
    cft_scorecard_v1      = "true"
    forseti_security_v226 = "true"
    severity              = "high"
  })
}

control "restrict_gmail_bigquery_dataset" {
  title = "Enforce corporate domain by banning gmail.com addresses access to BigQuery datasets"
  query = query.bigquery_dataset_restrict_gmail

  tags = merge(local.policy_bundle_bigquery_common_tags, {
    cft_scorecard_v1      = "true"
    forseti_security_v226 = "true"
    severity              = "high"
  })
}

control "restrict_googlegroups_bigquery_dataset" {
  title = "Enforce corporate domain by banning googlegroups.com addresses access to BigQuery datasets"
  query = query.bigquery_dataset_restrict_googlegroups

  tags = merge(local.policy_bundle_bigquery_common_tags, {
    cft_scorecard_v1      = "true"
    forseti_security_v226 = "true"
    severity              = "high"
  })
}