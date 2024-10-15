locals {
  cis_v300_6_common_tags = merge(local.cis_v300_common_tags, {
    cis_section_id = "6"
  })
}

locals {
  cis_v300_6_1_common_tags = merge(local.cis_v300_6_common_tags, {
    cis_section_id = "6.1"
  })
}

locals {
  cis_v300_6_2_common_tags = merge(local.cis_v300_6_common_tags, {
    cis_section_id = "6.2"
  })
}

locals {
  cis_v300_6_3_common_tags = merge(local.cis_v300_6_common_tags, {
    cis_section_id = "6.3"
  })
}

benchmark "cis_v300_6" {
  title         = "6 Cloud SQL Database Services"
  documentation = file("./cis_v300/docs/cis_v300_6.md")
  children = [
    benchmark.cis_v300_6_1,
    benchmark.cis_v300_6_2,
    benchmark.cis_v300_6_3,
    control.cis_v300_6_4,
    control.cis_v300_6_5,
    control.cis_v300_6_6,
    control.cis_v300_6_7
  ]

  tags = merge(local.cis_v300_6_common_tags, {
    type    = "Benchmark"
    service = "GCP/SQL"
  })
}

benchmark "cis_v300_6_1" {
  title         = "6.1 MySQL Database"
  documentation = file("./cis_v300/docs/cis_v300_6_1.md")
  children = [
    control.cis_v300_6_1_1,
    control.cis_v300_6_1_2,
    control.cis_v300_6_1_3
  ]

  tags = merge(local.cis_v300_6_1_common_tags, {
    type    = "Benchmark"
    service = "GCP/SQL"
  })
}

control "cis_v300_6_1_1" {
  title         = "6.1.1 Ensure That a MySQL Database Instance Does Not Allow Anyone To Connect With Administrative Privileges"
  description   = "It is recommended to set a password for the administrative user (root by default) to prevent unauthorized access to the SQL database instances. This recommendation is applicable only for MySQL Instances. PostgreSQL does not offer any setting for No Password from the cloud console."
  documentation = file("./cis_v300/docs/cis_v300_6_1_1.md")
  query         = query.manual_control

  tags = merge(local.cis_v300_6_1_common_tags, {
    cis_item_id = "6.1.1"
    cis_level   = "1"
    cis_type    = "manual"
    service     = "GCP/SQL"
  })
}

control "cis_v300_6_1_2" {
  title         = "6.1.2 Ensure 'Skip_show_database' Database Flag for Cloud SQL MySQL Instance Is Set to 'On'"
  description   = "It is recommended to set skip_show_database database flag for Cloud SQL Mysql instance to on."
  documentation = file("./cis_v300/docs/cis_v300_6_1_2.md")
  query         = query.sql_instance_mysql_skip_show_database_flag_on

  tags = merge(local.cis_v300_6_1_common_tags, {
    cis_item_id = "6.1.2"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/SQL"
  })
}

control "cis_v300_6_1_3" {
  title         = "6.1.3 Ensure That the 'Local_infile' Database Flag for a Cloud SQL MySQL Instance Is Set to 'Off'"
  description   = "It is recommended to set the local_infile database flag for a Cloud SQL MySQL instance to off."
  documentation = file("./cis_v300/docs/cis_v300_6_1_3.md")
  query         = query.sql_instance_mysql_local_infile_database_flag_off

  tags = merge(local.cis_v300_6_1_common_tags, {
    cis_item_id = "6.1.3"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/SQL"
  })
}

benchmark "cis_v300_6_2" {
  title         = "6.2 PostgreSQL Database"
  documentation = file("./cis_v300/docs/cis_v300_6_2.md")
  children = [
    control.cis_v300_6_2_1,
    control.cis_v300_6_2_2,
    control.cis_v300_6_2_3,
    control.cis_v300_6_2_4,
    control.cis_v300_6_2_5,
    control.cis_v300_6_2_6,
    control.cis_v300_6_2_7,
    control.cis_v300_6_2_8
  ]

  tags = merge(local.cis_v300_6_2_common_tags, {
    type    = "Benchmark"
    service = "GCP/SQL"
  })
}

