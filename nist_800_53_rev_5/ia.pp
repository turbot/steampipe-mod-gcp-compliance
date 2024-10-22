benchmark "nist_800_53_rev_5_ia" {
  title       = "Identification and Authentication (IA)"
  description = "IA controls are specific to the identification and authentication policies in an organization. This includes the identification and authentication of organizational and non-organizational users and how the management of those systems."
  children = [
    benchmark.nist_800_53_rev_5_ia_5
  ]

  tags = local.nist_800_53_rev_5_common_tags
}

benchmark "nist_800_53_rev_5_ia_5" {
  title       = "Authenticator Management (IA-5)"
  description = "Authenticate users and devices. Automate administrative control. Enforce restrictions. Protect against unauthorized use."
  children = [
    control.bigquery_dataset_encrypted_with_cmk,
    control.bigquery_table_encrypted_with_cmk,
    control.compute_disk_encrypted_with_csk,
    control.compute_instance_block_project_wide_ssh_enabled,
    control.compute_instance_confidential_computing_enabled,
    control.compute_instance_with_no_default_service_account,
    control.compute_instance_with_no_default_service_account_with_full_access,
    control.dataproc_cluster_encryption_with_cmek,
    control.kms_key_rotated_within_90_day
  ]

  tags = local.nist_800_53_rev_5_common_tags
}