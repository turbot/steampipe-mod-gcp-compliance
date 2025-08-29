locals {
  nist_csf_v2_common_tags = merge(local.gcp_compliance_common_tags, {
    nist_csf_v2 = "true"
    type        = "Benchmark"
  })
}

benchmark "nist_csf_v2" {
  title       = "GCP NIST Cybersecurity Framework (CSF) v2.0"
  description = "The NIST Cybersecurity Framework (CSF) 2.0 provides guidance to industry, government agencies, and other organizations to manage cybersecurity risks. It offers a taxonomy of high-level cybersecurity outcomes that can be used by any organization — regardless of its size, sector, or maturity — to better understand, assess, prioritize, and communicate its cybersecurity efforts. The CSF does not prescribe how outcomes should be achieved. Rather, it links to online resources that provide additional guidance on practices and controls that could be used to achieve those outcomes."
  documentation = file("./nist_csf_v2/docs/nist_csf_v2_overview.md")
  children = [
    benchmark.nist_csf_v2_de,
    benchmark.nist_csf_v2_gv,
    benchmark.nist_csf_v2_id,
    benchmark.nist_csf_v2_pr,
    benchmark.nist_csf_v2_rc,
    benchmark.nist_csf_v2_rs
  ]

  tags = local.nist_csf_v2_common_tags
}