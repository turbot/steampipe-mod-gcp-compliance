locals {
  policy_bundle_sql_common_tags = merge(local.gcp_compliance_common_tags, {
    service = "GCP/SQL"
  })
}

control "sql_world_readable" {
  title = "Check if Cloud SQL instances are world readable"
  query = query.sql_instance_not_open_to_internet

  tags = merge(local.policy_bundle_sql_common_tags, {
    cft_scorecard_v1      = "true"
    forseti_security_v226 = "true"
    severity              = "high"
  })
}

control "prevent_public_ip_cloudsql" {
  title = "Prevent a public IP from being assigned to a Cloud SQL instance"
  query = query.sql_instance_with_no_public_ips

  tags = merge(local.policy_bundle_sql_common_tags, {
    cft_scorecard_v1 = "true"
    severity         = "high"
  })
}

control "require_ssl_sql" {
  title = "Check if Cloud SQL instances have SSL turned on"
  query = query.sql_instance_require_ssl_enabled

  tags = merge(local.policy_bundle_sql_common_tags, {
    cft_scorecard_v1 = "true"
    severity         = "high"
  })
}

query "sql_instance_not_open_to_internet" {
  sql = <<-EOQ
    select
      self_link as resource,
      case
        when ip_configuration -> 'authorizedNetworks' @> '[{"name": "internet", "value": "0.0.0.0/0"}]' then 'alarm'
        else 'ok'
      end as status,
      case
        when ip_configuration -> 'authorizedNetworks' @> '[{"name": "internet", "value": "0.0.0.0/0"}]'
          then title || ' is open to internet.'
        else title || ' is not open to internet.'
      end as reason
    ${local.tag_dimensions_sql}
    ${local.common_dimensions_sql}
    from
      gcp_sql_database_instance;
  EOQ
}

query "sql_instance_with_no_public_ips" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when ip_addresses @> '[{"type": "PRIMARY"}]' and backend_type = 'SECOND_GEN' then 'alarm'
        else 'ok'
      end as status,
      case
        when ip_addresses @> '[{"type": "PRIMARY"}]' and backend_type = 'SECOND_GEN'
          then title || ' associated with public IPs.'
        else title || ' not associated with public IPs.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_sql_database_instance;
  EOQ
}

query "sql_instance_require_ssl_enabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when ip_configuration -> 'requireSsl' is null then 'alarm'
        else 'ok'
      end as status,
      case
        when ip_configuration -> 'requireSsl' is null
          then title || ' does not enforce SSL connections.'
        else title || ' enforces SSL connections.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_sql_database_instance;
  EOQ
}

# Non-Config rule query

query "sql_instance_automated_backups_enabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when backup_enabled then 'ok'
        else 'alarm'
      end as status,
      case
        when backup_enabled
          then title || ' automatic backups configured.'
        else title || ' automatic backups not configured.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_sql_database_instance;
  EOQ
}

query "sql_instance_mysql_local_infile_database_flag_off" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when database_version not like 'MYSQL%' then 'skip'
        when database_flags @> '[{"name":"local_infile","value":"off"}]' then 'ok'
        else 'alarm'
      end as status,
      case
        when database_version not like 'MYSQL%'
          then title || ' not a MySQL database.'
        when database_flags is null or not (database_flags @> '[{"name":"local_infile"}]')
          then title || ' ''local_infile'' database flag not set.'
        when database_flags @> '[{"name":"local_infile","value":"off"}]'
          then title || ' ''local_infile'' database flag set to ''off''.'
        else title || ' ''local_infile'' database flag set to ''on''.'
      end as reason
        ${local.tag_dimensions_sql}
        ${local.common_dimensions_sql}
    from
      gcp_sql_database_instance;
  EOQ
}

query "sql_instance_mysql_skip_show_database_flag_on" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when database_version not like 'MYSQL%' then 'skip'
        when database_flags @> '[{"name":"skip_show_database","value":"on"}]' then 'ok'
        else 'alarm'
      end as status,
      case
        when database_version not like 'MYSQL%'
          then title || ' not a MySQL database.'
        when database_flags is null or not (database_flags @> '[{"name":"skip_show_database"}]')
          then title || ' ''skip_show_database'' database flag not set.'
        when database_flags @> '[{"name":"skip_show_database","value":"on"}]'
          then title || ' ''skip_show_database'' database flag set to ''on''.'
        else title || ' ''skip_show_database'' database flag set to ''off''.'
      end as reason
        ${local.tag_dimensions_sql}
        ${local.common_dimensions_sql}
    from
      gcp_sql_database_instance;
  EOQ
}

