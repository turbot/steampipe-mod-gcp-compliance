locals {
  cis_v300_common_tags = merge(local.gcp_compliance_common_tags, {
    benchmark   = "cis"
    cis_version = "v3.0.0"
  })
}

benchmark "cis_v300" {
  title         = "GCP CIS v3.0.0"
  description   = "The CIS Google Cloud Platform Foundations Security Benchmark covers foundational elements of Google Cloud Platform."
  documentation = file("./cis_v300/docs/cis_overview.md")
  children = [
    benchmark.cis_v300_1,
    benchmark.cis_v300_2,
    benchmark.cis_v300_3,
    benchmark.cis_v300_4,
    benchmark.cis_v300_5,
    benchmark.cis_v300_6,
    benchmark.cis_v300_7,
    benchmark.cis_v300_8
  ]

  tags = merge(local.cis_v300_common_tags, {
    type = "Benchmark"
  })
}
