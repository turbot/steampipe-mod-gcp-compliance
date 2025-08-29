locals {
  hipaa_common_tags = merge(local.gcp_compliance_common_tags, {
    hipaa = "true"
    type  = "Benchmark"
  })
}

benchmark "hipaa" {
  title         = "GCP HIPAA"
  description   = "The Health Insurance Portability and Accountability Act of 1996 (HIPAA) is a federal law that establishes data privacy and security requirements for organizations that are charged with safeguarding individuals' protected health information (PHI)."
  documentation = file("./hipaa/docs/hipaa_overview.md")
  children = [
    benchmark.hipaa_164_308,
    benchmark.hipaa_164_310,
    benchmark.hipaa_164_312,
  ]

  tags = local.hipaa_common_tags
}
