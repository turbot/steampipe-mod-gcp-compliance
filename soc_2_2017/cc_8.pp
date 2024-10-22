locals {
  soc_2_2017_cc_8_common_tags = merge(local.soc_2_2017_common_tags, {
    soc_2_2017_section_id = "cc8"
  })
}

benchmark "soc_2_2017_cc_8" {
  title       = "CC8 Change Management"
  description = "The criteria relevant to how an entity (i) identifies the need for changes, (ii) makes the changes using a controlled change management process, and (iii) prevents unauthorized changes from being made."

  children = [
    benchmark.soc_2_2017_cc_8_1
  ]

  tags = local.soc_2_2017_cc_8_common_tags
}

benchmark "soc_2_2017_cc_8_1" {
  title       = "CC8.1 The entity authorizes, designs, develops, or acquires, configures, documents, tests, approves, and implements changes to infrastructure, data, software, and procedures to meet its objectives"

  children = [
    benchmark.soc_2_2017_cc_8_1_1,
    benchmark.soc_2_2017_cc_8_1_2,
    benchmark.soc_2_2017_cc_8_1_3,
    benchmark.soc_2_2017_cc_8_1_4,
    benchmark.soc_2_2017_cc_8_1_5,
    benchmark.soc_2_2017_cc_8_1_6,
    benchmark.soc_2_2017_cc_8_1_7,
    benchmark.soc_2_2017_cc_8_1_8,
    benchmark.soc_2_2017_cc_8_1_9,
    benchmark.soc_2_2017_cc_8_1_10,
    benchmark.soc_2_2017_cc_8_1_11,
    benchmark.soc_2_2017_cc_8_1_12,
    benchmark.soc_2_2017_cc_8_1_13,
    benchmark.soc_2_2017_cc_8_1_14,
    benchmark.soc_2_2017_cc_8_1_15
  ]

  tags = merge(local.soc_2_2017_cc_8_common_tags, {
    soc_2_2017_item_id = "8.1"
  })
}

benchmark "soc_2_2017_cc_8_1_1" {
  title       = "CC8.1.1"

  children = [
    control.sql_instance_sql_3625_trace_database_flag_off,
    control.sql_instance_sql_user_connections_database_flag_configured,
    control.sql_instance_sql_user_options_database_flag_not_configured
  ]

  tags = merge(local.soc_2_2017_cc_8_common_tags, {
    soc_2_2017_item_id = "8.1.1"
  })
}

benchmark "soc_2_2017_cc_8_1_2" {
  title       = "CC8.1.2"

  children = [
    control.sql_instance_sql_3625_trace_database_flag_off,
    control.sql_instance_sql_user_connections_database_flag_configured,
    control.sql_instance_sql_user_options_database_flag_not_configured
  ]

  tags = merge(local.soc_2_2017_cc_8_common_tags, {
    soc_2_2017_item_id = "8.1.2"
  })
}

benchmark "soc_2_2017_cc_8_1_3" {
  title       = "CC8.1.3"

  children = [
    control.sql_instance_sql_3625_trace_database_flag_off,
    control.sql_instance_sql_user_connections_database_flag_configured,
    control.sql_instance_sql_user_options_database_flag_not_configured
  ]

  tags = merge(local.soc_2_2017_cc_8_common_tags, {
    soc_2_2017_item_id = "8.1.3"
  })
}

benchmark "soc_2_2017_cc_8_1_4" {
  title       = "CC8.1.4"

  children = [
    control.sql_instance_sql_3625_trace_database_flag_off,
    control.sql_instance_sql_user_connections_database_flag_configured,
    control.sql_instance_sql_user_options_database_flag_not_configured
  ]

  tags = merge(local.soc_2_2017_cc_8_common_tags, {
    soc_2_2017_item_id = "8.1.4"
  })
}

benchmark "soc_2_2017_cc_8_1_5" {
  title       = "CC8.1.5"

  children = [
    control.sql_instance_sql_3625_trace_database_flag_off,
    control.sql_instance_sql_user_connections_database_flag_configured,
    control.sql_instance_sql_user_options_database_flag_not_configured
  ]

  tags = merge(local.soc_2_2017_cc_8_common_tags, {
    soc_2_2017_item_id = "8.1.5"
  })
}

