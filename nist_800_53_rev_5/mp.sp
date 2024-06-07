benchmark "nist_800_53_rev_5_mp" {
  title       = "Media Protection (MP)"
  description = "The Media Protection control family includes controls specific to access, marking, storage, transport policies, sanitization, and defined organizational media use."
  children = [
    benchmark.nist_800_53_rev_5_mp_2
  ]

  tags = local.nist_800_53_rev_5_common_tags
}

benchmark "nist_800_53_rev_5_mp_2" {
  title       = "Media Access (MP-2)"
  description = "Restrict access to [Assignment: organization-defined types of digital and/or non-digital media] to [Assignment: organization-defined personnel or roles]."
  children = [
    control.compute_instance_with_no_public_ip_addresses,
    control.iam_user_not_assigned_service_account_user_role_project_level,
    control.iam_user_separation_of_duty_enforced,
    control.kms_key_not_publicly_accessible,
    control.kms_key_separation_of_duties_enforced,
    control.prevent_public_ip_cloudsql,
    control.require_bq_table_iam,
    control.require_bucket_policy_only,
    control.sql_instance_mysql_skip_show_database_flag_on,
    control.sql_instance_sql_contained_database_authentication_database_flag_off,
    control.sql_instance_sql_cross_db_ownership_chaining_database_flag_off,
    control.sql_world_readable,
    control.storage_bucket_log_retention_policy_lock_enabled,
    control.storage_bucket_not_publicly_accessible
  ]

  tags = local.nist_800_53_rev_5_common_tags
}