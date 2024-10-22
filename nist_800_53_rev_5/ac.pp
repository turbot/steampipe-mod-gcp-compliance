benchmark "nist_800_53_rev_5_ac" {
  title       = "Access Control (AC)"
  description = "The access control family consists of security requirements detailing system logging. This includes who has access to what assets and reporting capabilities like account management, system privileges, and remote access logging to determine when users have access to the system and their level of access."
  children = [
    benchmark.nist_800_53_rev_5_ac_2,
    benchmark.nist_800_53_rev_5_ac_3,
    benchmark.nist_800_53_rev_5_ac_5,
    benchmark.nist_800_53_rev_5_ac_6,
    benchmark.nist_800_53_rev_5_ac_17,
    benchmark.nist_800_53_rev_5_ac_18
  ]

  tags = local.nist_800_53_rev_5_common_tags
}

benchmark "nist_800_53_rev_5_ac_2" {
  title       = "Account Management (AC-2)"
  description = "Manage system accounts, group memberships, privileges, workflow, notifications, deactivations, and authorizations."
  children = [
    control.compute_instance_oslogin_enabled
  ]

  tags = local.nist_800_53_rev_5_common_tags
}

benchmark "nist_800_53_rev_5_ac_3" {
  title       = "Account Management (AC-3)"
  description = "Manage system accounts, group memberships, privileges, workflow, notifications, deactivations, and authorizations."
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

benchmark "nist_800_53_rev_5_ac_5" {
  title       = "Separation Of Duties (AC-5)"
  description = "Separate duties of individuals to prevent malevolent activity. automate separation of duties and access authorizations."
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

benchmark "nist_800_53_rev_5_ac_6" {
  title       = "Least Privilege (AC-6)"
  description = "Employ the principle of least privilege, allowing only authorized accesses for users (or processes acting on behalf of users) that are necessary to accomplish assigned organizational tasks."
  children = [
    control.compute_instance_with_no_public_ip_addresses,
    control.iam_service_account_without_admin_privilege,
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

benchmark "nist_800_53_rev_5_ac_17" {
  title       = "Remote Access (AC-17)"
  description = "Authorize remote access systems prior to connection. Enforce remote connection requirements to information systems."
  children = [
    control.compute_instance_block_project_wide_ssh_enabled
  ]

  tags = local.nist_800_53_rev_5_common_tags
}

benchmark "nist_800_53_rev_5_ac_18" {
  title       = "Wireless Access (AC-18)"
  description = "Establishes usage restrictions, configuration/connection requirements, and implementation guidance for wireless access and authorizes wireless access to the information system prior to allowing such connections."
  children = [
    control.compute_network_contains_no_default_network,
    control.compute_network_contains_no_legacy_network,
    control.dns_managed_zone_dnssec_enabled,
    control.dnssec_prevent_rsasha1_ksk
  ]

  tags = local.nist_800_53_rev_5_common_tags
}
