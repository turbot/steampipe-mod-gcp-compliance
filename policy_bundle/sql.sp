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

control "sql_instance_automated_backups_enabled" {
  title       = "Ensure that Cloud SQL database instances are configured with automated backups"
  description = "It is recommended to have all SQL database instances set to enable automated backups."
  query       = query.sql_instance_automated_backups_enabled

  tags = local.policy_bundle_sql_common_tags
}

control "sql_instance_mysql_local_infile_database_flag_off" {
  title       = "Ensure that the 'local_infile' database flag for a Cloud SQL Mysql instance is set to 'off'"
  description = "It is recommended to set the local_infile database flag for a Cloud SQL MySQL instance to off."
  query       = query.sql_instance_mysql_local_infile_database_flag_off

  tags = local.policy_bundle_sql_common_tags
}

control "sql_instance_mysql_skip_show_database_flag_on" {
  title       = "Ensure 'skip_show_database' database flag for Cloud SQL Mysql instance is set to 'on'"
  description = "It is recommended to set skip_show_database database flag for Cloud SQL Mysql instance to on."
  query       = query.sql_instance_mysql_skip_show_database_flag_on

  tags = local.policy_bundle_sql_common_tags
}

control "sql_instance_not_publicly_accessible" {
  title       = "Ensure Instance IP assignment is set to private"
  description = "Instance addresses can be public IP or private IP. Public IP means that the instance is accessible through the public internet. In contrast, instances using only private IP are not accessible through the public internet, but are accessible through a Virtual Private Cloud (VPC)."
  query       = query.sql_instance_not_publicly_accessible

  tags = local.policy_bundle_sql_common_tags
}

control "sql_instance_postgresql_cloudsql_pgaudit_database_flag_enabled" {
  title       = "Ensure that 'cloudsql.enable_pgaudit' Database Flag for each Cloud Sql Postgresql Instance is Set to 'on' For Centralized Logging"
  description = "Ensure cloudsql.enable_pgaudit database flag for Cloud SQL PostgreSQL instance is set to on to allow for centralized logging."
  query       = query.sql_instance_postgresql_cloudsql_pgaudit_database_flag_enabled

  tags = local.policy_bundle_sql_common_tags
}

control "sql_instance_postgresql_log_checkpoints_database_flag_on" {
  title       = "Ensure that the 'log_checkpoints' database flag for Cloud SQL PostgreSQL instance is set to 'on'"
  description = "Ensure that the log_checkpoints database flag for the Cloud SQL PostgreSQL instance is set to on."
  query       = query.sql_instance_postgresql_log_checkpoints_database_flag_on

  tags = local.policy_bundle_sql_common_tags
}

control "sql_instance_postgresql_log_connections_database_flag_on" {
  title       = "Ensure that the 'log_connections' database flag for Cloud SQL PostgreSQL instance is set to 'on'"
  description = "Enabling the log_connections setting causes each attempted connection to the server to be logged, along with successful completion of client authentication. This parameter cannot be changed after the session starts."
  query       = query.sql_instance_postgresql_log_connections_database_flag_on

  tags = local.policy_bundle_sql_common_tags
}

control "sql_instance_postgresql_log_disconnections_database_flag_on" {
  title       = "Ensure that the 'log_disconnections' database flag for Cloud SQL PostgreSQL instance is set to 'on'"
  description = "Enabling the log_disconnections setting logs the end of each session, including the session duration."
  query       = query.sql_instance_postgresql_log_disconnections_database_flag_on

  tags = local.policy_bundle_sql_common_tags
}

control "sql_instance_postgresql_log_duration_database_flag_on" {
  title       = "Ensure 'log_duration' database flag for Cloud SQL PostgreSQL instance is set to 'on'"
  description = "Enabling the log_duration setting causes the duration of each completed statement to be logged. This does not logs the text of the query and thus behaves different from the log_min_duration_statement flag. This parameter cannot be changed after session start."
  query       = query.sql_instance_postgresql_log_duration_database_flag_on

  tags = local.policy_bundle_sql_common_tags
}