query "sql_instance_not_publicly_accessible" {
  sql = <<-EOQ
    select
      self_link as resource,
      case
        when (ip_addresses @> '[{"type": "PRIVATE"}]' and ip_configuration ->> 'privateNetwork' is not null) and not (ip_addresses @> '[{"type": "PRIMARY"}]') then 'ok'
        else 'alarm'
      end as status,
      case
        when (ip_addresses @> '[{"type": "PRIVATE"}]' and ip_configuration ->> 'privateNetwork' is not null) and not (ip_addresses @> '[{"type": "PRIMARY"}]') then title || ' not publicly accessible.'
        else title || ' publicly accessible.'
      end as reason
        ${local.tag_dimensions_sql}
        ${local.common_dimensions_sql}
    from
      gcp_sql_database_instance;
  EOQ
}

query "sql_instance_postgresql_cloudsql_pgaudit_database_flag_enabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when database_version not like 'POSTGRES%' then 'skip'
        when database_flags @> '[{"name":"cloudsql.enable_pgaudit","value":"on"}]' then 'ok'
        else 'alarm'
      end as status,
      case
        when database_version not like 'POSTGRES%'
          then title || ' not a PostgreSQL database.'
        when database_flags is null or not (database_flags @> '[{"name":"cloudsql.enable_pgaudit"}]')
          then title || ' ''cloudsql.enable_pgaudit'' database flag not set.'
        when database_flags @> '[{"name":"cloudsql.enable_pgaudit","value":"on"}]'
          then title || ' ''cloudsql.enable_pgaudit'' database flag enabled.'
        else title || ' ''cloudsql.enable_pgaudit'' database flag disabled.'
      end as reason
        ${local.tag_dimensions_sql}
        ${local.common_dimensions_sql}
    from
      gcp_sql_database_instance;
  EOQ
}

query "sql_instance_postgresql_log_checkpoints_database_flag_on" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when database_version not like 'POSTGRES%' then 'skip'
        when database_flags @> '[{"name":"log_checkpoints","value":"on"}]' then 'ok'
        else 'alarm'
      end as status,
      case
        when database_version not like 'POSTGRES%'
          then title || ' not a PostgreSQL database.'
        when database_flags is null or not (database_flags @> '[{"name":"log_checkpoints"}]')
          then title || ' ''log_checkpoints'' database flag not set.'
        when database_flags @> '[{"name":"log_checkpoints","value":"on"}]'
          then title || ' ''log_checkpoints'' database flag set to ''on''.'
        else title || ' ''log_checkpoints'' database flag set to ''off''.'
      end as reason
        ${local.tag_dimensions_sql}
        ${local.common_dimensions_sql}
    from
      gcp_sql_database_instance;
  EOQ
}

query "sql_instance_postgresql_log_connections_database_flag_on" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when database_version not like 'POSTGRES%' then 'skip'
        when database_flags @> '[{"name":"log_connections","value":"on"}]' then 'ok'
        else 'alarm'
      end as status,
      case
        when database_version not like 'POSTGRES%'
          then title || ' not a PostgreSQL database.'
        when database_flags is null or not (database_flags @> '[{"name":"log_connections"}]')
          then title || ' ''log_connections'' database flag not set.'
        when database_flags @> '[{"name":"log_connections","value":"on"}]'
          then title || ' ''log_connections'' database flag set to ''on''.'
        else title || ' ''log_connections'' database flag set to ''off''.'
      end as reason
        ${local.tag_dimensions_sql}
        ${local.common_dimensions_sql}
    from
      gcp_sql_database_instance;
  EOQ
}

query "sql_instance_postgresql_log_disconnections_database_flag_on" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when database_version not like 'POSTGRES%' then 'skip'
        when database_flags @> '[{"name":"log_disconnections","value":"on"}]' then 'ok'
        else 'alarm'
      end as status,
      case
        when database_version not like 'POSTGRES%'
          then title || ' not a PostgreSQL database.'
        when database_flags is null or not (database_flags @> '[{"name":"log_disconnections"}]')
          then title || ' ''log_disconnections'' database flag not set.'
        when database_flags @> '[{"name":"log_disconnections","value":"on"}]'
          then title || ' ''log_disconnections'' database flag set to ''on''.'
        else title || ' ''log_disconnections'' database flag set to ''off''.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_sql_database_instance;
  EOQ
}

