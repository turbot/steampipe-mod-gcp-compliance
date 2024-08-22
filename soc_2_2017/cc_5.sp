locals {
  soc_2_2017_cc_5_common_tags = merge(local.soc_2_2017_common_tags, {
    soc_2_2017_section_id = "cc5"
  })
}

benchmark "soc_2_2017_cc_5" {
  title       = "CC5 Control Activities"
  description = ""

  children = [
    benchmark.soc_2_2017_cc_5_2
  ]

  tags = local.soc_2_2017_cc_5_common_tags
}

benchmark "soc_2_2017_cc_5_2" {
  title       = "CC5.2 COSO Principle 11: The entity also selects and develops general control activities over technology to support the achievement of objectives"
  # documentation = file("./soc_2/docs/cc_2_1.md")

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
  # documentation = file("./soc_2/docs/cc_2_1.md")

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
  # documentation = file("./soc_2/docs/cc_2_1.md")

  children = [
    control.sql_instance_sql_external_scripts_enabled_database_flag_off,
    control.dns_managed_zone_dnssec_enabled,
    control.compute_network_contains_no_default_network,
    control.compute_network_contains_no_legacy_network,
    control.dnssec_prevent_rsasha1_ksk,
    control.sql_world_readable
  ]

  tags = merge(local.soc_2_2017_cc_5_common_tags, {
    soc_2_2017_item_id = "5.2.2"
  })
}


benchmark "soc_2_2017_cc_5_2_3" {
  title       = "CC5.2.3"
  description = "Entity's Senior Management reviews and approves the state of the Information Security program including policies, standards and procedures, at planned intervals or if significant changes occur to ensure their continuing suitability, adequacy and effectiveness."
  # documentation = file("./soc_2/docs/cc_2_1.md")

  children = [
    control.sql_instance_sql_external_scripts_enabled_database_flag_off,
    control.sql_world_readable,
    control.kms_key_not_publicly_accessible,
    control.storage_bucket_not_publicly_accessible,
    control.require_bq_table_iam,
    control.compute_instance_with_no_public_ip_addresses,
    control.sql_instance_not_publicly_accessible,
    control.require_bucket_policy_only,
    control.iam_user_not_assigned_service_account_user_role_project_level,
    control.kms_key_separation_of_duties_enforced,
    control.iam_user_separation_of_duty_enforced,
    control.sql_instance_sql_contained_database_authentication_database_flag_off,
    control.sql_instance_sql_cross_db_ownership_chaining_database_flag_off,
    control.sql_instance_mysql_skip_show_database_flag_on,
    control.storage_bucket_log_retention_policy_lock_enabled,
    control.alloydb_instance_log_error_verbosity_database_flag_default_or_stricter,
    control.alloydb_instance_log_min_error_statement_database_flag_configured,
    control.sql_instance_postgresql_log_connections_database_flag_on,
    control.sql_instance_postgresql_log_disconnections_database_flag_on,
    control.sql_instance_postgresql_log_error_verbosity_database_flag_default_or_stricter,
    control.sql_instance_postgresql_log_min_duration_statement_database_flag_disabled,
    control.sql_instance_postgresql_log_min_error_statement_database_flag_configured,
    control.sql_instance_postgresql_log_min_messages_database_flag_error,
    control.alloydb_instance_log_min_messages_database_flag_error,
    control.sql_instance_postgresql_log_statement_database_flag_ddl,
  ]

  tags = merge(local.soc_2_2017_cc_5_common_tags, {
    soc_2_2017_item_id = "5.2.3"
  })
}

benchmark "soc_2_2017_cc_5_2_4" {
  title       = "CC5.2.4"
  description = "Entity's Senior Management reviews and approves the Organizational Chart for all employees annually."
  # documentation = file("./soc_2/docs/cc_2_1.md")

  children = [
    control.sql_instance_sql_external_scripts_enabled_database_flag_off
  ]

  tags = merge(local.soc_2_2017_cc_5_common_tags, {
    soc_2_2017_item_id = "5.2.4"
  })
}
