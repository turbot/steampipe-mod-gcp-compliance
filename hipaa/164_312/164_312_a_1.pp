benchmark "hipaa_164_312_a_1" {
  title       = "164.312(a)(1) Access control."
  description = "Implement technical policies and procedures for electronic information systems that maintain electronic protected health information to allow access only to those persons or software programs that have been granted access rights as specified in § 164.308(a)(4)."
  children = [
    control.compute_instance_with_no_public_ip_addresses,
    control.iam_user_not_assigned_service_account_user_role_project_level,
    control.kms_key_not_publicly_accessible,
    control.kms_key_separation_of_duties_enforced,
    control.prevent_public_ip_cloudsql,
    control.require_bq_table_iam,
    control.require_bucket_policy_only,
    control.sql_instance_mysql_skip_show_database_flag_on,
    control.sql_instance_not_publicly_accessible,
    control.sql_instance_sql_contained_database_authentication_database_flag_off,
    control.sql_instance_sql_cross_db_ownership_chaining_database_flag_off,
    control.storage_bucket_log_retention_policy_lock_enabled
  ]

  tags = merge(local.hipaa_164_312_common_tags, {
    hipaa_security_rule_2003_item_id = "164_312_a_1"
  })
}
