locals {
  soc_2_2017_cc_6_common_tags = merge(local.soc_2_2017_common_tags, {
    soc_2_2017_section_id = "cc6"
  })
}

benchmark "soc_2_2017_cc_6" {
  title       = "CC6 Logical and Physical Access"
  description = "The criteria relevant to how an entity (i) restricts logical and physical access, (ii) provides and removes that access, and (iii) prevents unauthorized access."

  children = [
    benchmark.soc_2_2017_cc_6_1,
    benchmark.soc_2_2017_cc_6_3,
    benchmark.soc_2_2017_cc_6_6
  ]

  tags = local.soc_2_2017_cc_6_common_tags
}

benchmark "soc_2_2017_cc_6_1" {
  title       = "CC6.1  The entity implements logical access security software, infrastructure, and architectures over protected information assets to protect them from security events to meet the entity's objectives"

  children = [
    benchmark.soc_2_2017_cc_6_1_1,
    benchmark.soc_2_2017_cc_6_1_3,
    benchmark.soc_2_2017_cc_6_1_4,
    benchmark.soc_2_2017_cc_6_1_6,
    benchmark.soc_2_2017_cc_6_1_7,
    benchmark.soc_2_2017_cc_6_1_8,
    benchmark.soc_2_2017_cc_6_1_9,
    benchmark.soc_2_2017_cc_6_1_10,
    benchmark.soc_2_2017_cc_6_1_11

  ]

  tags = merge(local.soc_2_2017_cc_6_common_tags, {
    soc_2_2017_item_id = "6.1"
  })
}

benchmark "soc_2_2017_cc_6_1_1" {
  title       = "CC6.1.1"
  description = "Entity has documented policy and procedures to manage Access Control and an accompanying process to register and authorize users for issuing system credentials which grant the ability to access the critical systems."

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

  children = [
    control.alloydb_cluster_encrypted_with_cmk,
    control.bigquery_dataset_encrypted_with_cmk,
    control.bigquery_table_encrypted_with_cmk,
    control.compute_disk_encrypted_with_csk,
    control.compute_instance_block_project_wide_ssh_enabled,
    control.compute_instance_confidential_computing_enabled,
    control.compute_instance_with_no_public_ip_addresses,
    control.dataproc_cluster_encryption_with_cmek,
    control.iam_service_account_without_admin_privilege,
    control.iam_user_not_assigned_service_account_user_role_project_level,
    control.iam_user_separation_of_duty_enforced,
    control.kms_key_not_publicly_accessible,
    control.kms_key_rotated_within_90_day,
    control.kms_key_separation_of_duties_enforced,
    control.require_bq_table_iam,
    control.require_bucket_policy_only,
    control.sql_instance_mysql_skip_show_database_flag_on,
    control.sql_instance_not_publicly_accessible,
    control.sql_instance_sql_contained_database_authentication_database_flag_off,
    control.sql_instance_sql_cross_db_ownership_chaining_database_flag_off,
    control.sql_world_readable,
    control.storage_bucket_log_retention_policy_lock_enabled,
    control.storage_bucket_not_publicly_accessible
  ]

  tags = merge(local.soc_2_2017_cc_6_common_tags, {
    soc_2_2017_item_id = "6.1.3"
  })
}

benchmark "soc_2_2017_cc_6_1_4" {
  title       = "CC6.1.4"
  description = "Entity's Senior Management or the Information Security Officer periodically reviews and ensures that access to the critical systems is restricted to only those individuals who require such access to perform their job functions."

  children = [
    control.compute_instance_oslogin_enabled,
    control.iam_service_account_without_admin_privilege,
    control.project_oslogin_enabled
  ]

  tags = merge(local.soc_2_2017_cc_6_common_tags, {
    soc_2_2017_item_id = "6.1.4"
  })
}

