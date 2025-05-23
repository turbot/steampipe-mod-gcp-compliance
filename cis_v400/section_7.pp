locals {
  cis_v400_7_common_tags = merge(local.cis_v400_common_tags, {
    cis_section_id = "7"
  })
}

benchmark "cis_v400_7" {
  title         = "7 BigQuery"
  documentation = file("./cis_v400/docs/cis_v400_7.md")
  children = [
    control.cis_v400_7_1,
    control.cis_v400_7_2,
    control.cis_v400_7_3,
    control.cis_v400_7_4
  ]

  tags = merge(local.cis_v400_7_common_tags, {
    type    = "Benchmark"
    service = "GCP/BigQuery"
  })
}

control "cis_v400_7_1" {
  title         = "7.1 Ensure That BigQuery Datasets Are Not Anonymously or Publicly Accessible"
  description   = "It is recommended that the IAM policy on BigQuery datasets does not allow anonymous and/or public access."
  query         = query.bigquery_dataset_not_publicly_accessible
  documentation = file("./cis_v400/docs/cis_v400_7_1.md")

  tags = merge(local.cis_v400_7_common_tags, {
    cis_item_id = "7.1"
    cis_type    = "automated"
    cis_level   = "1"
    service     = "GCP/BigQuery"
  })
}

control "cis_v400_7_2" {
  title         = "7.2 Ensure That All BigQuery Tables Are Encrypted With Customer-Managed Encryption Key (CMEK)"
  description   = "BigQuery by default encrypts the data as rest by employing `Envelope Encryption` using Google managed cryptographic keys. The data is encrypted using the data encryption keys and data encryption keys themselves are further encrypted using key encryption keys. This is seamless and do not require any additional input from the user. However, if you want to have greater control, Customer-managed encryption keys (CMEK) can be used as encryption key management solution for BigQuery Data Sets. If CMEK is used, the CMEK is used to encrypt the data encryption keys instead of using google-managed encryption keys."
  query         = query.bigquery_table_encrypted_with_cmk
  documentation = file("./cis_v400/docs/cis_v400_7_2.md")

  tags = merge(local.cis_v400_7_common_tags, {
    cis_item_id = "7.2"
    cis_type    = "automated"
    cis_level   = "2"
    service     = "GCP/BigQuery"
  })
}

control "cis_v400_7_3" {
  title         = "7.3 Ensure That a Default Customer-Managed Encryption Key (CMEK) Is Specified for All BigQuery Data Sets"
  description   = "BigQuery by default encrypts the data as rest by employing `Envelope Encryption` using Google managed cryptographic keys. The data is encrypted using the data encryption keys and data encryption keys themselves are further encrypted using key encryption keys. This is seamless and do not require any additional input from the user. However, if you want to have greater control, Customer-managed encryption keys (CMEK) can be used as encryption key management solution for BigQuery Data Sets."
  query         = query.bigquery_dataset_encrypted_with_cmk
  documentation = file("./cis_v400/docs/cis_v400_7_3.md")

  tags = merge(local.cis_v400_7_common_tags, {
    cis_item_id = "7.3"
    cis_type    = "automated"
    cis_level   = "2"
    service     = "GCP/BigQuery"
  })
}

control "cis_v400_7_4" {
  title         = "7.4 Ensure all data in BigQuery has been classified"
  description   = "BigQuery tables can contain sensitive data that for security purposes should be discovered, monitored, classified, and protected. Google Cloud's Sensitive Data Protection tools can automatically provide data classification of all BigQuery data across an organization."
  query         = query.manual_control
  documentation = file("./cis_v400/docs/cis_v400_7_4.md")

  tags = merge(local.cis_v400_7_common_tags, {
    cis_item_id = "7.4"
    cis_type    = "manual"
    cis_level   = "2"
    service     = "GCP/BigQuery"
  })
}
