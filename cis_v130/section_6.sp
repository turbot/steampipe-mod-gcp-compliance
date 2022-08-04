locals {
  cis_v120_6_common_tags = merge(local.cis_v130_common_tags, {
    cis_section_id = "6"
  })
}

locals {
  cis_v120_6_1_common_tags = merge(local.cis_v120_6_common_tags, {
    cis_section_id = "6.1"
  })
}

locals {
  cis_v120_6_2_common_tags = merge(local.cis_v120_6_common_tags, {
    cis_section_id = "6.2"
  })
}

locals {
  cis_v120_6_3_common_tags = merge(local.cis_v120_6_common_tags, {
    cis_section_id = "6.3"
  })
}

benchmark "cis_v120_6" {
  title         = "6 Cloud SQL Database Services"
  documentation = file("./cis_v120/docs/cis_v120_6.md")
  children = [
    benchmark.cis_v130_6_1,
    benchmark.cis_v130_6_2,
    benchmark.cis_v130_6_3,
    control.cis_v120_6_4,
    control.cis_v120_6_5,
    control.cis_v120_6_6,
    control.cis_v120_6_7
  ]

  tags = merge(local.cis_v120_6_common_tags, {
    type    = "Benchmark"
    service = "GCP/SQL"
  })
}

benchmark "cis_v120_6_1" {
  title         = "6.1 MySQL Database"
  documentation = file("./cis_v120/docs/cis_v120_6_1.md")
  children = [
    control.cis_v120_6_1_1,
    control.cis_v120_6_1_2,
    control.cis_v120_6_1_3
  ]

  tags = merge(local.cis_v120_6_1_common_tags, {
    type    = "Benchmark"
    service = "GCP/SQL"
  })
}

control "cis_v120_6_1_1" {
  title         = "6.1.1 Ensure that a MySQL database instance does not allow anyone to connect with administrative privileges"
  description   = "It is recommended to set a password for the administrative user (root by default) to prevent unauthorized access to the SQL database instances. This recommendation is applicable only for MySQL Instances. PostgreSQL does not offer any setting for No Password from the cloud console."
  documentation = file("./cis_v120/docs/cis_v120_6_1_1.md")
  sql           = query.manual_control.sql

  tags = merge(local.cis_v120_6_1_common_tags, {
    cis_item_id = "6.1.1"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/SQL"
  })
}

control "cis_v120_6_1_2" {
  title         = "6.1.2 Ensure 'skip_show_database' database flag for Cloud SQL Mysql instance is set to 'on'"
  description   = "It is recommended to set skip_show_database database flag for Cloud SQL Mysql instance to on."
  documentation = file("./cis_v120/docs/cis_v120_6_1_2.md")
  sql           = query.sql_instance_mysql_skip_show_database_flag_on.sql

  tags = merge(local.cis_v120_6_1_common_tags, {
    cis_item_id = "6.1.2"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/SQL"
  })
}

control "cis_v120_6_1_3" {
  title         = "6.1.3 Ensure that the 'local_infile' database flag for a Cloud SQL Mysql instance is set to 'off'"
  description   = "It is recommended to set the local_infile database flag for a Cloud SQL MySQL instance to off."
  documentation = file("./cis_v120/docs/cis_v120_6_1_3.md")
  sql           = query.sql_instance_mysql_local_infile_database_flag_off.sql

  tags = merge(local.cis_v120_6_1_common_tags, {
    cis_item_id = "6.1.3"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/SQL"
  })
}

