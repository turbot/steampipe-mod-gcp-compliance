locals {
  soc_2_2017_cc_6_common_tags = merge(local.soc_2_2017_common_tags, {
    soc_2_2017_section_id = "cc6"
  })
}

benchmark "soc_2_2017_cc_6" {
  title       = "CC6 Logical and Physical Access"
  description = "The criteria relevant to how an entity (i) restricts logical and physical access, (ii) provides and removes that access, and (iii) prevents unauthorized access."

  children = [
    benchmark.soc_2_2017_cc_6_1
  ]

  tags = local.soc_2_2017_cc_6_common_tags
}

benchmark "soc_2_2017_cc_6_1" {
  title       = "CC6.1  The entity implements logical access security software, infrastructure, and architectures over protected information assets to protect them from security events to meet the entity's objectives"
  # documentation = file("./soc_2/docs/cc_6_1.md")

  children = [
    benchmark.soc_2_2017_cc_6_1_1
  ]

  tags = merge(local.soc_2_2017_cc_6_common_tags, {
    soc_2_2017_item_id = "6.1"
  })
}

benchmark "soc_2_2017_cc_6_1_1" {
  title       = "CC6.1.1"
  description = "Entity has documented policy and procedures to manage Access Control and an accompanying process to register and authorize users for issuing system credentials which grant the ability to access the critical systems."
  # documentation = file("./soc_2/docs/cc_6_1.md")

  children = [
    control.project_service_cloudasset_api_enabled
  ]

  tags = merge(local.soc_2_2017_cc_6_common_tags, {
    soc_2_2017_item_id = "6.1.1"
  })
}

benchmark "soc_2_2017_cc_6_1_3" {
  title       = "CC6.1.3"
   description = "Entity uses Sprinto, a continuous monitoring system, to alert the security team to update the access levels of team members whose roles have changed."
  # documentation = file("./soc_2/docs/cc_6_1.md")

  children = [
    control.sql_instance_not_publicly_accessible,
    control.kms_key_not_publicly_accessible,
    control.storage_bucket_not_publicly_accessible,
    control.require_bq_table_iam,
    control.compute_instance_with_no_public_ip_addresses,
    control.sql_world_readable,
    control.require_bucket_policy_only,
    control.iam_user_not_assigned_service_account_user_role_project_level,
    control.kms_key_separation_of_duties_enforced,
    control.iam_user_separation_of_duty_enforced,
    control.sql_instance_sql_contained_database_authentication_database_flag_off,
    control.sql_instance_sql_cross_db_ownership_chaining_database_flag_off,
    control.sql_instance_mysql_skip_show_database_flag_on,
    control.storage_bucket_log_retention_policy_lock_enabled,
    control.iam_service_account_without_admin_privilege,
    control.compute_instance_block_project_wide_ssh_enabled,
    control.kms_key_rotated_within_90_day,
    control.bigquery_table_encrypted_with_cmk,
    control.compute_instance_confidential_computing_enabled,
    control.dataproc_cluster_encryption_with_cmek,
    control.compute_disk_encrypted_with_csk,
    control.bigquery_dataset_encrypted_with_cmk
  ]

  tags = merge(local.soc_2_2017_cc_6_common_tags, {
    soc_2_2017_item_id = "6.1.3"
  })
}

benchmark "soc_2_2017_cc_6_1_4" {
  title       = "CC6.1.4"
  description = "Entity's Senior Management or the Information Security Officer periodically reviews and ensures that access to the critical systems is restricted to only those individuals who require such access to perform their job functions."
  # documentation = file("./soc_2/docs/cc_6_1.md")

  children = [
    control.iam_service_account_without_admin_privilege,
    control.compute_instance_oslogin_enabled,
  ]

  tags = merge(local.soc_2_2017_cc_6_common_tags, {
    soc_2_2017_item_id = "6.1.4"
  })
}

benchmark "soc_2_2017_cc_6_1_6" {
  title       = "CC6.1.6"
  description = "Entity ensures that the production databases access and Secure Shell access to infrastructure entities are protected from public internet access"
  # documentation = file("./soc_2/docs/cc_6_1.md")

  children = [
    control.compute_instance_oslogin_enabled,
  ]

  tags = merge(local.soc_2_2017_cc_6_common_tags, {
    soc_2_2017_item_id = "6.1.6"
  })
}

benchmark "soc_2_2017_cc_6_1_7" {
  title       = "CC6.1.7"
  description = "Entity ensures that logical access provisioning to critical systems requires approval from authorized personnel on an individual need or for a predefined role."
  # documentation = file("./soc_2/docs/cc_6_1.md")

  children = [
    control.sql_instance_not_publicly_accessible,
    control.kms_key_not_publicly_accessible,
    control.storage_bucket_not_publicly_accessible,
    control.bigquery_dataset_not_publicly_accessible,
    control.compute_instance_with_no_public_ip_addresses,
    control.sql_world_readable,
    control.require_bucket_policy_only,
    control.iam_user_not_assigned_service_account_user_role_project_level,
    control.kms_key_separation_of_duties_enforced,
    control.iam_user_separation_of_duty_enforced,
    control.sql_instance_sql_contained_database_authentication_database_flag_off,
    control.sql_instance_sql_cross_db_ownership_chaining_database_flag_off,
    control.sql_instance_mysql_skip_show_database_flag_on,
    control.storage_bucket_log_retention_policy_lock_enabled,
    control.iam_service_account_without_admin_privilege
  ]

  tags = merge(local.soc_2_2017_cc_6_common_tags, {
    soc_2_2017_item_id = "6.1.7"
  })
}

benchmark "soc_2_2017_cc_6_1_8" {
  title       = "CC6.1.8"
  description = ""
  # documentation = file("./soc_2/docs/cc_6_1.md")

  children = [
    control.iam_service_account_without_admin_privilege,
    control.compute_instance_block_project_wide_ssh_enabled,
    control.compute_instance_oslogin_enabled,
  ]

  tags = merge(local.soc_2_2017_cc_6_common_tags, {
    soc_2_2017_item_id = "6.1.8"
  })
}

benchmark "soc_2_2017_cc_6_1_9" {
  title       = "CC6.1.9"
  description = ""
  # documentation = file("./soc_2/docs/cc_6_1.md")

  children = [
    control.compute_instance_oslogin_enabled,
  ]

  tags = merge(local.soc_2_2017_cc_6_common_tags, {
    soc_2_2017_item_id = "6.1.9"
  })
}