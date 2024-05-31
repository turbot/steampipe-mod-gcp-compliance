benchmark "hipaa_164_308_a_3_ii" {
  title       = "164.308(a)(3)(ii) Implementation specifications"
  description = "Implement procedures for the authorization and/or supervision of workforce members who work with electronic protected health information or in locations where it might be accessed. Implement procedures to determine that a workforce member's access to electronic protected health information is appropriate. Implement procedures for terminating access to electronic protected health information when the employment of, or other arrangement with, a workforce member ends or as required by determinations made as specified in paragraph (a)(3)(ii)(B) of this section."
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
    hipaa_security_rule_2003_item_id = "164_308_a_3_ii"
  })
}