query "sql_instance_postgresql_log_duration_database_flag_on" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when database_version not like 'POSTGRES%' then 'skip'
        when database_flags @> '[{"name":"log_duration","value":"on"}]' then 'ok'
        else 'alarm'
      end as status,
      case
        when database_version not like 'POSTGRES%'
          then title || ' not a PostgreSQL database.'
        when database_flags is null or not (database_flags @> '[{"name":"log_duration"}]')
          then title || ' ''log_duration'' database flag not set.'
        when database_flags @> '[{"name":"log_duration","value":"on"}]'
          then title || ' ''log_duration'' database flag set to ''on''.'
        else title || ' ''log_duration'' database flag set to ''off''.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_sql_database_instance;
  EOQ
}

query "sql_instance_postgresql_log_error_verbosity_database_flag_default_or_stricter" {
  sql = <<-EOQ
    select
      self_link as resource,
      case
        when database_version not like 'POSTGRES%' then 'skip'
        when database_flags @> '[{"name": "log_error_verbosity","value":"default"}]' or database_flags @> '[{"name": "log_error_verbosity","value":"verbose"}]' then 'ok'
        else 'alarm'
      end as status,
      case
        when database_version not like 'POSTGRES%' then title || ' not a PostgreSQL database.'
        when database_flags @> '[{"name": "log_error_verbosity","value":"default"}]' then title || ' log_error_verbosity database flag set to DEFAULT.'
        when database_flags @> '[{"name": "log_error_verbosity","value":"verbose"}]' then title || ' log_error_verbosity database flag set to VERBOSE.'
        when database_flags @> '[{"name": "log_error_verbosity","value":"terse"}]' then title || ' log_error_verbosity database flag set to TERSE.'
        else title || ' log_error_verbosity database flag not set.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_sql_database_instance;
  EOQ
}

query "sql_instance_postgresql_log_executor_stats_database_flag_off" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when database_version not like 'POSTGRES%' then 'skip'
        when database_flags @> '[{"name":"log_executor_stats","value":"off"}]' then 'ok'
        else 'alarm'
      end as status,
      case
        when database_version not like 'POSTGRES%'
          then title || ' not a PostgreSQL database.'
        when database_flags is null or not (database_flags @> '[{"name":"log_executor_stats"}]')
          then title || ' ''log_executor_stats'' database flag not set.'
        when database_flags @> '[{"name":"log_executor_stats","value":"off"}]'
          then title || ' ''log_executor_stats'' database flag set to ''off''.'
        else title || ' ''log_executor_stats'' database flag set to ''on''.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_sql_database_instance;
  EOQ
}

query "sql_instance_postgresql_log_hostname_database_flag_configured" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when database_version not like 'POSTGRES%' then 'skip'
        when database_flags @> '[{"name":"log_hostname","value":"on"}]' then 'ok'
        else 'alarm'
      end as status,
      case
        when database_version not like 'POSTGRES%'
          then title || ' not a PostgreSQL database.'
        when database_flags is null or not (database_flags @> '[{"name":"log_hostname"}]')
          then title || ' ''log_hostname'' database flag not set.'
        when database_flags @> '[{"name":"log_hostname","value":"on"}]'
          then title || ' ''log_hostname'' database flag set to ''on''.'
        else title || ' ''log_hostname'' database flag set to ''off''.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_sql_database_instance;
  EOQ
}

query "sql_instance_postgresql_log_lock_waits_database_flag_on" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when database_version not like 'POSTGRES%' then 'skip'
        when database_flags @> '[{"name":"log_lock_waits","value":"on"}]' then 'ok'
        else 'alarm'
      end as status,
      case
        when database_version not like 'POSTGRES%'
          then title || ' not a PostgreSQL database.'
        when database_flags is null or not (database_flags @> '[{"name":"log_lock_waits"}]')
          then title || ' ''log_lock_waits'' database flag not set.'
        when database_flags @> '[{"name":"log_lock_waits","value":"on"}]'
          then title || ' ''log_lock_waits'' database flag set to ''on''.'
        else title || ' ''log_lock_waits'' database flag set to ''off''.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_sql_database_instance;
  EOQ
}