control "cis_v300_6_2_1" {
  title         = "6.2.1 Ensure 'Log_error_verbosity' Database Flag for Cloud SQL PostgreSQL Instance Is Set to 'DEFAULT' or Stricter"
  description   = "The log_error_verbosity flag controls the verbosity/details of messages logged. Valid values are: 'TERSE', 'DEFAULT', and 'VERBOSE'."
  documentation = file("./cis_v300/docs/cis_v300_6_2_1.md")
  query         = query.sql_instance_postgresql_log_error_verbosity_database_flag_default_or_stricter

  tags = merge(local.cis_v300_6_2_common_tags, {
    cis_item_id = "6.2.1"
    cis_level   = "2"
    cis_type    = "automated"
    service     = "GCP/SQL"
  })
}

control "cis_v300_6_2_2" {
  title         = "6.2.2 Ensure That the 'Log_connections' Database Flag for Cloud SQL PostgreSQL Instance Is Set to 'On'"
  description   = "Enabling the log_connections setting causes each attempted connection to the server to be logged, along with successful completion of client authentication. This parameter cannot be changed after the session starts."
  documentation = file("./cis_v300/docs/cis_v300_6_2_2.md")
  query         = query.sql_instance_postgresql_log_connections_database_flag_on

  tags = merge(local.cis_v300_6_2_common_tags, {
    cis_item_id = "6.2.2"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/SQL"
  })
}

control "cis_v300_6_2_3" {
  title         = "6.2.3 Ensure That the 'Log_disconnections' Database Flag for Cloud SQL PostgreSQL Instance Is Set to 'On'"
  description   = "Enabling the log_disconnections setting logs the end of each session, including the session duration."
  documentation = file("./cis_v300/docs/cis_v300_6_2_3.md")
  query         = query.sql_instance_postgresql_log_disconnections_database_flag_on

  tags = merge(local.cis_v300_6_2_common_tags, {
    cis_item_id = "6.2.3"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/SQL"
  })
}

control "cis_v300_6_2_4" {
  title         = "6.2.4 Ensure 'Log_statement' Database Flag for Cloud SQL PostgreSQL Instance Is Set Appropriately"
  description   = "The value of log_statement flag determined the SQL statements that are logged. Valid values are: 'none', 'ddl', 'mod', and 'all'."
  documentation = file("./cis_v300/docs/cis_v300_6_2_4.md")
  query         = query.sql_instance_postgresql_log_statement_database_flag_ddl
  tags = merge(local.cis_v300_6_2_common_tags, {
    cis_item_id = "6.2.4"
    cis_level   = "2"
    cis_type    = "automated"
    service     = "GCP/SQL"
  })
}

control "cis_v300_6_2_5" {
  title         = "6.2.5 Ensure that the 'Log_min_messages' Flag for a Cloud SQL PostgreSQL Instance is set at minimum to 'Warning'"
  description   = "The log_min_messages flag defines the minimum message severity level that is considered as an error statement. Messages for error statements are logged with the SQL statement. Valid values include DEBUG5, DEBUG4, DEBUG3, DEBUG2, DEBUG1, INFO, NOTICE, WARNING, ERROR, LOG, FATAL, and PANIC. Each severity level includes the subsequent levels mentioned above."
  documentation = file("./cis_v300/docs/cis_v300_6_2_5.md")
  query         = query.sql_instance_postgresql_log_min_messages_database_flag_error
  tags = merge(local.cis_v300_6_2_common_tags, {
    cis_item_id = "6.2.5"
    cis_level   = "1"
    cis_type    = "automated"
  })
}

control "cis_v300_6_2_6" {
  title         = "6.2.6 Ensure 'Log_min_error_statement' Database Flag for Cloud SQL PostgreSQL Instance Is Set to 'Error' or Stricter"
  description   = "The log_min_error_statement flag defines the minimum message severity level that are considered as an error statement. Messages for error statements are logged with the SQL statement. Valid values include DEBUG5, DEBUG4, DEBUG3, DEBUG2, DEBUG1, INFO, NOTICE, WARNING, ERROR, LOG, FATAL, and PANIC. Each severity level includes the subsequent levels mentioned above. Ensure a value of ERROR or stricter is set."
  documentation = file("./cis_v300/docs/cis_v300_6_2_6.md")
  query         = query.sql_instance_postgresql_log_min_error_statement_database_flag_configured

  tags = merge(local.cis_v300_6_2_common_tags, {
    cis_item_id = "6.2.6"
    cis_level   = "1"
    cis_type    = "automated"
  })
}

