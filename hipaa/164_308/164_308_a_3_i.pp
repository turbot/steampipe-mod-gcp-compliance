benchmark "hipaa_164_308_a_3_i" {
  title       = "164.308(a)(3)(i) Workforce security"
  description = "Implement policies and procedures to ensure that all members of its workforce have appropriate access to electronic protected health information, as provided under paragraph (a)(4) of this section, and to prevent those workforce members who do not have access under paragraph (a)(4) of this section from obtaining access to electronic protected health information."
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

  tags = merge(local.hipaa_164_308_common_tags, {
    hipaa_security_rule_2003_item_id = "164_308_a_3_i"
  })
}