benchmark "soc_2_2017_cc_6_1_6" {
  title       = "CC6.1.6"
  description = "Entity ensures that the production databases access and Secure Shell access to infrastructure entities are protected from public internet access"

  children = [
    control.compute_instance_oslogin_enabled,
    control.project_oslogin_enabled
  ]

  tags = merge(local.soc_2_2017_cc_6_common_tags, {
    soc_2_2017_item_id = "6.1.6"
  })
}

benchmark "soc_2_2017_cc_6_1_7" {
  title       = "CC6.1.7"
  description = "Entity ensures that logical access provisioning to critical systems requires approval from authorized personnel on an individual need or for a predefined role."

  children = [
    control.compute_instance_with_no_public_ip_addresses,
    control.iam_service_account_without_admin_privilege,
    control.iam_user_not_assigned_service_account_user_role_project_level,
    control.iam_user_separation_of_duty_enforced,
    control.kms_key_not_publicly_accessible,
    control.kms_key_separation_of_duties_enforced,
    control.require_bq_table_iam,
    control.require_bucket_policy_only,
    control.sql_instance_mysql_skip_show_database_flag_on,
    control.sql_instance_not_publicly_accessible,
    control.sql_instance_sql_contained_database_authentication_database_flag_off,
    control.sql_instance_sql_cross_db_ownership_chaining_database_flag_off,
    control.sql_world_readable,
    control.storage_bucket_log_retention_policy_lock_enabled,
    control.storage_bucket_not_publicly_accessible
  ]

  tags = merge(local.soc_2_2017_cc_6_common_tags, {
    soc_2_2017_item_id = "6.1.7"
  })
}

benchmark "soc_2_2017_cc_6_1_8" {
  title       = "CC6.1.8"

  children = [
    control.compute_instance_block_project_wide_ssh_enabled,
    control.compute_instance_oslogin_enabled,
    control.iam_service_account_without_admin_privilege,
    control.project_oslogin_enabled
  ]

  tags = merge(local.soc_2_2017_cc_6_common_tags, {
    soc_2_2017_item_id = "6.1.8"
  })
}

benchmark "soc_2_2017_cc_6_1_9" {
  title       = "CC6.1.9"

  children = [
    control.compute_instance_oslogin_enabled,
    control.project_oslogin_enabled
  ]

  tags = merge(local.soc_2_2017_cc_6_common_tags, {
    soc_2_2017_item_id = "6.1.9"
  })
}

benchmark "soc_2_2017_cc_6_1_10" {
  title       = "CC6.1.10"

  children = [
    control.alloydb_cluster_encrypted_with_cmk,
    control.bigquery_dataset_encrypted_with_cmk,
    control.bigquery_table_encrypted_with_cmk,
    control.compute_disk_encrypted_with_csk,
    control.compute_instance_confidential_computing_enabled,
    control.dataproc_cluster_encryption_with_cmek,
    control.kms_key_rotated_within_90_day,
  ]

  tags = merge(local.soc_2_2017_cc_6_common_tags, {
    soc_2_2017_item_id = "6.1.10"
  })
}

benchmark "soc_2_2017_cc_6_1_11" {
  title       = "CC6.1.11"

  children = [
    control.compute_instance_block_project_wide_ssh_enabled
  ]

  tags = merge(local.soc_2_2017_cc_6_common_tags, {
    soc_2_2017_item_id = "6.1.11"
  })
}

benchmark "soc_2_2017_cc_6_3" {
  title       = "CC6.3 The entity authorizes, modifies, or removes access to data, software, functions, and other protected information assets based on roles, responsibilities, or the system design and changes, giving consideration to the concepts of least privilege and segregation of duties, to meet the entity’s objectives"

  children = [
    benchmark.soc_2_2017_cc_6_3_1,
    benchmark.soc_2_2017_cc_6_3_2,
    benchmark.soc_2_2017_cc_6_3_3
  ]

  tags = merge(local.soc_2_2017_cc_6_common_tags, {
    soc_2_2017_item_id = "6.3"
  })
}

