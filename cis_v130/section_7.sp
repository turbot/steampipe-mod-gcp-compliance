locals {
  cis_v130_7_common_tags = merge(local.cis_v130_common_tags, {
    cis_section_id = "7"
  })
}

benchmark "cis_v130_7" {
  title         = "7 BigQuery"
  documentation = file("./cis_v130/docs/cis_v130_7.md")
  children = [
    control.cis_v130_7_1,
    control.cis_v130_7_2,
    control.cis_v130_7_3
  ]

  tags = merge(local.cis_v130_7_common_tags, {
    type    = "Benchmark"
    service = "GCP/BigQuery"
  })
}

control "cis_v130_7_1" {
  title         = "7.1 Ensure that BigQuery datasets are not anonymously or publicly accessible"
  description   = "It is recommended that the IAM policy on BigQuery datasets does not allow anonymous and/or public access."
  sql           = query.bigquery_dataset_not_publicly_accessible.sql
  documentation = file("./cis_v130/docs/cis_v130_7_1.md")

  tags = merge(local.cis_v130_7_common_tags, {
    cis_item_id = "7.1"
    cis_type    = "automated"
    cis_level   = "1"
    service     = "GCP/BigQuery"
  })
}

control "cis_v130_7_2" {
  title         = "7.2 Ensure that all BigQuery Tables are encrypted with Customer-managed encryption key (CMEK)"
  description   = "BigQuery by default encrypts the data as rest by employing Envelope Encryption using Google managed cryptographic keys. The data is encrypted using the data encryption keys and data encryption keys themselves are further encrypted using key encryption keys. This is seamless and do not require any additional input from the user. However, if you want to have greater control, Customer-managed encryption keys (CMEK) can be used as encryption key management solution for BigQuery Data Sets. If CMEK is used, the CMEK is used to encrypt the data encryption keys instead of using google-managed encryption keys."
  sql           = query.bigquery_table_encrypted_with_cmk.sql
  documentation = file("./cis_v130/docs/cis_v130_7_2.md")

  tags = merge(local.cis_v130_7_common_tags, {
    cis_item_id = "7.2"
    cis_type    = "automated"
    cis_level   = "2"
    service     = "GCP/BigQuery"
  })
}

control "cis_v130_7_3" {
  title         = "7.3 Ensure that a Default Customer-managed encryption key (CMEK) is specified for all BigQuery Data Sets"
  description   = "BigQuery by default encrypts the data as rest by employing Envelope Encryption using Google managed cryptographic keys. The data is encrypted using the data encryption keys and data encryption keys themselves are further encrypted using key encryption keys. This is seamless and do not require any additional input from the user. However, if you want to have greater control, Customer-managed encryption keys (CMEK) can be used as encryption key management solution for BigQuery Data Sets."
  sql           = query.bigquery_dataset_encrypted_with_cmk.sql
  documentation = file("./cis_v130/docs/cis_v130_7_3.md")

  tags = merge(local.cis_v130_7_common_tags, {
    cis_item_id = "7.3"
    cis_type    = "automated"
    cis_level   = "2"
    service     = "GCP/BigQuery"
  })
}