benchmark "cis_v120_6_2" {
  title         = "6.2 PostgreSQL Database"
  documentation = file("./cis_v120/docs/cis_v120_6_2.md")
  children = [
    control.cis_v120_6_2_1,
    control.cis_v120_6_2_2,
    control.cis_v120_6_2_3,
    control.cis_v120_6_2_4,
    control.cis_v120_6_2_5,
    control.cis_v120_6_2_6,
    control.cis_v120_6_2_7,
    control.cis_v120_6_2_8,
    control.cis_v120_6_2_9,
    control.cis_v120_6_2_10,
    control.cis_v120_6_2_11,
    control.cis_v120_6_2_12,
    control.cis_v120_6_2_13,
    control.cis_v120_6_2_14,
    control.cis_v120_6_2_15,
    control.cis_v120_6_2_16
  ]

  tags = merge(local.cis_v120_6_2_common_tags, {
    type    = "Benchmark"
    service = "GCP/SQL"
  })
}

control "cis_v120_6_2_1" {
  title         = "6.2.1 Ensure that the 'log_checkpoints' database flag for Cloud SQL PostgreSQL instance is set to 'on'"
  description   = "Ensure that the log_checkpoints database flag for the Cloud SQL PostgreSQL instance is set to on."
  documentation = file("./cis_v120/docs/cis_v120_6_2_1.md")
  sql           = query.sql_instance_postgresql_log_checkpoints_database_flag_on.sql

  tags = merge(local.cis_v120_6_2_common_tags, {
    cis_item_id = "6.2.1"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/SQL"
  })
}

control "cis_v120_6_2_2" {
  title         = "6.2.2 Ensure 'log_error_verbosity' database flag for Cloud SQL PostgreSQL instance is set to 'DEFAULT' or stricter"
  description   = "The log_error_verbosity flag controls the verbosity/details of messages logged. Valid values are: 'TERSE', 'DEFAULT', and 'VERBOSE'."
  documentation = file("./cis_v120/docs/cis_v120_6_2_2.md")
  sql           = query.manual_control.sql

  tags = merge(local.cis_v120_6_2_common_tags, {
    cis_item_id = "6.2.2"
    cis_level   = "2"
    cis_type    = "manual"
    service     = "GCP/SQL"
  })
}

control "cis_v120_6_2_3" {
  title         = "6.2.3 Ensure that the 'log_connections' database flag for Cloud SQL PostgreSQL instance is set to 'on'"
  description   = "Enabling the log_connections setting causes each attempted connection to the server to be logged, along with successful completion of client authentication. This parameter cannot be changed after the session starts."
  documentation = file("./cis_v120/docs/cis_v120_6_2_3.md")
  sql           = query.sql_instance_postgresql_log_connections_database_flag_on.sql

  tags = merge(local.cis_v120_6_2_common_tags, {
    cis_item_id = "6.2.3"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/SQL"
  })
}

control "cis_v120_6_2_4" {
  title         = "6.2.4 Ensure that the 'log_disconnections' database flag for Cloud SQL PostgreSQL instance is set to 'on'"
  description   = "Enabling the log_disconnections setting logs the end of each session, including the session duration."
  documentation = file("./cis_v120/docs/cis_v120_6_2_4.md")
  sql           = query.sql_instance_postgresql_log_disconnections_database_flag_on.sql

  tags = merge(local.cis_v120_6_2_common_tags, {
    cis_item_id = "6.2.4"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/SQL"
  })
}

control "cis_v120_6_2_5" {
  title         = "6.2.5 Ensure 'log_duration' database flag for Cloud SQL PostgreSQL instance is set to 'on'"
  description   = "Enabling the log_duration setting causes the duration of each completed statement to be logged. This does not logs the text of the query and thus behaves different from the log_min_duration_statement flag. This parameter cannot be changed after session start."
  documentation = file("./cis_v120/docs/cis_v120_6_2_5.md")
  sql           = query.sql_instance_postgresql_log_duration_database_flag_on.sql

  tags = merge(local.cis_v120_6_2_common_tags, {
    cis_item_id = "6.2.5"
    cis_level   = "1"
    cis_type    = "manual"
    service     = "GCP/SQL"
  })
}

