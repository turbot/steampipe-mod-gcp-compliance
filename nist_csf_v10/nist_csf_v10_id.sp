benchmark "nist_csf_v10_id" {
  title       = "Identify (ID)"
  description = "Develop an organizational understanding to manage cybersecurity risk to systems, people, assets, data, and capabilities. Functions include Asset Management, Governance, Business Environment, Risk Assessment, and Risk Management Strategy"
  children = [
    benchmark.nist_csf_v10_id_am
  ]

  tags = local.nist_csf_v10_common_tags
}

benchmark "nist_csf_v10_id_am" {
  title       = "Asset Management (ID.AM)"
  description = "The data, personnel, devices, systems, and facilities that enable the organization to achieve business purposes are identified and managed consistent with their relative importance to organizational objectives and the organization’s risk strategy."
  children = [
    benchmark.nist_csf_v10_id_am_1
  ]

  tags = local.nist_csf_v10_common_tags
}

benchmark "nist_csf_v10_id_am_1" {
  title       = "ID.AM-1"
  description = "Physical devices and systems within the organization are inventoried."
  children = [
    control.project_service_cloudasset_api_enabled,
  ]

  tags = local.nist_csf_v10_common_tags
}