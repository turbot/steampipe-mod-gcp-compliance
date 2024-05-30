benchmark "hipaa_164_312_a_2_iv" {
  title       = "164.312(a)(2)(iv) Encryption and decryption"
  description = "Implement a mechanism to encrypt and decrypt electronic protected health information."
  children = [
    control.bigquery_dataset_encrypted_with_cmk,
    control.bigquery_table_encrypted_with_cmk,
    control.compute_disk_encrypted_with_csk,
    control.dataproc_cluster_encryption_with_cmek,
    control.kms_key_rotated_within_90_day
  ]

  tags = merge(local.hipaa_164_312_common_tags, {
    hipaa_security_rule_2003_item_id = "164_312_a_2_iv"
  })
}
