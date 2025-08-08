locals {
  cis_v400_common_tags = merge(local.gcp_compliance_common_tags, {
    benchmark   = "cis"
    cis_version = "v4.0.0"
  })
}

benchmark "cis_v400" {
  title         = "GCP CIS v4.0.0"
  description   = "The CIS Google Cloud Platform Foundations Security Benchmark covers foundational elements of Google Cloud Platform."
  documentation = file("./cis_v400/docs/cis_overview.md")
  children = [
    benchmark.cis_v400_1,
    benchmark.cis_v400_2,
    benchmark.cis_v400_3,
    benchmark.cis_v400_4,
    benchmark.cis_v400_5,
    benchmark.cis_v400_6,
    benchmark.cis_v400_7,
    benchmark.cis_v400_8
  ]

  tags = merge(local.cis_v400_common_tags, {
    type = "Benchmark"
  })
}