control "sql_instance_postgresql_log_error_verbosity_database_flag_default_or_stricter" {
  title       = "Ensure 'log_error_verbosity' database flag for Cloud SQL PostgreSQL instance is set to 'DEFAULT' or stricter"
  description = "The log_error_verbosity flag controls the verbosity/details of messages logged. Valid values are: 'TERSE', 'DEFAULT', and 'VERBOSE'."
  query       = query.sql_instance_postgresql_log_error_verbosity_database_flag_default_or_stricter

  tags = local.policy_bundle_sql_common_tags
}

control "sql_instance_postgresql_log_executor_stats_database_flag_off" {
  title       = "Ensure 'log_executor_stats' database flag for Cloud SQL PostgreSQL instance is set to 'off'"
  description = "The PostgreSQL executor is responsible to execute the plan handed over by the PostgreSQL planner. The executor processes the plan recursively to extract the required set of rows. The log_executor_stats flag controls the inclusion of PostgreSQL executor performance statistics in the PostgreSQL logs for each query."
  query       = query.sql_instance_postgresql_log_executor_stats_database_flag_off

  tags = local.policy_bundle_sql_common_tags
}

control "sql_instance_postgresql_log_hostname_database_flag_configured" {
  title       = "Ensure 'log_hostname' database flag for Cloud SQL PostgreSQL instance is set appropriately"
  description = "PostgreSQL logs only the IP address of the connecting hosts. The log_hostname flag controls the logging of hostnames in addition to the IP addresses logged. The performance hit is dependent on the configuration of the environment and the host name resolution setup. This parameter can only be set in the postgresql.conf file or on the server command line."
  query       = query.sql_instance_postgresql_log_hostname_database_flag_configured

  tags = local.policy_bundle_sql_common_tags
}

control "sql_instance_postgresql_log_lock_waits_database_flag_on" {
  title       = "Ensure that the 'log_lock_waits' database flag for Cloud SQL PostgreSQL instance is set to 'on'"
  description = "Enabling the log_lock_waits flag for a PostgreSQL instance creates a log for any session waits that take longer than the allotted deadlock_timeout time to acquire a lock."
  query       = query.sql_instance_postgresql_log_lock_waits_database_flag_on

  tags = local.policy_bundle_sql_common_tags
}

control "sql_instance_postgresql_log_min_duration_statement_database_flag_disabled" {
  title       = "Ensure that the 'log_min_duration_statement' database flag for Cloud SQL PostgreSQL instance is set to '-1' (disabled)"
  description = "The log_min_duration_statement flag defines the minimum amount of execution time of a statement in milliseconds where the total duration of the statement is logged. Ensure that log_min_duration_statement is disabled, i.e., a value of -1 is set."
  query       = query.sql_instance_postgresql_log_min_duration_statement_database_flag_disabled

  tags = local.policy_bundle_sql_common_tags
}

control "sql_instance_postgresql_log_min_error_statement_database_flag_configured" {
  title       = "Ensure 'log_min_error_statement' database flag for Cloud SQL PostgreSQL instance is set to 'Error' or stricter"
  description = "The log_min_error_statement flag defines the minimum message severity level that are considered as an error statement. Messages for error statements are logged with the SQL statement. Valid values include DEBUG5, DEBUG4, DEBUG3, DEBUG2, DEBUG1, INFO, NOTICE, WARNING, ERROR, LOG, FATAL, and PANIC. Each severity level includes the subsequent levels mentioned above. Ensure a value of ERROR or stricter is set."
  query       = query.sql_instance_postgresql_log_min_error_statement_database_flag_configured

  tags = local.policy_bundle_sql_common_tags
}

control "sql_instance_postgresql_log_min_messages_database_flag_error" {
  title       = "Ensure that the 'Log_min_messages' Flag for a Cloud SQL PostgreSQL Instance is set at minimum to 'Warning'"
  description = "The log_min_messages flag defines the minimum message severity level that is considered as an error statement. Messages for error statements are logged with the SQL statement. Valid values include DEBUG5, DEBUG4, DEBUG3, DEBUG2, DEBUG1, INFO, NOTICE, WARNING, ERROR, LOG, FATAL, and PANIC. Each severity level includes the subsequent levels mentioned above."
  query       = query.sql_instance_postgresql_log_min_messages_database_flag_error

  tags = local.policy_bundle_sql_common_tags
}

