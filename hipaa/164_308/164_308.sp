locals {
  hipaa_164_308_common_tags = merge(local.hipaa_common_tags, {
    hipaa_section = "164_308"
  })
}

benchmark "hipaa_164_308" {
  title       = "164.308 Administrative Safeguards"
  description = "An important step in protecting electronic protected health information (EPHI) is to implement reasonable and appropriate administrative safeguards that establish the foundation for a covered entity's security program. The Administrative Safeguards standards in the Security Rule, at § 164.308, were developed to accomplish this purpose."
  children = [
    benchmark.hipaa_164_308_a_1_ii,
    benchmark.hipaa_164_308_a_3_i,
    benchmark.hipaa_164_308_a_3_ii,
    benchmark.hipaa_164_308_a_7_ii
  ]

  tags = local.hipaa_164_308_common_tags

}

