locals {
  soc_2_2017_cc_7_common_tags = merge(local.soc_2_2017_common_tags, {
    soc_2_2017_section_id = "cc7"
  })
}

benchmark "soc_2_2017_cc_7" {
  title       = "CC7 System Operations"
  description = "The criteria relevant to how an entity (i) manages the operation of system(s) and (ii) detects and mitigates processing deviations including logical and physical security deviations."

  children = [
    benchmark.soc_2_2017_cc_7_1,
    benchmark.soc_2_2017_cc_7_2,
    benchmark.soc_2_2017_cc_7_3
  ]

  tags = local.soc_2_2017_cc_7_common_tags
}

benchmark "soc_2_2017_cc_7_1" {
  title       = "CC7.1 To meet its objectives, the entity uses detection and monitoring procedures to identify (1) changes to configurations that result in the introduction of new vulnerabilities, and (2) susceptibilities to newly discovered vulnerabilities."

  children = [
    benchmark.soc_2_2017_cc_7_1_2,
    benchmark.soc_2_2017_cc_7_1_3,
    benchmark.soc_2_2017_cc_7_1_4
  ]

  tags = merge(local.soc_2_2017_cc_7_common_tags, {
    soc_2_2017_item_id = "7.1"
  })
}

benchmark "soc_2_2017_cc_7_1_2" {
  title       = "CC7.1.2"

  children = [
    control.sql_instance_sql_3625_trace_database_flag_off,
    control.sql_instance_sql_user_connections_database_flag_configured,
    control.sql_instance_sql_user_options_database_flag_not_configured
  ]

  tags = merge(local.soc_2_2017_cc_7_common_tags, {
    soc_2_2017_item_id = "7.1.2"
  })
}

benchmark "soc_2_2017_cc_7_1_3" {
  title       = "CC7.1.3"

  children = [
    control.sql_instance_sql_3625_trace_database_flag_off,
    control.sql_instance_sql_user_connections_database_flag_configured,
    control.sql_instance_sql_user_options_database_flag_not_configured
  ]

  tags = merge(local.soc_2_2017_cc_7_common_tags, {
    soc_2_2017_item_id = "7.1.3"
  })
}

benchmark "soc_2_2017_cc_7_1_4" {
  title       = "CC7.1.4"

  children = [
    control.sql_instance_sql_3625_trace_database_flag_off,
    control.sql_instance_sql_user_connections_database_flag_configured,
    control.sql_instance_sql_user_options_database_flag_not_configured
  ]

  tags = merge(local.soc_2_2017_cc_7_common_tags, {
    soc_2_2017_item_id = "7.1.4"
  })
}

benchmark "soc_2_2017_cc_7_2" {
  title       = "CC7.2 The entity monitors system components and the operation of those components for anomalies that are indicative of malicious acts, natural disasters, and errors affecting the entity's ability to meet its objectives; anomalies are analyzed to determine whether they represent security events."

  children = [
    benchmark.soc_2_2017_cc_7_2_1,
    benchmark.soc_2_2017_cc_7_2_2,
    benchmark.soc_2_2017_cc_7_2_3,
    benchmark.soc_2_2017_cc_7_2_4
  ]

  tags = merge(local.soc_2_2017_cc_7_common_tags, {
    soc_2_2017_item_id = "7.2"
  })
}

benchmark "soc_2_2017_cc_7_2_1" {
  title       = "CC7.2.1"

  children = [
    control.alloydb_instance_log_error_verbosity_database_flag_default_or_stricter,
    control.alloydb_instance_log_min_error_statement_database_flag_configured,
    control.alloydb_instance_log_min_messages_database_flag_error,
    control.enable_network_flow_logs,
    control.sql_instance_postgresql_log_connections_database_flag_on,
    control.sql_instance_postgresql_log_disconnections_database_flag_on,
    control.sql_instance_postgresql_log_error_verbosity_database_flag_default_or_stricter,
    control.sql_instance_postgresql_log_min_duration_statement_database_flag_disabled,
    control.sql_instance_postgresql_log_min_error_statement_database_flag_configured,
    control.sql_instance_postgresql_log_min_messages_database_flag_error,
    control.sql_instance_postgresql_log_statement_database_flag_ddl
  ]

  tags = merge(local.soc_2_2017_cc_7_common_tags, {
    soc_2_2017_item_id = "7.2.1"
  })
}