query "sql_instance_postgresql_log_min_duration_statement_database_flag_disabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when database_version not like 'POSTGRES%' then 'skip'
        when database_flags @> '[{"name":"log_min_duration_statement","value":"-1"}]' then 'ok'
        else 'alarm'
      end as status,
      case
        when database_version not like 'POSTGRES%'
          then title || ' not a PostgreSQL database.'
        when database_flags is null or not (database_flags @> '[{"name":"log_min_duration_statement"}]')
          then title || ' ''log_min_duration_statement'' database flag not set.'
        when database_flags @> '[{"name":"log_min_duration_statement","value":"-1"}]'
          then title || ' ''log_min_duration_statement'' database flag disabled.'
        else title || ' ''log_min_duration_statement'' database flag enabled.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_sql_database_instance;
  EOQ
}

query "sql_instance_postgresql_log_min_error_statement_database_flag_configured" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when database_version not like 'POSTGRES%' then 'skip'
        when database_flags @> '[{"name":"log_min_error_statement"}]' then 'ok'
        else 'alarm'
      end as status,
      case
        when database_version not like 'POSTGRES%'
          then title || ' not a PostgreSQL database.'
        when database_flags @> '[{"name":"log_min_error_statement"}]'
          then title || ' ''log_min_error_statement'' database flag set.'
        else title || ' ''log_min_error_statement'' database flag not set.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_sql_database_instance;
  EOQ
}

query "sql_instance_postgresql_log_min_messages_database_flag_error" {
  sql = <<-EOQ
    select
      self_link as resource,
      case
        when database_version not like 'POSTGRES%' then 'skip'
        when database_flags is null or not (database_flags @> '[{"name":"log_min_messages"}]') then 'alarm'
        when database_flags @> '[{"name":"log_min_messages","value":"error"}]' or database_flags @> '[{"name":"log_min_messages","value":"warning"}]' then 'ok'
        else 'alarm'
      end as status,
      case
        when database_version not like 'POSTGRES%' then title || ' not a PostgreSQL database.'
        when database_flags is null or not (database_flags @> '[{"name":"log_min_messages"}]') then title || ' log_min_messages database flag not set.'
        when database_flags @> '[{"name":"log_min_messages","value":"error"}]' then title || ' log_min_messages database flag set to ERROR.'
        when database_flags @> '[{"name":"log_min_messages","value":"warning"}]' then title || ' log_min_messages database flag set to WARNING.'
        else title || ' log_min_messages database flag not set at minimum to WARNING.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_sql_database_instance;
  EOQ
}

query "sql_instance_postgresql_log_parser_stats_database_flag_off" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when database_version not like 'POSTGRES%' then 'skip'
        when database_flags @> '[{"name":"log_parser_stats","value":"off"}]' then 'ok'
        else 'alarm'
      end as status,
      case
        when database_version not like 'POSTGRES%'
          then title || ' not a PostgreSQL database.'
        when database_flags is null or not (database_flags @> '[{"name":"log_parser_stats"}]')
          then title || ' ''log_parser_stats'' database flag not set.'
        when database_flags @> '[{"name":"log_parser_stats","value":"off"}]'
          then title || ' ''log_parser_stats'' database flag set to ''off''.'
        else title || ' ''log_parser_stats'' database flag set to ''on''.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_sql_database_instance;
  EOQ
}

query "sql_instance_postgresql_log_planner_stats_database_flag_off" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when database_version not like 'POSTGRES%' then 'skip'
        when database_flags @> '[{"name":"log_planner_stats","value":"off"}]' then 'ok'
        else 'alarm'
      end as status,
      case
        when database_version not like 'POSTGRES%'
          then title || ' not a PostgreSQL database.'
        when database_flags is null or not (database_flags @> '[{"name":"log_planner_stats"}]')
          then title || ' ''log_planner_stats'' database flag not set.'
        when database_flags @> '[{"name":"log_planner_stats","value":"off"}]'
          then title || ' ''log_planner_stats'' database flag set to ''off''.'
        else title || ' ''log_planner_stats'' database flag set to ''on''.'
      end as reason
        ${local.tag_dimensions_sql}
        ${local.common_dimensions_sql}
    from
      gcp_sql_database_instance;
  EOQ
}

