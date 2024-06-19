locals {
  all_controls_alloydb_common_tags = merge(local.all_controls_common_tags, {
    service = "GCP/AlloyDB"
  })
}

benchmark "all_controls_alloydb" {
  title       = "AlloyDB"
  description = "This section contains recommendations for configuring Alloy DB resources."
  children = [
    control.alloydb_instance_log_error_verbosity_database_flag_default_or_stricter,
    control.alloydb_instance_log_min_error_statement_database_flag_configured,
    control.alloydb_instance_log_min_messages_database_flag_error
  ]

  tags = merge(local.all_controls_alloydb_common_tags, {
    type = "Benchmark"
  })
}
