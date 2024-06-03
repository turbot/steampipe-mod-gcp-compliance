benchmark "nist_csf_v10_rs" {
  title       = "Respond (RS)"
  description = "Develop and implement appropriate activities to take action regarding a detected cybersecurity incident. Functions include Response Planning, Communications, Analysis, Mitigation, and Improvements."

  children = [
    benchmark.nist_csf_v10_rs_an,
    benchmark.nist_csf_v10_rs_co,
  ]

  tags = local.nist_csf_v10_common_tags
}

benchmark "nist_csf_v10_rs_an" {
  title       = "Analysis (RS.AN)"
  description = "Analysis is conducted to ensure effective response and support recovery activities."
  children = [
    benchmark.nist_csf_v10_rs_an_1
  ]

  tags = local.nist_csf_v10_common_tags
}

benchmark "nist_csf_v10_rs_an_1" {
  title       = "RS.AN-1"
  description = "Notifications from detection systems are investigated."
  children = [
    control.compute_network_dns_logging_enabled,
    control.audit_logging_configured_for_all_service,
  ]

  tags = local.nist_csf_v10_common_tags
}

benchmark "nist_csf_v10_rs_co" {
  title       = "Communications (RS.CO)"
  description = "Response activities are coordinated with internal and external stakeholders (e.g. external support from law enforcement agencies)."
  children = [
    benchmark.nist_csf_v10_rs_co_1
  ]

  tags = local.nist_csf_v10_common_tags
}

benchmark "nist_csf_v10_rs_co_1" {
  title       = "RS.CO-1"
  description = "Personnel know their roles and order of operations when a response is needed."
  children = [
    control.organization_essential_contacts_configured
  ]

  tags = local.nist_csf_v10_common_tags
}