query "sql_instance_postgresql_log_statement_database_flag_ddl" {
  sql = <<-EOQ
    select
      self_link as resource,
      case
        when database_version not like 'POSTGRES%' then 'skip'
        when database_flags is null or not (database_flags @> '[{"name":"log_statement"}]') then 'alarm'
        when database_flags @> '[{"name": "log_statement","value":"ddl"}]' then 'ok'
        else 'alarm'
      end as status,
      case
        when database_version not like 'POSTGRES%' then title || ' not a PostgreSQL database.'
        when database_flags is null or not (database_flags @> '[{"name":"log_statement"}]') then title || ' log_statement database flag not set.'
        when database_flags @> '[{"name": "log_statement","value":"ddl"}]' then title || ' log_statement database flag set to ddl.'
        when database_flags @> '[{"name": "log_statement","value":"mod"}]' then title || ' log_statement database flag set to mod.'
        when database_flags @> '[{"name": "log_statement","value":"all"}]' then title || ' log_statement database flag set to all.'
        when database_flags @> '[{"name": "log_statement","value":"none"}]' then title || ' log_statement database flag set to none.'
      end as reason
        ${local.tag_dimensions_sql}
        ${local.common_dimensions_sql}
    from
      gcp_sql_database_instance;
  EOQ
}

query "sql_instance_postgresql_log_statement_stats_database_flag_off" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when database_version not like 'POSTGRES%' then 'skip'
        when database_flags @> '[{"name":"log_statement_stats","value":"off"}]' then 'ok'
        else 'alarm'
      end as status,
      case
        when database_version not like 'POSTGRES%'
          then title || ' not a PostgreSQL database.'
        when database_flags is null or not (database_flags @> '[{"name":"log_statement_stats"}]')
          then title || ' ''log_statement_stats'' database flag not set.'
        when database_flags @> '[{"name":"log_statement_stats","value":"off"}]'
          then title || ' ''log_statement_stats'' database flag set to ''off''.'
        else title || ' ''log_statement_stats'' database flag set to ''on''.'
      end as reason
        ${local.tag_dimensions_sql}
        ${local.common_dimensions_sql}
    from
      gcp_sql_database_instance;
  EOQ
}

query "sql_instance_postgresql_log_temp_files_database_flag_0" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when database_version not like 'POSTGRES%' then 'skip'
        when database_flags @> '[{"name":"log_temp_files","value":"0"}]' then 'ok'
        else 'alarm'
      end as status,
      case
        when database_version not like 'POSTGRES%'
          then title || ' not a PostgreSQL database.'
        when database_flags is null or not (database_flags @> '[{"name":"log_temp_files"}]')
          then title || ' ''log_temp_files'' database flag not set.'
        when database_flags @> '[{"name":"log_temp_files","value":"0"}]'
          then title || ' ''log_temp_files'' database flag set to ''0''.'
        else title || ' ''log_temp_files'' database flag not set to ''0''.'
      end as reason
        ${local.tag_dimensions_sql}
        ${local.common_dimensions_sql}
    from
      gcp_sql_database_instance;
  EOQ
}

query "sql_instance_sql_3625_trace_database_flag_off" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when database_version not like 'SQLSERVER%' then 'skip'
        when database_flags @> '[{"name":"3625","value":"off"}]' then 'ok'
        else 'alarm'
      end as status,
      case
        when database_version not like 'SQLSERVER%'
          then title || ' not a SQL Server database.'
        when database_flags is null or not (database_flags @> '[{"name":"3625"}]')
          then title || ' ''3625 (trace flag)'' not set.'
        when database_flags @> '[{"name":"3625","value":"off"}]'
          then title || ' ''3625 (trace flag)'' database flag set to ''off''.'
        else title || ' ''3625 (trace flag)'' database flag set to ''on''.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_sql_database_instance;
  EOQ
}

query "sql_instance_sql_3625_trace_database_flag_on" {
  sql = <<-EOQ
    select
      self_link as resource,
      case
        when database_version not like 'SQLSERVER%' then 'skip'
        when database_flags @> '[{"name":"3625","value":"on"}]' then 'ok'
        else 'alarm'
      end as status,
      case
        when database_version not like 'SQLSERVER%' then title || ' not a SQL Server database.'
        when database_flags is null or not (database_flags @> '[{"name":"3625"}]') then title || ' ''3625 (trace flag)'' not set.'
        when database_flags @> '[{"name":"3625","value":"on"}]' then title || ' ''3625 (trace flag)'' database flag set to ''on''.'
        else title || ' ''3625 (trace flag)'' database flag set to ''off''.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_sql_database_instance;
  EOQ
}

