locals {
  cis_v130_common_tags = merge(local.gcp_compliance_common_tags, {
    benchmark   = "cis"
    cis_version = "v1.3.0"
  })
}

benchmark "cis_v130" {
  title         = "CIS v1.3.0"
  description   = "The CIS Google Cloud Platform Foundations Security Benchmark covers foundational elements of Google Cloud Platform."
  documentation = file("./cis_v130/docs/cis_overview.md")
  children = [
    benchmark.cis_v130_1,
    benchmark.cis_v130_2,
    benchmark.cis_v130_3,
    benchmark.cis_v130_4,
    benchmark.cis_v130_5,
    benchmark.cis_v130_6,
    benchmark.cis_v130_7
  ]

  tags = merge(local.cis_v130_common_tags, {
    type = "Benchmark"
  })
}
