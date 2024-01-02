locals {
  all_controls_sql_common_tags = merge(local.all_controls_common_tags, {
    service = "GCP/SQL"
  })
}

benchmark "all_controls_sql" {
  title       = "SQL"
  description = "This section contains recommendations for configuring SQL resources."
  children = [
    control.prevent_public_ip_cloudsql,
    control.require_ssl_sql,
    control.sql_instance_automated_backups_enabled,
    control.sql_instance_mysql_binary_log_enabled,
    control.sql_instance_mysql_local_infile_database_flag_off,
    control.sql_instance_mysql_skip_show_database_flag_on,
    control.sql_instance_not_publicly_accessible,
    control.sql_instance_postgresql_cloudsql_pgaudit_database_flag_enabled,
    control.sql_instance_postgresql_log_checkpoints_database_flag_on,
    control.sql_instance_postgresql_log_connections_database_flag_on,
    control.sql_instance_postgresql_log_disconnections_database_flag_on,
    control.sql_instance_postgresql_log_duration_database_flag_on,
    control.sql_instance_postgresql_log_error_verbosity_database_flag_default_or_stricter,
    control.sql_instance_postgresql_log_executor_stats_database_flag_off,
    control.sql_instance_postgresql_log_hostname_database_flag_configured,
    control.sql_instance_postgresql_log_lock_waits_database_flag_on,
    control.sql_instance_postgresql_log_min_duration_statement_database_flag_disabled,
    control.sql_instance_postgresql_log_min_error_statement_database_flag_configured,
    control.sql_instance_postgresql_log_min_messages_database_flag_error,
    control.sql_instance_postgresql_log_parser_stats_database_flag_off,
    control.sql_instance_postgresql_log_planner_stats_database_flag_off,
    control.sql_instance_postgresql_log_statement_database_flag_ddl,
    control.sql_instance_postgresql_log_statement_stats_database_flag_off,
    control.sql_instance_postgresql_log_temp_files_database_flag_0,
    control.sql_instance_sql_3625_trace_database_flag_off,
    control.sql_instance_sql_3625_trace_database_flag_on,
    control.sql_instance_sql_contained_database_authentication_database_flag_off,
    control.sql_instance_sql_cross_db_ownership_chaining_database_flag_off,
    control.sql_instance_sql_external_scripts_enabled_database_flag_off,
    control.sql_instance_sql_remote_access_database_flag_off,
    control.sql_instance_sql_user_connections_database_flag_configured,
    control.sql_instance_sql_user_options_database_flag_not_configured,
    control.sql_instance_with_labels,
    control.sql_world_readable
  ]

  tags = merge(local.all_controls_sql_common_tags, {
    type = "Benchmark"
  })
}
