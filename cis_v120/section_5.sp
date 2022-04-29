locals {
  cis_v120_5_common_tags = merge(local.cis_v120_common_tags, {
    cis_section_id = "5"
  })
}

benchmark "cis_v120_5" {
  title         = "5 Storage"
  documentation = file("./cis_v120/docs/cis_v120_5.md")
  children = [
    control.cis_v120_5_1,
    control.cis_v120_5_2
  ]

  tags = merge(local.cis_v120_5_common_tags, {
    type = "Benchmark"
  })
}

control "cis_v120_5_1" {
  title         = "5.1 Ensure that Cloud Storage bucket is not anonymously or publicly accessible"
  description   = "It is recommended that IAM policy on Cloud Storage bucket does not allows anonymous or public access."
  sql           = query.storage_bucket_not_publicly_accessible.sql
  documentation = file("./cis_v120/docs/cis_v120_5_1.md")

  tags = merge(local.cis_v120_5_common_tags, {
    cis_item_id = "5.1"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/Storage"
  })
}

control "cis_v120_5_2" {
  title         = "5.2 Ensure that Cloud Storage buckets have uniform bucket-level access enabled"
  description   = "It is recommended that uniform bucket-level access is enabled on Cloud Storage buckets."
  sql           = query.storage_bucket_uniform_access_enabled.sql
  documentation = file("./cis_v120/docs/cis_v120_5_2.md")

  tags = merge(local.cis_v120_5_common_tags, {
    cis_item_id = "5.2"
    cis_level   = "2"
    cis_type    = "automated"
    service     = "GCP/Storage"
  })
}