control "cis_v300_6_2_7" {
  title         = "6.2.7 Ensure That the 'Log_min_duration_statement' Database Flag for Cloud SQL PostgreSQL Instance Is Set to '-1'"
  description   = "The log_min_duration_statement flag defines the minimum amount of execution time of a statement in milliseconds where the total duration of the statement is logged. Ensure that log_min_duration_statement is disabled, i.e., a value of -1 is set."
  documentation = file("./cis_v300/docs/cis_v300_6_2_7.md")
  query         = query.sql_instance_postgresql_log_min_duration_statement_database_flag_disabled

  tags = merge(local.cis_v300_6_2_common_tags, {
    cis_item_id = "6.2.7"
    cis_level   = "1"
    cis_type    = "automated"
  })
}

control "cis_v300_6_2_8" {
  title         = "6.2.8 Ensure That 'cloudsql.enable_pgaudit' Database Flag for each Cloud Sql Postgresql Instance Is Set to 'on' For Centralized Logging"
  description   = "Ensure cloudsql.enable_pgaudit database flag for Cloud SQL PostgreSQL instance is set to on to allow for centralized logging."
  documentation = file("./cis_v300/docs/cis_v300_6_2_8.md")
  query         = query.sql_instance_postgresql_cloudsql_pgaudit_database_flag_enabled

  tags = merge(local.cis_v300_6_2_common_tags, {
    cis_item_id = "6.2.8"
    cis_level   = "1"
    cis_type    = "automated"
  })
}

benchmark "cis_v300_6_3" {
  title         = "6.3 SQL Server"
  documentation = file("./cis_v300/docs/cis_v300_6_3.md")
  children = [
    control.cis_v300_6_3_1,
    control.cis_v300_6_3_2,
    control.cis_v300_6_3_3,
    control.cis_v300_6_3_4,
    control.cis_v300_6_3_5,
    control.cis_v300_6_3_6,
    control.cis_v300_6_3_7
  ]

  tags = merge(local.cis_v300_6_3_common_tags, {
    type    = "Benchmark"
    service = "GCP/SQL"
  })
}

control "cis_v300_6_3_1" {
  title         = "6.3.1 Ensure 'external scripts enabled' database flag for Cloud SQL SQL Server instance is set to 'off"
  description   = "It is recommended to set external scripts enabled database flag for Cloud SQL SQL Server instance to off."
  documentation = file("./cis_v300/docs/cis_v300_6_3_1.md")
  query         = query.sql_instance_sql_external_scripts_enabled_database_flag_off

  tags = merge(local.cis_v300_6_3_common_tags, {
    cis_item_id = "6.3.1"
    cis_level   = "1"
    cis_type    = "automated"
  })
}

control "cis_v300_6_3_2" {
  title         = "6.3.2 Ensure that the 'cross db ownership chaining' database flag for Cloud SQL SQL Server instance is set to 'off'"
  description   = "It is recommended to set cross db ownership chaining database flag for Cloud SQL SQL Server instance to off."
  documentation = file("./cis_v300/docs/cis_v300_6_3_2.md")
  query         = query.sql_instance_sql_cross_db_ownership_chaining_database_flag_off

  tags = merge(local.cis_v300_6_3_common_tags, {
    cis_item_id = "6.3.2"
    cis_level   = "1"
    cis_type    = "automated"
  })
}

control "cis_v300_6_3_3" {
  title         = "6.3.3 Ensure 'user Connections' Database Flag for Cloud Sql Sql Server Instance Is Set to a Non-limiting Value"
  description   = "It is recommended to set user connections database flag for Cloud SQL SQL Server instance according organization-defined value."
  documentation = file("./cis_v300/docs/cis_v300_6_3_3.md")
  query         = query.sql_instance_sql_user_connections_database_flag_configured

  tags = merge(local.cis_v300_6_3_common_tags, {
    cis_item_id = "6.3.3"
    cis_level   = "1"
    cis_type    = "automated"
  })
}

