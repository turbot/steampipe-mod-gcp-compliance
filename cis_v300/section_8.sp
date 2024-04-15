locals {
  cis_v300_8_common_tags = merge(local.cis_v300_common_tags, {
    cis_section_id = "8"
  })
}

benchmark "cis_v300_8" {
  title         = "8 Dataproc"
  documentation = file("./cis_v300/docs/cis_v300_8.md")
  children = [
    control.cis_v300_8_1
  ]

  tags = merge(local.cis_v300_8_common_tags, {
    type    = "Benchmark"
    service = "GCP/Dataproc"
  })
}

control "cis_v300_8_1" {
  title         = "8.1 Ensure that Dataproc Cluster is encrypted using CustomerManaged Encryption Key"
  description   = "When you use Dataproc, cluster and job data is stored on Persistent Disks (PDs) associated with the Compute Engine VMs in your cluster and in a Cloud Storage staging bucket. This PD and bucket data is encrypted using a Google-generated data encryption key (DEK) and key encryption key (KEK). The CMEK feature allows you to create, use, and revoke the key encryption key (KEK). Google still controls the data encryption key (DEK)."
  query         = query.bigquery_dataset_not_publicly_accessible
  documentation = file("./cis_v300/docs/cis_v300_8_1.md")

  tags = merge(local.cis_v300_8_common_tags, {
    cis_item_id = "8.1"
    cis_type    = "automated"
    cis_level   = "2"
    service     = "GCP/Dataproc"
  })
}