benchmark "soc_2_2017_cc_8_1_6" {
  title       = "CC8.1.6"

  children = [
    control.sql_instance_sql_3625_trace_database_flag_off,
    control.sql_instance_sql_user_connections_database_flag_configured,
    control.sql_instance_sql_user_options_database_flag_not_configured
  ]

  tags = merge(local.soc_2_2017_cc_8_common_tags, {
    soc_2_2017_item_id = "8.1.6"
  })
}

benchmark "soc_2_2017_cc_8_1_7" {
  title       = "CC8.1.7"

  children = [
    control.sql_instance_sql_3625_trace_database_flag_off,
    control.sql_instance_sql_user_connections_database_flag_configured,
    control.sql_instance_sql_user_options_database_flag_not_configured
  ]

  tags = merge(local.soc_2_2017_cc_8_common_tags, {
    soc_2_2017_item_id = "8.1.7"
  })
}

benchmark "soc_2_2017_cc_8_1_8" {
  title       = "CC8.1.8"

  children = [
    control.sql_instance_sql_3625_trace_database_flag_off,
    control.sql_instance_sql_user_connections_database_flag_configured,
    control.sql_instance_sql_user_options_database_flag_not_configured
  ]

  tags = merge(local.soc_2_2017_cc_8_common_tags, {
    soc_2_2017_item_id = "8.1.8"
  })
}

benchmark "soc_2_2017_cc_8_1_9" {
  title       = "CC8.1.9"

  children = [
    control.sql_instance_sql_3625_trace_database_flag_off,
    control.sql_instance_sql_user_options_database_flag_not_configured,
    control.sql_instance_sql_user_connections_database_flag_configured
  ]

  tags = merge(local.soc_2_2017_cc_8_common_tags, {
    soc_2_2017_item_id = "8.1.9"
  })
}

benchmark "soc_2_2017_cc_8_1_10" {
  title       = "CC8.1.10"

  children = [
    control.sql_instance_sql_3625_trace_database_flag_off,
    control.sql_instance_sql_user_connections_database_flag_configured,
    control.sql_instance_sql_user_options_database_flag_not_configured
  ]

  tags = merge(local.soc_2_2017_cc_8_common_tags, {
    soc_2_2017_item_id = "8.1.10"
  })
}

benchmark "soc_2_2017_cc_8_1_11" {
  title       = "CC8.1.11"

  children = [
    control.sql_instance_sql_3625_trace_database_flag_off,
    control.sql_instance_sql_user_connections_database_flag_configured,
    control.sql_instance_sql_user_options_database_flag_not_configured
  ]

  tags = merge(local.soc_2_2017_cc_8_common_tags, {
    soc_2_2017_item_id = "8.1.11"
  })
}

benchmark "soc_2_2017_cc_8_1_12" {
  title       = "CC8.1.12"

  children = [
    control.sql_instance_sql_3625_trace_database_flag_off,
    control.sql_instance_sql_user_connections_database_flag_configured,
    control.sql_instance_sql_user_options_database_flag_not_configured
  ]

  tags = merge(local.soc_2_2017_cc_8_common_tags, {
    soc_2_2017_item_id = "8.1.12"
  })
}

benchmark "soc_2_2017_cc_8_1_13" {
  title       = "CC8.1.13"

  children = [
    control.sql_instance_sql_3625_trace_database_flag_off,
    control.sql_instance_sql_user_connections_database_flag_configured,
    control.sql_instance_sql_user_options_database_flag_not_configured
  ]

  tags = merge(local.soc_2_2017_cc_8_common_tags, {
    soc_2_2017_item_id = "8.1.13"
  })
}

benchmark "soc_2_2017_cc_8_1_14" {
  title       = "CC8.1.14"

  children = [
    control.sql_instance_sql_3625_trace_database_flag_off,
    control.sql_instance_sql_user_connections_database_flag_configured,
    control.sql_instance_sql_user_options_database_flag_not_configured
  ]

  tags = merge(local.soc_2_2017_cc_8_common_tags, {
    soc_2_2017_item_id = "8.1.14"
  })
}

benchmark "soc_2_2017_cc_8_1_15" {
  title       = "CC8.1.15"

  children = [
    control.sql_instance_sql_3625_trace_database_flag_off,
    control.sql_instance_sql_user_connections_database_flag_configured,
    control.sql_instance_sql_user_options_database_flag_not_configured
  ]

  tags = merge(local.soc_2_2017_cc_8_common_tags, {
    soc_2_2017_item_id = "8.1.15"
  })
}