control "cis_v120_6_2_6" {
  title         = "6.2.6 Ensure that the 'log_lock_waits' database flag for Cloud SQL PostgreSQL instance is set to 'on'"
  description   = "Enabling the log_lock_waits flag for a PostgreSQL instance creates a log for any session waits that take longer than the alloted deadlock_timeout time to acquire a lock."
  documentation = file("./cis_v120/docs/cis_v120_6_2_6.md")
  sql           = query.sql_instance_postgresql_log_lock_waits_database_flag_on.sql

  tags = merge(local.cis_v120_6_2_common_tags, {
    cis_item_id = "6.2.6"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/SQL"
  })
}

control "cis_v120_6_2_7" {
  title         = "6.2.7 Ensure 'log_statement' database flag for Cloud SQL PostgreSQL instance is set appropriately"
  description   = "The value of log_statement flag determined the SQL statements that are logged. Valid values are: 'none', 'ddl', 'mod', and 'all'."
  documentation = file("./cis_v120/docs/cis_v120_6_2_7.md")
  sql           = query.manual_control.sql

  tags = merge(local.cis_v120_6_2_common_tags, {
    cis_item_id = "6.2.7"
    cis_level   = "1"
    cis_type    = "manual"
    service     = "GCP/SQL"
  })
}

control "cis_v120_6_2_8" {
  title         = "6.2.8 Ensure 'log_hostname' database flag for Cloud SQL PostgreSQL instance is set appropriately"
  description   = "PostgreSQL logs only the IP address of the connecting hosts. The log_hostname flag controls the logging of hostnames in addition to the IP addresses logged. The performance hit is dependent on the configuration of the environment and the host name resolution setup. This parameter can only be set in the postgresql.conf file or on the server command line."
  documentation = file("./cis_v120/docs/cis_v120_6_2_8.md")
  sql           = query.sql_instance_postgresql_log_hostname_database_flag_configured.sql

  tags = merge(local.cis_v120_6_2_common_tags, {
    cis_item_id = "6.2.8"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/SQL"
  })
}

control "cis_v120_6_2_9" {
  title         = "6.2.9 Ensure 'log_parser_stats' database flag for Cloud SQL PostgreSQL instance is set to 'off'"
  description   = "The PostgreSQL planner/optimizer is responsible to parse and verify the syntax of each query received by the server. If the syntax is correct a parse tree is built up else an error is generated. The log_parser_stats flag controls the inclusion of parser performance statistics in the PostgreSQL logs for each query."
  documentation = file("./cis_v120/docs/cis_v120_6_2_9.md")
  sql           = query.sql_instance_postgresql_log_parser_stats_database_flag_off.sql

  tags = merge(local.cis_v120_6_2_common_tags, {
    cis_item_id = "6.2.9"
    cis_level   = "2"
    cis_type    = "automated"
    service     = "GCP/SQL"
  })
}

control "cis_v120_6_2_10" {
  title         = "6.2.10 Ensure 'log_planner_stats' database flag for Cloud SQL PostgreSQL instance is set to 'off'"
  description   = "The same SQL query can be executed in multiple ways and still produce different results. The PostgreSQL planner/optimizer is responsible to create an optimal execution plan for each query. The log_planner_stats flag controls the inclusion of PostgreSQL planner performance statistics in the PostgreSQL logs for each query."
  documentation = file("./cis_v120/docs/cis_v120_6_2_10.md")
  sql           = query.sql_instance_postgresql_log_planner_stats_database_flag_off.sql

  tags = merge(local.cis_v120_6_2_common_tags, {
    cis_item_id = "6.2.10"
    cis_level   = "2"
    cis_type    = "automated"
    service     = "GCP/SQL"
  })
}

