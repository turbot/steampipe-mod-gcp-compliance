locals {
  all_controls_dataproc_common_tags = merge(local.all_controls_common_tags, {
    service = "GCP/Dataproc"
  })
}

benchmark "all_controls_dataproc" {
  title       = "Dataproc"
  description = "This section contains recommendations for configuring Dataproc resources."
  children = [
    control.dataproc_cluster_encryption_with_cmek
  ]

  tags = merge(local.all_controls_dataproc_common_tags, {
    type = "Benchmark"
  })
}
