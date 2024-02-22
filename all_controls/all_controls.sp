locals {
  all_controls_common_tags = merge(local.gcp_compliance_common_tags, {
    type = "Benchmark"
  })
}

benchmark "all_controls" {
  title       = "All Controls"
  description = "This benchmark contains all controls grouped by service to help you detect resource configurations that do not meet best practices."
  children = [
    benchmark.all_controls_appengine,
    benchmark.all_controls_bigquery,
    benchmark.all_controls_cloudrun,
    benchmark.all_controls_compute,
    benchmark.all_controls_dataproc,
    benchmark.all_controls_dns,
    benchmark.all_controls_iam,
    benchmark.all_controls_kms,
    benchmark.all_controls_kubernetes,
    benchmark.all_controls_logging,
    benchmark.all_controls_organization,
    benchmark.all_controls_project,
    benchmark.all_controls_resourcemanager,
    benchmark.all_controls_sql,
    benchmark.all_controls_storage
  ]

  tags = local.all_controls_common_tags
}
