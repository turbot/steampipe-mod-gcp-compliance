locals {
  nist_csf_v10_common_tags = merge(local.gcp_compliance_common_tags, {
    nist_csf_v10 = "true"
    type         = "Benchmark"
  })
}

benchmark "nist_csf_v10" {
  title         = "GCP NIST Cybersecurity Framework (CSF) v1.0"
  description   = "NIST Cybersecurity Framework is a set of best practices, standards, and recommendations that help an organization improve its cybersecurity measures."
  documentation = file("./nist_csf_v10/docs/nist_csf_v10_overview.md")

  children = [
    benchmark.nist_csf_v10_de,
    benchmark.nist_csf_v10_id,
    benchmark.nist_csf_v10_pr,
    benchmark.nist_csf_v10_rs
  ]

  tags = local.nist_csf_v10_common_tags
}