control "cis_v300_6_3_4" {
  title         = "6.3.4 Ensure 'user options' database flag for Cloud SQL SQL Server instance is not configured"
  description   = "It is recommended that, user options database flag for Cloud SQL SQL Server instance should not be configured."
  documentation = file("./cis_v300/docs/cis_v300_6_3_4.md")
  query         = query.sql_instance_sql_user_options_database_flag_not_configured

  tags = merge(local.cis_v300_6_3_common_tags, {
    cis_item_id = "6.3.4"
    cis_level   = "1"
    cis_type    = "automated"
  })
}

control "cis_v300_6_3_5" {
  title         = "6.3.5 Ensure 'remote access' database flag for Cloud SQL SQL Server instance is set to 'off'"
  description   = "It is recommended to set remote access database flag for Cloud SQL SQL Server instance to off."
  documentation = file("./cis_v300/docs/cis_v300_6_3_5.md")
  query         = query.sql_instance_sql_remote_access_database_flag_off

  tags = merge(local.cis_v300_6_3_common_tags, {
    cis_item_id = "6.3.5"
    cis_level   = "1"
    cis_type    = "automated"
  })
}

control "cis_v300_6_3_6" {
  title         = "6.3.6 Ensure '3625 (trace flag)' database flag for all Cloud SQL Server instances is set to 'on'"
  description   = "It is recommended to set 3625 (trace flag) database flag for Cloud SQL SQL Server instance to on."
  documentation = file("./cis_v300/docs/cis_v300_6_3_6.md")
  query         = query.sql_instance_sql_3625_trace_database_flag_on

  tags = merge(local.cis_v300_6_3_common_tags, {
    cis_item_id = "6.3.6"
    cis_level   = "1"
    cis_type    = "automated"
  })
}

control "cis_v300_6_3_7" {
  title         = "6.3.7 Ensure that the 'contained database authentication' database flag for Cloud SQL on the SQL Server instance is not set to 'on'"
  description   = "It is recommended not to set contained database authentication database flag for Cloud SQL on the SQL Server instance to on."
  documentation = file("./cis_v300/docs/cis_v300_6_3_7.md")
  query         = query.sql_instance_sql_contained_database_authentication_database_flag_off

  tags = merge(local.cis_v300_6_3_common_tags, {
    cis_item_id = "6.3.7"
    cis_level   = "1"
    cis_type    = "automated"
  })
}

control "cis_v300_6_4" {
  title         = "6.4 Ensure That the Cloud SQL Database Instance Requires All Incoming Connections To Use SSL"
  description   = "It is recommended to enforce all incoming connections to SQL database instance to use SSL."
  documentation = file("./cis_v300/docs/cis_v300_6_4.md")
  query         = query.sql_instance_require_ssl_enabled

  tags = merge(local.cis_v300_6_common_tags, {
    cis_item_id = "6.4"
    cis_level   = "1"
    cis_type    = "automated"
  })
}

control "cis_v300_6_5" {
  title         = "6.5 Ensure That Cloud SQL Database Instances Do Not Implicitly Whitelist All Public IP Addresses ("
  description   = "Database Server should accept connections only from trusted Network(s)/IP(s) and restrict access from public IP addresses."
  documentation = file("./cis_v300/docs/cis_v300_6_5.md")
  query         = query.sql_instance_not_open_to_internet

  tags = merge(local.cis_v300_6_common_tags, {
    cis_item_id = "6.5"
    cis_level   = "1"
    cis_type    = "automated"
  })
}

control "cis_v300_6_6" {
  title         = "6.6 Ensure That Cloud SQL Database Instances Do Not Have Public IPs"
  description   = "It is recommended to configure Second Generation Sql instance to use private IPs instead of public IPs."
  documentation = file("./cis_v300/docs/cis_v300_6_6.md")
  query         = query.sql_instance_with_no_public_ips

  tags = merge(local.cis_v300_6_common_tags, {
    cis_item_id = "6.6"
    cis_level   = "2"
    cis_type    = "automated"
  })
}

control "cis_v300_6_7" {
  title         = "6.7 Ensure That Cloud SQL Database Instances Are Configured With Automated Backups"
  description   = "It is recommended to have all SQL database instances set to enable automated backups."
  documentation = file("./cis_v300/docs/cis_v300_6_7.md")
  query         = query.sql_instance_automated_backups_enabled

  tags = merge(local.cis_v300_6_common_tags, {
    cis_item_id = "6.7"
    cis_level   = "1"
    cis_type    = "automated"
  })
}