control "sql_instance_postgresql_log_parser_stats_database_flag_off" {
  title       = "Ensure 'log_parser_stats' database flag for Cloud SQL PostgreSQL instance is set to 'off'"
  description = "The PostgreSQL planner/optimizer is responsible to parse and verify the syntax of each query received by the server. If the syntax is correct a parse tree is built up else an error is generated. The log_parser_stats flag controls the inclusion of parser performance statistics in the PostgreSQL logs for each query."
  query       = query.sql_instance_postgresql_log_parser_stats_database_flag_off

  tags = local.policy_bundle_sql_common_tags
}

control "sql_instance_postgresql_log_planner_stats_database_flag_off" {
  title       = "Ensure 'log_planner_stats' database flag for Cloud SQL PostgreSQL instance is set to 'off'"
  description = "The same SQL query can be executed in multiple ways and still produce different results. The PostgreSQL planner/optimizer is responsible to create an optimal execution plan for each query. The log_planner_stats flag controls the inclusion of PostgreSQL planner performance statistics in the PostgreSQL logs for each query."
  query       = query.sql_instance_postgresql_log_planner_stats_database_flag_off

  tags = local.policy_bundle_sql_common_tags
}

control "sql_instance_postgresql_log_statement_database_flag_ddl" {
  title       = "Ensure 'log_statement' database flag for Cloud SQL PostgreSQL instance is set appropriately"
  description = "The value of log_statement flag determined the SQL statements that are logged. Valid values are: 'none', 'ddl', 'mod', and 'all'."
  query       = query.sql_instance_postgresql_log_statement_database_flag_ddl

  tags = local.policy_bundle_sql_common_tags
}

control "sql_instance_postgresql_log_statement_stats_database_flag_off" {
  title       = "Ensure 'log_statement_stats' database flag for Cloud SQL PostgreSQL instance is set to 'off'"
  description = "The log_statement_stats flag controls the inclusion of end-to-end performance statistics of a SQL query in the PostgreSQL logs for each query. This cannot be enabled with other module statistics (log_parser_stats, log_planner_stats, log_executor_stats)."
  query       = query.sql_instance_postgresql_log_statement_stats_database_flag_off

  tags = local.policy_bundle_sql_common_tags
}

control "sql_instance_postgresql_log_temp_files_database_flag_0" {
  title       = "Ensure that the 'log_temp_files' database flag for Cloud SQL PostgreSQL instance is set to '0'"
  description = "PostgreSQL can create a temporary file for actions such as sorting, hashing and temporary query results when these operations exceed work_mem. The log_temp_files flag controls logging names and the file size when it is deleted. Configuring log_temp_files to 0 causes all temporary file information to be logged, while positive values log only files whose size is greater than or equal to the specified number of kilobytes. A value of -1 disables temporary file information logging."
  query       = query.sql_instance_postgresql_log_temp_files_database_flag_0

  tags = local.policy_bundle_sql_common_tags
}

control "sql_instance_sql_3625_trace_database_flag_off" {
  title       = "Ensure '3625 (trace flag)' database flag for Cloud SQL SQL Server instance is set to 'off'"
  description = "It is recommended to set 3625 (trace flag) database flag for Cloud SQL SQL Server instance to off."
  query       = query.sql_instance_sql_3625_trace_database_flag_off

  tags = local.policy_bundle_sql_common_tags
}

control "sql_instance_sql_3625_trace_database_flag_on" {
  title       = "Ensure '3625 (trace flag)' database flag for Cloud SQL SQL Server instance is set to 'off'"
  description = "It is recommended to set 3625 (trace flag) database flag for Cloud SQL SQL Server instance to off."
  query       = query.sql_instance_sql_3625_trace_database_flag_on

  tags = local.policy_bundle_sql_common_tags
}

control "sql_instance_sql_contained_database_authentication_database_flag_off" {
  title       = "Ensure that the 'contained database authentication' database flag for Cloud SQL on the SQL Server instance is set to 'off'"
  description = "It is recommended to set contained database authentication database flag for Cloud SQL on the SQL Server instance is set to off."
  query       = query.sql_instance_sql_contained_database_authentication_database_flag_off

  tags = local.policy_bundle_sql_common_tags
}

