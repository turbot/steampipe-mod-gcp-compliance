locals {
  all_controls_bigquery_common_tags = merge(local.all_controls_common_tags, {
    service = "GCP/BigQuery"
  })
}

benchmark "all_controls_bigquery" {
  title       = "BigQuery"
  description = "This section contains recommendations for configuring BigQuery resources."
  children = [
    control.bigquery_dataset_encrypted_with_cmk,
    control.bigquery_table_encrypted_with_cmk,
    control.require_bq_table_iam,
    control.restrict_gmail_bigquery_dataset,
    control.restrict_googlegroups_bigquery_dataset,
  ]

  tags = merge(local.all_controls_bigquery_common_tags, {
    type = "Benchmark"
  })
}