benchmark "soc_2_2017_cc_6_3_1" {
  title       = "CC6.3.1"

  children = [
    control.iam_service_account_without_admin_privilege,
    control.compute_instance_with_no_default_service_account,
    control.compute_instance_with_no_default_service_account_with_full_access,
  ]

  tags = merge(local.soc_2_2017_cc_6_common_tags, {
    soc_2_2017_item_id = "6.3.1"
  })
}

benchmark "soc_2_2017_cc_6_3_2" {
  title       = "CC6.3.2"

  children = [
    control.iam_service_account_without_admin_privilege,
    control.compute_instance_with_no_default_service_account,
    control.compute_instance_with_no_default_service_account_with_full_access,
  ]

  tags = merge(local.soc_2_2017_cc_6_common_tags, {
    soc_2_2017_item_id = "6.3.2"
  })
}

benchmark "soc_2_2017_cc_6_3_3" {
  title       = "CC6.3.3"

  children = [
    control.compute_instance_with_no_default_service_account_with_full_access,
    control.compute_instance_with_no_default_service_account,
    control.iam_service_account_without_admin_privilege
  ]

  tags = merge(local.soc_2_2017_cc_6_common_tags, {
    soc_2_2017_item_id = "6.3.3"
  })
}

benchmark "soc_2_2017_cc_6_6" {
  title       = "CC6.6 The entity implements logical access security measures to protect against threats from sources outside its system boundaries."

  children = [
    benchmark.soc_2_2017_cc_6_6_1,
    benchmark.soc_2_2017_cc_6_6_3,
    benchmark.soc_2_2017_cc_6_6_4
  ]

  tags = merge(local.soc_2_2017_cc_6_common_tags, {
    soc_2_2017_item_id = "6.6"
  })
}

benchmark "soc_2_2017_cc_6_6_1" {
  title       = "CC6.6.1"

  children = [
    control.compute_instance_ip_forwarding_disabled,
    control.compute_instance_serial_port_connection_disabled,
    control.restrict_firewall_rule_rdp_world_open,
    control.restrict_firewall_rule_ssh_world_open,
    control.sql_instance_sql_remote_access_database_flag_off
  ]

  tags = merge(local.soc_2_2017_cc_6_common_tags, {
    soc_2_2017_item_id = "6.6.1"
  })
}

benchmark "soc_2_2017_cc_6_6_3" {
  title       = "CC6.6.3"

  children = [
    control.compute_instance_serial_port_connection_disabled,
    control.sql_instance_sql_remote_access_database_flag_off
  ]

  tags = merge(local.soc_2_2017_cc_6_common_tags, {
    soc_2_2017_item_id = "6.6.3"
  })
}

benchmark "soc_2_2017_cc_6_6_4" {
  title       = "CC6.6.4"

  children = [
    control.compute_instance_ip_forwarding_disabled,
    control.compute_instance_serial_port_connection_disabled,
    control.restrict_firewall_rule_rdp_world_open,
    control.restrict_firewall_rule_ssh_world_open,
    control.sql_instance_sql_remote_access_database_flag_off,
  ]

  tags = merge(local.soc_2_2017_cc_6_common_tags, {
    soc_2_2017_item_id = "6.6.4"
  })
}

benchmark "soc_2_2017_cc_6_7" {
  title       = "CC6.7 The entity restricts the transmission, movement, and removal of information to authorized internal and external users and processes, and protects it during transmission, movement, or removal to meet the entity’s objectives"

  children = [
    benchmark.soc_2_2017_cc_6_7_2
  ]

  tags = merge(local.soc_2_2017_cc_6_common_tags, {
    soc_2_2017_item_id = "6.7"
  })
}

benchmark "soc_2_2017_cc_6_7_2" {
  title       = "CC6.7.2"

  children = [
    control.compute_instance_block_project_wide_ssh_enabled
  ]

  tags = merge(local.soc_2_2017_cc_6_common_tags, {
    soc_2_2017_item_id = "6.7.2"
  })
}