control "cis_v120_6_2_11" {
  title         = "6.2.11 Ensure 'log_executor_stats' database flag for Cloud SQL PostgreSQL instance is set to 'off'"
  description   = "The PostgreSQL executor is responsible to execute the plan handed over by the PostgreSQL planner. The executor processes the plan recursively to extract the required set of rows. The log_executor_stats flag controls the inclusion of PostgreSQL executor performance statistics in the PostgreSQL logs for each query."
  documentation = file("./cis_v120/docs/cis_v120_6_2_11.md")
  sql           = query.sql_instance_postgresql_log_executor_stats_database_flag_off.sql

  tags = merge(local.cis_v120_6_2_common_tags, {
    cis_item_id = "6.2.11"
    cis_level   = "2"
    cis_type    = "automated"
    service     = "GCP/SQL"
  })
}

control "cis_v120_6_2_12" {
  title         = "6.2.12 Ensure 'log_statement_stats' database flag for Cloud SQL PostgreSQL instance is set to 'off'"
  description   = "The log_statement_stats flag controls the inclusion of end to end performance statistics of a SQL query in the PostgreSQL logs for each query. This cannot be enabled with other module statistics (log_parser_stats, log_planner_stats, log_executor_stats)."
  documentation = file("./cis_v120/docs/cis_v120_6_2_12.md")
  sql           = query.sql_instance_postgresql_log_statement_stats_database_flag_off.sql

  tags = merge(local.cis_v120_6_2_common_tags, {
    cis_item_id = "6.2.12"
    cis_level   = "2"
    cis_type    = "automated"
  })
}

control "cis_v120_6_2_13" {
  title         = "6.2.13 Ensure that the 'log_min_messages' database flag for Cloud SQL PostgreSQL instance is set appropriately"
  description   = "The log_min_messages flag defines the minimum message severity level that is considered as an error statement. Messages for error statements are logged with the SQL statement. Valid values include DEBUG5, DEBUG4, DEBUG3, DEBUG2, DEBUG1, INFO, NOTICE, WARNING, ERROR, LOG, FATAL, and PANIC. Each severity level includes the subsequent levels mentioned above."
  documentation = file("./cis_v120/docs/cis_v120_6_2_13.md")
  sql           = query.manual_control.sql

  tags = merge(local.cis_v120_6_2_common_tags, {
    cis_item_id = "6.2.13"
    cis_level   = "1"
    cis_type    = "manual"
  })
}

control "cis_v120_6_2_14" {
  title         = "6.2.14 Ensure 'log_min_error_statement' database flag for Cloud SQL PostgreSQL instance is set to 'Error' or stricter"
  description   = "The log_min_error_statement flag defines the minimum message severity level that are considered as an error statement. Messages for error statements are logged with the SQL statement. Valid values include DEBUG5, DEBUG4, DEBUG3, DEBUG2, DEBUG1, INFO, NOTICE, WARNING, ERROR, LOG, FATAL, and PANIC. Each severity level includes the subsequent levels mentioned above. Ensure a value of ERROR or stricter is set."
  documentation = file("./cis_v120/docs/cis_v120_6_2_14.md")
  sql           = query.sql_instance_postgresql_log_min_error_statement_database_flag_configured.sql

  tags = merge(local.cis_v120_6_2_common_tags, {
    cis_item_id = "6.2.14"
    cis_level   = "1"
    cis_type    = "automated"
  })
}

control "cis_v120_6_2_15" {
  title         = "6.2.15 Ensure that the 'log_temp_files' database flag for Cloud SQL PostgreSQL instance is set to '0'"
  description   = "PostgreSQL can create a temporary file for actions such as sorting, hashing and temporary query results when these operations exceed work_mem. The log_temp_files flag controls logging names and the file size when it is deleted. Configuring log_temp_files to 0 causes all temporary file information to be logged, while positive values log only files whose size is greater than or equal to the specified number of kilobytes. A value of -1 disables temporary file information logging."
  documentation = file("./cis_v120/docs/cis_v120_6_2_15.md")
  sql           = query.sql_instance_postgresql_log_temp_files_database_flag_0.sql

  tags = merge(local.cis_v120_6_2_common_tags, {
    cis_item_id = "6.2.15"
    cis_level   = "1"
    cis_type    = "automated"
  })
}

