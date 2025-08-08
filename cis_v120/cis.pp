locals {
  cis_v120_common_tags = merge(local.gcp_compliance_common_tags, {
    benchmark   = "cis"
    cis_version = "v1.2.0"
  })
}

benchmark "cis_v120" {
  title         = "GCP CIS v1.2.0"
  description   = "The CIS Google Cloud Platform Foundations Security Benchmark covers foundational elements of Google Cloud Platform."
  documentation = file("./cis_v120/docs/cis_overview.md")
  children = [
    benchmark.cis_v120_1,
    benchmark.cis_v120_2,
    benchmark.cis_v120_3,
    benchmark.cis_v120_4,
    benchmark.cis_v120_5,
    benchmark.cis_v120_6,
    benchmark.cis_v120_7
  ]

  tags = merge(local.cis_v120_common_tags, {
    type = "Benchmark"
  })
}
