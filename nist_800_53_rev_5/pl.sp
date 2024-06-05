benchmark "nist_800_53_rev_5_pl" {
  title       = "Planning (PL)"
  description = "The PL family outlines your organization’s security planning policies. It covers the purpose, scope, roles, responsibilities, management commitment, coordination, and organizational compliance necessary for effective security planning."
  children = [
    benchmark.nist_800_53_rev_5_pl_8
  ]

  tags = merge(local.nist_800_53_rev_5_common_tags, {
    service = "AWS/GuardDuty"
  })
}

benchmark "nist_800_53_rev_5_pl_8" {
  title       = "Information Security Architecture (PL-8)"
  description = "Develops an information security architecture for the information system that: describes the overall philosophy, requirements, and approach to be taken with regard to protecting the confidentiality, integrity, and availability of organizational information; describes how the information security architecture is integrated into and supports the enterprise architecture; and Describes any information security assumptions about, and dependencies on, external services. Reviews and updates the information security architecture Assignment: organization-defined frequency to reflect updates in the enterprise architecture; and ensures that planned information security architecture changes are reflected in the security plan, the security Concept of Operations (CONOPS), and organizational procurements/acquisitions"
  children = [
    control.iam_api_key_age_90,
    control.iam_api_key_restricts_apis,
    control.project_no_api_key
  ]

  tags = merge(local.nist_800_53_rev_5_common_tags, {
    service = "AWS/GuardDuty"
  })
}