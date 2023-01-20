locals {
  cis_v200_common_tags = merge(local.gcp_compliance_common_tags, {
    benchmark   = "cis"
    cis_version = "v2.0.0"
  })
}

benchmark "cis_v200" {
  title         = "CIS v2.0.0"
  description   = "The CIS Google Cloud Platform Foundations Security Benchmark covers foundational elements of Google Cloud Platform."
  documentation = file("./cis_v200/docs/cis_overview.md")
  children = [
    benchmark.cis_v200_1,
    benchmark.cis_v200_2,
    benchmark.cis_v200_3,
    benchmark.cis_v200_4,
    benchmark.cis_v200_5,
    benchmark.cis_v200_6,
    benchmark.cis_v200_7
  ]

  tags = merge(local.cis_v200_common_tags, {
    type = "Benchmark"
  })
}