query "sql_instance_sql_contained_database_authentication_database_flag_off" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when database_version not like 'SQLSERVER%' then 'skip'
        when database_flags @> '[{"name":"contained database authentication","value":"off"}]' then 'ok'
        else 'alarm'
      end as status,
      case
        when database_version not like 'SQLSERVER%'
          then title || ' not a SQL Server database.'
        when database_flags is null or not (database_flags @> '[{"name":"contained database authentication"}]')
          then title || ' ''contained database authentication'' not set.'
        when database_flags @> '[{"name":"contained database authentication","value":"off"}]'
          then title || ' ''contained database authentication'' database flag set to ''off''.'
        else title || ' ''contained database authentication'' database flag set to ''on''.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_sql_database_instance;
  EOQ
}

query "sql_instance_sql_cross_db_ownership_chaining_database_flag_off" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when database_version not like 'SQLSERVER%' then 'skip'
        when database_flags @> '[{"name":"cross db ownership chaining","value":"off"}]' then 'ok'
        else 'alarm'
      end as status,
      case
        when database_version not like 'SQLSERVER%'
          then title || ' not a SQL Server database.'
        when database_flags is null or not (database_flags @> '[{"name":"cross db ownership chaining"}]')
          then title || ' ''cross db ownership chaining'' not set.'
        when database_flags @> '[{"name":"cross db ownership chaining","value":"off"}]'
          then title || ' ''cross db ownership chaining'' database flag set to ''off''.'
        else title || ' ''cross db ownership chaining'' database flag set to ''on''.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_sql_database_instance;
  EOQ
}

query "sql_instance_sql_external_scripts_enabled_database_flag_off" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when database_version not like 'SQLSERVER%' then 'skip'
        when database_flags @> '[{"name":"external scripts enabled","value":"off"}]' then 'ok'
        else 'alarm'
      end as status,
      case
        when database_version not like 'SQLSERVER%'
          then title || ' not a SQL Server database.'
        when database_flags is null or not (database_flags @> '[{"name":"external scripts enabled"}]')
          then title || ' ''external scripts enabled'' not set.'
        when database_flags @> '[{"name":"external scripts enabled","value":"off"}]'
          then title || ' ''external scripts enabled'' database flag set to ''off''.'
        else title || ' ''external scripts enabled'' database flag set to ''on''.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_sql_database_instance;
  EOQ
}

query "sql_instance_sql_remote_access_database_flag_off" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when database_version not like 'SQLSERVER%' then 'skip'
        when database_flags @> '[{"name":"remote access","value":"off"}]' then 'ok'
        else 'alarm'
      end as status,
      case
        when database_version not like 'SQLSERVER%'
          then title || ' not a SQL Server database.'
        when database_flags is null or not (database_flags @> '[{"name":"remote access"}]')
          then title || ' ''remote access'' not set.'
        when database_flags @> '[{"name":"remote access","value":"off"}]'
          then title || ' ''remote access'' database flag set to ''off''.'
        else title || ' ''remote access'' database flag set to ''on''.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_sql_database_instance;
  EOQ
}

query "sql_instance_sql_user_connections_database_flag_configured" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when database_version not like 'SQLSERVER%' then 'skip'
        when database_flags @> '[{"name":"user connections"}]' then 'ok'
        else 'alarm'
      end as status,
      case
        when database_version not like 'SQLSERVER%'
          then title || ' not a SQL Server database.'
        when database_flags @> '[{"name":"user connections"}]'
          then title || ' ''user connections'' database flag set.'
        else title || ' ''user connections'' database flag not set.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_sql_database_instance;
  EOQ
}

query "sql_instance_sql_user_options_database_flag_not_configured" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when database_version not like 'SQLSERVER%' then 'skip'
        when database_flags @> '[{"name":"user options"}]' then 'alarm'
        else 'ok'
      end as status,
      case
        when database_version not like 'SQLSERVER%'
          then title || ' not a SQL Server database.'
        when database_flags @> '[{"name":"user options"}]'
          then title || ' ''user options'' database flag set.'
        else title || ' ''user options'' database flag not set.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_sql_database_instance;
  EOQ
}
