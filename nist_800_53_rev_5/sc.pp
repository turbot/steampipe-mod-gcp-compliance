benchmark "nist_800_53_rev_5_sc" {
  title       = "System and Communications Protection (SC)"
  description = "The SC control family is responsible for systems and communications protection procedures. This includes boundary protection, protection of information at rest, collaborative computing devices, cryptographic protection, denial of service protection, and many others."
  children = [
    benchmark.nist_800_53_rev_5_sc_7,
    benchmark.nist_800_53_rev_5_sc_8,
    benchmark.nist_800_53_rev_5_sc_28
  ]

  tags = local.nist_800_53_rev_5_common_tags
}

benchmark "nist_800_53_rev_5_sc_7" {
  title       = "Boundary Protection (SC-7)"
  description = "The information system: a. Monitors and controls communications at the external boundary of the system and at key internal boundaries within the system; b. Implements subnetworks for publicly accessible system components that are [Selection: physically; logically] separated from internal organizational networks; and c. Connects to external networks or information systems only through managed interfaces consisting of boundary protection devices arranged in accordance with an organizational security architecture."
  children = [
    control.compute_instance_ip_forwarding_disabled,
    control.restrict_firewall_rule_rdp_world_open,
    control.restrict_firewall_rule_ssh_world_open
  ]

  tags = local.nist_800_53_rev_5_common_tags
}

benchmark "nist_800_53_rev_5_sc_8" {
  title       = "Transmission Confidentiality And Integrity (SC-8)"
  description = "Protect the [Selection (one or more): confidentiality; integrity] of transmitted information."
  children = [
    control.compute_instance_block_project_wide_ssh_enabled
  ]

  tags = local.nist_800_53_rev_5_common_tags
}

benchmark "nist_800_53_rev_5_sc_28" {
  title       = "Protection Of Information At Rest (SC-28)"
  description = "Protect the [Selection (one or more): confidentiality; integrity] of the following information at rest: [Assignment: organization-defined information at rest]."
  children = [
    control.bigquery_dataset_encrypted_with_cmk,
    control.bigquery_table_encrypted_with_cmk,
    control.compute_disk_encrypted_with_csk,
    control.compute_instance_confidential_computing_enabled,
    control.dataproc_cluster_encryption_with_cmek,
    control.kms_key_rotated_within_90_day
  ]

  tags = local.nist_800_53_rev_5_common_tags
}