control "cis_v120_6_2_16" {
  title         = "6.2.16 Ensure that the 'log_min_duration_statement' database flag for Cloud SQL PostgreSQL instance is set to '-1' (disabled)"
  description   = "The log_min_duration_statement flag defines the minimum amount of execution time of a statement in milliseconds where the total duration of the statement is logged. Ensure that log_min_duration_statement is disabled, i.e., a value of -1 is set."
  documentation = file("./cis_v120/docs/cis_v120_6_2_16.md")
  sql           = query.sql_instance_postgresql_log_min_duration_statement_database_flag_disabled.sql

  tags = merge(local.cis_v120_6_2_common_tags, {
    cis_item_id = "6.2.16"
    cis_level   = "1"
    cis_type    = "automated"
  })
}

benchmark "cis_v120_6_3" {
  title         = "6.3 SQL Server"
  documentation = file("./cis_v120/docs/cis_v120_6_3.md")
  children = [
    control.cis_v120_6_3_1,
    control.cis_v120_6_3_2,
    control.cis_v120_6_3_3,
    control.cis_v120_6_3_4,
    control.cis_v120_6_3_5,
    control.cis_v120_6_3_6,
    control.cis_v120_6_3_7
  ]

  tags = merge(local.cis_v120_6_3_common_tags, {
    type    = "Benchmark"
    service = "GCP/SQL"
  })
}

control "cis_v120_6_3_1" {
  title         = "6.3.1 Ensure 'external scripts enabled' database flag for Cloud SQL SQL Server instance is set to 'off'"
  description   = "It is recommended to set external scripts enabled database flag for Cloud SQL SQL Server instance to off."
  documentation = file("./cis_v120/docs/cis_v120_6_3_1.md")
  sql           = query.sql_instance_sql_external_scripts_enabled_database_flag_off.sql

  tags = merge(local.cis_v120_6_3_common_tags, {
    cis_item_id = "6.3.1"
    cis_level   = "1"
    cis_type    = "automated"
  })
}

control "cis_v120_6_3_2" {
  title         = "6.3.2 Ensure that the 'cross db ownership chaining' database flag for Cloud SQL SQL Server instance is set to 'off'"
  description   = "It is recommended to set cross db ownership chaining database flag for Cloud SQL SQL Server instance to off."
  documentation = file("./cis_v120/docs/cis_v120_6_3_2.md")
  sql           = query.sql_instance_sql_cross_db_ownership_chaining_database_flag_off.sql

  tags = merge(local.cis_v120_6_3_common_tags, {
    cis_item_id = "6.3.2"
    cis_level   = "1"
    cis_type    = "automated"
  })
}

control "cis_v120_6_3_3" {
  title         = "6.3.3 Ensure 'user connections' database flag for Cloud SQL SQL Server instance is set as appropriate"
  description   = "It is recommended to set user connections database flag for Cloud SQL SQL Server instance according organization-defined value."
  documentation = file("./cis_v120/docs/cis_v120_6_3_3.md")
  sql           = query.sql_instance_sql_user_connections_database_flag_configured.sql

  tags = merge(local.cis_v120_6_3_common_tags, {
    cis_item_id = "6.3.3"
    cis_level   = "1"
    cis_type    = "automated"
  })
}

control "cis_v120_6_3_4" {
  title         = "6.3.4 Ensure 'user options' database flag for Cloud SQL SQL Server instance is not configured"
  description   = "It is recommended that, user options database flag for Cloud SQL SQL Server instance should not be configured."
  documentation = file("./cis_v120/docs/cis_v120_6_3_4.md")
  sql           = query.sql_instance_sql_user_options_database_flag_not_configured.sql

  tags = merge(local.cis_v120_6_3_common_tags, {
    cis_item_id = "6.3.4"
    cis_level   = "1"
    cis_type    = "automated"
  })
}

