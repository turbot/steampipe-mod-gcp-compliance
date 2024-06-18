locals {
  policy_bundle_alloydb_common_tags = merge(local.gcp_compliance_common_tags, {
    service = "GCP/AlloyDB"
  })
}

control "alloydb_instance_log_error_verbosity_database_flag_default_or_stricter" {
  title       = "Ensure 'log_error_verbosity' database flag for Alloy DB instance is set to 'DEFAULT' or stricter"
  description = "The log_error_verbosity flag controls the verbosity/details of messages logged. Valid values are: 'TERSE', 'DEFAULT', and 'VERBOSE'."
  query       = query.alloydb_instance_log_error_verbosity_database_flag_default_or_stricter

  tags = merge(local.policy_bundle_alloydb_common_tags, {
    nist_800_53_rev_5 = "true"
  })
}

control "alloydb_instance_log_min_error_statement_database_flag_configured" {
  title       = "Ensure 'log_min_error_statement' database flag for Alloy DB instance is set to 'Error' or stricter"
  description = "The log_min_error_statement flag defines the minimum message severity level that are considered as an error statement. Messages for error statements are logged with the SQL statement. Valid values include DEBUG5, DEBUG4, DEBUG3, DEBUG2, DEBUG1, INFO, NOTICE, WARNING, ERROR, LOG, FATAL, and PANIC. Each severity level includes the subsequent levels mentioned above. Ensure a value of ERROR or stricter is set."
  query       = query.alloydb_instance_log_min_error_statement_database_flag_configured

  tags = merge(local.policy_bundle_alloydb_common_tags, {
    nist_800_53_rev_5 = "true"
  })
}

control "alloydb_instance_log_min_messages_database_flag_error" {
  title       = "Ensure that the 'Log_min_messages' Flag for a Alloy DB Instance is set at minimum to 'Warning'"
  description = "The log_min_messages flag defines the minimum message severity level that is considered as an error statement. Messages for error statements are logged with the SQL statement. Valid values include DEBUG5, DEBUG4, DEBUG3, DEBUG2, DEBUG1, INFO, NOTICE, WARNING, ERROR, LOG, FATAL, and PANIC. Each severity level includes the subsequent levels mentioned above."
  query       = query.alloydb_instance_log_min_messages_database_flag_error

  tags = merge(local.policy_bundle_alloydb_common_tags, {
    nist_800_53_rev_5 = "true"
  })
}

query "alloydb_instance_log_error_verbosity_database_flag_default_or_stricter" {
  sql = <<-EOQ
    select
      self_link as resource,
      case
        when database_flags @> '{"log_error_verbosity":"default"}' or database_flags @> '{"log_error_verbosity":"verbose"}' then 'ok'
        else 'alarm'
      end as status,
      case
        when database_flags @> '{"log_error_verbosity":"default"}' then title || ' log_error_verbosity database flag set to DEFAULT.'
        when database_flags @> '{"log_error_verbosity":"verbose"}' then title || ' log_error_verbosity database flag set to VERBOSE.'
        when database_flags @> '{"log_error_verbosity":"terse"}' then title || ' log_error_verbosity database flag set to TERSE.'
        else title || ' log_error_verbosity database flag not set.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_alloydb_instance;
  EOQ
}

query "alloydb_instance_log_min_error_statement_database_flag_configured" {
  sql = <<-EOQ
select
      self_link resource,
      case
        when database_flags is not null and database_flags ? 'log_min_error_statement' then 'ok'
        else 'alarm'
      end as status,
      case
        when database_flags is not null and database_flags ? 'log_min_error_statement'
          then title || ' ''log_min_error_statement'' database flag set.'
        else title || ' ''log_min_error_statement'' database flag not set.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_alloydb_instance;
  EOQ
}

query "alloydb_instance_log_min_messages_database_flag_error" {
  sql = <<-EOQ
    select
      self_link as resource,
      case
        when database_flags is null or not (database_flags ? 'log_min_messages') then 'alarm'
        when database_flags @> '{"log_min_messages":"error"}' or database_flags @> '{"log_min_messages":"warning"}' then 'ok'
        else 'alarm'
      end as status,
      case
        when database_flags is null or not (database_flags ? 'log_min_messages') then title || ' log_min_messages database flag not set.'
        when database_flags @> '{"log_min_messages":"error"}' then title || ' log_min_messages database flag set to ERROR.'
        when database_flags @> '{"log_min_messages":"warning"}' then title || ' log_min_messages database flag set to WARNING.'
        else title || ' log_min_messages database flag not set at minimum to WARNING.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_alloydb_instance;
  EOQ
}
