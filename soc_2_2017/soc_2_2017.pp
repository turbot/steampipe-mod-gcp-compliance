locals {
  soc_2_2017_common_tags = merge(local.gcp_compliance_common_tags, {
    soc_2_2017  = "true"
    type      = "Benchmark"
  })
}

benchmark "soc_2_2017" {
  title         = "GCP SOC2 2017"
  description   = "The Service and Organization Controls (SOC) 2 is a report based on the Auditing Standards Board of the American Institute of Certified Public Accountants (AICPA) SSAE 18, which evaluates the service organization’s controls relevant to the Trust Services Criteria of security, availability, processing integrity, confidentiality, or privacy."
  documentation = file("./soc_2_2017/docs/soc_2_2017_overview.md")

  children = [
    benchmark.soc_2_2017_cc_2,
    benchmark.soc_2_2017_cc_3,
    benchmark.soc_2_2017_cc_4,
    benchmark.soc_2_2017_cc_5,
    benchmark.soc_2_2017_cc_6,
    benchmark.soc_2_2017_cc_7,
    benchmark.soc_2_2017_cc_8

  ]
  tags = local.soc_2_2017_common_tags
}