control "cis_v120_6_3_5" {
  title         = "6.3.5 Ensure 'remote access' database flag for Cloud SQL SQL Server instance is set to 'off'"
  description   = "It is recommended to set remote access database flag for Cloud SQL SQL Server instance to off."
  documentation = file("./cis_v120/docs/cis_v120_6_3_5.md")
  sql           = query.sql_instance_sql_remote_access_database_flag_off.sql

  tags = merge(local.cis_v120_6_3_common_tags, {
    cis_item_id = "6.3.5"
    cis_level   = "1"
    cis_type    = "automated"
  })
}

control "cis_v120_6_3_6" {
  title         = "6.3.6 Ensure '3625 (trace flag)' database flag for Cloud SQL SQL Server instance is set to 'off'"
  description   = "It is recommended to set 3625 (trace flag) database flag for Cloud SQL SQL Server instance to off."
  documentation = file("./cis_v120/docs/cis_v120_6_3_6.md")
  sql           = query.sql_instance_sql_3625_trace_database_flag_off.sql

  tags = merge(local.cis_v120_6_3_common_tags, {
    cis_item_id = "6.3.6"
    cis_level   = "1"
    cis_type    = "automated"
  })
}

control "cis_v120_6_3_7" {
  title         = "6.3.7 Ensure that the 'contained database authentication' database flag for Cloud SQL on the SQL Server instance is set to 'off'"
  description   = "It is recommended to set contained database authentication database flag for Cloud SQL on the SQL Server instance is set to off."
  documentation = file("./cis_v120/docs/cis_v120_6_3_7.md")
  sql           = query.sql_instance_sql_contained_database_authentication_database_flag_off.sql

  tags = merge(local.cis_v120_6_3_common_tags, {
    cis_item_id = "6.3.7"
    cis_level   = "1"
    cis_type    = "automated"
  })
}

control "cis_v120_6_4" {
  title         = "6.4 Ensure that the Cloud SQL database instance requires all incoming connections to use SSL"
  description   = "It is recommended to enforce all incoming connections to SQL database instance to use SSL."
  documentation = file("./cis_v120/docs/cis_v120_6_4.md")
  sql           = query.sql_instance_require_ssl_enabled.sql

  tags = merge(local.cis_v120_6_common_tags, {
    cis_item_id = "6.4"
    cis_level   = "1"
    cis_type    = "automated"
  })
}

control "cis_v120_6_5" {
  title         = "6.5 Ensure that Cloud SQL database instances are not open to the world"
  description   = "Database Server should accept connections only from trusted Network(s)/IP(s) and restrict access from the world."
  documentation = file("./cis_v120/docs/cis_v120_6_5.md")
  sql           = query.sql_instance_not_open_to_internet.sql

  tags = merge(local.cis_v120_6_common_tags, {
    cis_item_id = "6.5"
    cis_level   = "1"
    cis_type    = "automated"
  })
}

control "cis_v120_6_6" {
  title         = "6.6 Ensure that Cloud SQL database instances do not have public IPs"
  description   = "It is recommended to configure Second Generation Sql instance to use private IPs instead of public IPs."
  documentation = file("./cis_v120/docs/cis_v120_6_6.md")
  sql           = query.sql_instance_with_no_public_ips.sql

  tags = merge(local.cis_v120_6_common_tags, {
    cis_item_id = "6.6"
    cis_level   = "2"
    cis_type    = "automated"
  })
}

control "cis_v120_6_7" {
  title         = "6.7 Ensure that Cloud SQL database instances are configured with automated backups"
  description   = "It is recommended to have all SQL database instances set to enable automated backups."
  documentation = file("./cis_v120/docs/cis_v120_6_7.md")
  sql           = query.sql_instance_automated_backups_enabled.sql

  tags = merge(local.cis_v120_6_common_tags, {
    cis_item_id = "6.7"
    cis_level   = "1"
    cis_type    = "automated"
  })
}