control "sql_instance_sql_cross_db_ownership_chaining_database_flag_off" {
  title       = "Ensure that the 'cross db ownership chaining' database flag for Cloud SQL SQL Server instance is set to 'off'"
  description = "It is recommended to set cross db ownership chaining database flag for Cloud SQL SQL Server instance to off."
  query       = query.sql_instance_sql_cross_db_ownership_chaining_database_flag_off

  tags = local.policy_bundle_sql_common_tags
}

control "sql_instance_sql_external_scripts_enabled_database_flag_off" {
  title       = "Ensure 'external scripts enabled' database flag for Cloud SQL SQL Server instance is set to 'off'"
  description = "It is recommended to set external scripts enabled database flag for Cloud SQL SQL Server instance to off."
  query       = query.sql_instance_sql_external_scripts_enabled_database_flag_off

  tags = local.policy_bundle_sql_common_tags
}

control "sql_instance_sql_remote_access_database_flag_off" {
  title       = "Ensure 'remote access' database flag for Cloud SQL SQL Server instance is set to 'off'"
  description = "It is recommended to set remote access database flag for Cloud SQL SQL Server instance to off."
  query       = query.sql_instance_sql_remote_access_database_flag_off

  tags = local.policy_bundle_sql_common_tags
}

control "sql_instance_sql_user_connections_database_flag_configured" {
  title       = "Ensure 'remote access' database flag for Cloud SQL SQL Server instance is set to 'off'"
  description = "It is recommended to set remote access database flag for Cloud SQL SQL Server instance to off."
  query       = query.sql_instance_sql_user_connections_database_flag_configured

  tags = local.policy_bundle_sql_common_tags
}

control "sql_instance_sql_user_options_database_flag_not_configured" {
  title       = "Ensure 'user options' database flag for Cloud SQL SQL Server instance is not configured"
  description = "It is recommended that, user options database flag for Cloud SQL SQL Server instance should not be configured."
  query       = query.sql_instance_sql_user_options_database_flag_not_configured

  tags = local.policy_bundle_sql_common_tags
}

control "sql_instance_with_labels" {
  title       = "SQL Instances should have labels configured"
  description = "It is recommended that SQL Instance is configured with proper labels."
  query       = query.sql_instance_with_labels

  tags = local.policy_bundle_sql_common_tags
}

control "sql_instance_mysql_binary_log_enabled" {
  title       = "MySql Instances should have binary log enabled"
  description = "This controls ensures that MySql instance have binary log enabled."
  query       = query.sql_instance_mysql_binary_log_enabled

  tags = local.policy_bundle_sql_common_tags
}

query "sql_instance_not_open_to_internet" {
  sql = <<-EOQ
    select
      self_link as resource,
      case
        when exists (
          select 1
          from jsonb_array_elements(ip_configuration -> 'authorizedNetworks') as authNet
          where authNet ->> 'value' = '0.0.0.0/0' or authNet ->> 'value' = '::/0'
        ) then 'alarm'
        else 'ok'
      end as status,
      case
        when exists (
          select 1
          from jsonb_array_elements(ip_configuration -> 'authorizedNetworks') as authNet
          where authNet ->> 'value' = '0.0.0.0/0' or  authNet ->> 'value' = '::/0'
        ) then title || ' is open to the internet.'
        else title || ' is not open to the internet.'
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

query "sql_instance_with_labels" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when labels is not null then 'ok'
        else 'alarm'
      end as status,
      case
        when labels is not null then title || ' has labels attached.'
        else title || ' no labels attached.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_sql_database_instance;
  EOQ
}

query "sql_instance_mysql_binary_log_enabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when database_version not like 'MYSQL%' then 'skip'
        when binary_log_enabled then 'ok'
        else 'alarm'
      end as status,
      case
        when database_version not like 'MYSQL%' then title || ' not a MySQL database.'
        when binary_log_enabled then title || ' binary log enabled.'
        else title || ' binary log disabled.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_sql_database_instance;
  EOQ
}