benchmark "soc_2_2017_cc_7_2_2" {
  title       = "CC7.2.2"

  children = [
    control.alloydb_instance_log_error_verbosity_database_flag_default_or_stricter,
    control.alloydb_instance_log_min_error_statement_database_flag_configured,
    control.alloydb_instance_log_min_messages_database_flag_error,
    control.enable_network_flow_logs,
    control.sql_instance_postgresql_log_connections_database_flag_on,
    control.sql_instance_postgresql_log_disconnections_database_flag_on,
    control.sql_instance_postgresql_log_error_verbosity_database_flag_default_or_stricter,
    control.sql_instance_postgresql_log_min_duration_statement_database_flag_disabled,
    control.sql_instance_postgresql_log_min_error_statement_database_flag_configured,
    control.sql_instance_postgresql_log_min_messages_database_flag_error,
    control.sql_instance_postgresql_log_statement_database_flag_ddl
  ]

  tags = merge(local.soc_2_2017_cc_7_common_tags, {
    soc_2_2017_item_id = "7.2.2"
  })
}

benchmark "soc_2_2017_cc_7_2_3" {
  title       = "CC7.2.3"

  children = [
    control.alloydb_instance_log_error_verbosity_database_flag_default_or_stricter,
    control.alloydb_instance_log_min_error_statement_database_flag_configured,
    control.alloydb_instance_log_min_messages_database_flag_error,
    control.enable_network_flow_logs,
    control.sql_instance_postgresql_log_connections_database_flag_on,
    control.sql_instance_postgresql_log_disconnections_database_flag_on,
    control.sql_instance_postgresql_log_error_verbosity_database_flag_default_or_stricter,
    control.sql_instance_postgresql_log_min_duration_statement_database_flag_disabled,
    control.sql_instance_postgresql_log_min_error_statement_database_flag_configured,
    control.sql_instance_postgresql_log_min_messages_database_flag_error,
    control.sql_instance_postgresql_log_statement_database_flag_ddl
  ]

  tags = merge(local.soc_2_2017_cc_7_common_tags, {
    soc_2_2017_item_id = "7.2.3"
  })
}

benchmark "soc_2_2017_cc_7_2_4" {
  title       = "CC7.2.4"

  children = [
    control.enable_network_flow_logs
  ]

  tags = merge(local.soc_2_2017_cc_7_common_tags, {
    soc_2_2017_item_id = "7.2.4"
  })
}

benchmark "soc_2_2017_cc_7_3" {
  title       = "CC7.3 The entity evaluates security events to determine whether they could or have resulted in a failure of the entity to meet its objectives (security incidents) and, if so, takes actions to prevent or address such failures"

  children = [
    benchmark.soc_2_2017_cc_7_3_1,
    benchmark.soc_2_2017_cc_7_3_2,
    benchmark.soc_2_2017_cc_7_3_3,
    benchmark.soc_2_2017_cc_7_3_4,
    benchmark.soc_2_2017_cc_7_3_5
  ]

  tags = merge(local.soc_2_2017_cc_7_common_tags, {
    soc_2_2017_item_id = "7.3"
  })
}

benchmark "soc_2_2017_cc_7_3_1" {
  title       = "CC7.3.1"

  children = [
    control.audit_logging_configured_for_all_service,
    control.compute_network_dns_logging_enabled
  ]

  tags = merge(local.soc_2_2017_cc_7_common_tags, {
    soc_2_2017_item_id = "7.3.1"
  })
}

benchmark "soc_2_2017_cc_7_3_2" {
  title       = "CC7.3.2"

  children = [
    control.audit_logging_configured_for_all_service,
    control.compute_network_dns_logging_enabled
  ]

  tags = merge(local.soc_2_2017_cc_7_common_tags, {
    soc_2_2017_item_id = "7.3.2"
  })
}

benchmark "soc_2_2017_cc_7_3_3" {
  title       = "CC7.3.3"

  children = [
    control.audit_logging_configured_for_all_service,
    control.compute_network_dns_logging_enabled,
  ]

  tags = merge(local.soc_2_2017_cc_7_common_tags, {
    soc_2_2017_item_id = "7.3.3"
  })
}

benchmark "soc_2_2017_cc_7_3_4" {
  title       = "CC7.3.4"

  children = [
    control.audit_logging_configured_for_all_service,
    control.compute_network_dns_logging_enabled
  ]

  tags = merge(local.soc_2_2017_cc_7_common_tags, {
    soc_2_2017_item_id = "7.3.4"
  })
}

benchmark "soc_2_2017_cc_7_3_5" {
  title       = "CC7.3.5"

  children = [
    control.audit_logging_configured_for_all_service,
    control.compute_network_dns_logging_enabled
  ]

  tags = merge(local.soc_2_2017_cc_7_common_tags, {
    soc_2_2017_item_id = "7.3.5"
  })
}