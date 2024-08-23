locals {
  soc_2_2017_cc_5_common_tags = merge(local.soc_2_2017_common_tags, {
    soc_2_2017_section_id = "cc5"
  })
}

benchmark "soc_2_2017_cc_5" {
  title       = "CC5 Control Activities"
  description = "The criteria check whether proper controls, processes, and technologies are in place to reduce risk."

  children = [
    benchmark.soc_2_2017_cc_5_2
  ]

  tags = local.soc_2_2017_cc_5_common_tags
}

benchmark "soc_2_2017_cc_5_2" {
  title       = "CC5.2 COSO Principle 11: The entity also selects and develops general control activities over technology to support the achievement of objectives"

  children = [
    benchmark.soc_2_2017_cc_5_2_1
  ]

  tags = merge(local.soc_2_2017_cc_5_common_tags, {
    soc_2_2017_item_id = "5.2"
  })
}

benchmark "soc_2_2017_cc_5_2_1" {
  title       = "CC5.2.1"
  description = "Entity uses Sprinto, a continuous monitoring system, to track and report the health of the information security program to the Information Security Officer and other stakeholders."

  children = [
    control.sql_instance_sql_external_scripts_enabled_database_flag_off
  ]

  tags = merge(local.soc_2_2017_cc_5_common_tags, {
    soc_2_2017_item_id = "5.2.1"
  })
}

benchmark "soc_2_2017_cc_5_2_2" {
  title       = "CC5.2.2"
  description = "Entity's Senior Management reviews and approves all company policies annually."

  children = [
    control.compute_network_contains_no_default_network,
    control.compute_network_contains_no_legacy_network,
    control.dns_managed_zone_dnssec_enabled,
    control.dnssec_prevent_rsasha1_ksk,
    control.sql_instance_sql_external_scripts_enabled_database_flag_off,
    control.sql_world_readable
  ]

  tags = merge(local.soc_2_2017_cc_5_common_tags, {
    soc_2_2017_item_id = "5.2.2"
  })
}


benchmark "soc_2_2017_cc_5_2_3" {
  title       = "CC5.2.3"
  description = "Entity's Senior Management reviews and approves the state of the Information Security program including policies, standards and procedures, at planned intervals or if significant changes occur to ensure their continuing suitability, adequacy and effectiveness."

  children = [
    control.alloydb_instance_log_error_verbosity_database_flag_default_or_stricter,
    control.alloydb_instance_log_min_error_statement_database_flag_configured,
    control.alloydb_instance_log_min_messages_database_flag_error,
    control.compute_instance_with_no_public_ip_addresses,
    control.iam_user_not_assigned_service_account_user_role_project_level,
    control.iam_user_separation_of_duty_enforced,
    control.kms_key_not_publicly_accessible,
    control.kms_key_separation_of_duties_enforced,
    control.require_bq_table_iam,
    control.require_bucket_policy_only,
    control.sql_instance_mysql_skip_show_database_flag_on,
    control.sql_instance_not_publicly_accessible,
    control.sql_instance_postgresql_log_connections_database_flag_on,
    control.sql_instance_postgresql_log_disconnections_database_flag_on,
    control.sql_instance_postgresql_log_error_verbosity_database_flag_default_or_stricter,
    control.sql_instance_postgresql_log_min_duration_statement_database_flag_disabled,
    control.sql_instance_postgresql_log_min_error_statement_database_flag_configured,
    control.sql_instance_postgresql_log_min_messages_database_flag_error,
    control.sql_instance_postgresql_log_statement_database_flag_ddl,
    control.sql_instance_sql_contained_database_authentication_database_flag_off,
    control.sql_instance_sql_cross_db_ownership_chaining_database_flag_off,
    control.sql_instance_sql_external_scripts_enabled_database_flag_off,
    control.sql_world_readable,
    control.storage_bucket_log_retention_policy_lock_enabled,
    control.storage_bucket_not_publicly_accessible
  ]

  tags = merge(local.soc_2_2017_cc_5_common_tags, {
    soc_2_2017_item_id = "5.2.3"
  })
}

benchmark "soc_2_2017_cc_5_2_4" {
  title       = "CC5.2.4"
  description = "Entity's Senior Management reviews and approves the Organizational Chart for all employees annually."

  children = [
    control.sql_instance_sql_external_scripts_enabled_database_flag_off
  ]

  tags = merge(local.soc_2_2017_cc_5_common_tags, {
    soc_2_2017_item_id = "5.2.4"
  })
}
