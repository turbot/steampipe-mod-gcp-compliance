benchmark "nist_800_53_rev_5_cm" {
  title       = "Configuration Management (CM)"
  description = "CM controls are specific to an organization’s configuration management policies. This includes a baseline configuration to operate as the basis for future builds or changes to information systems. Additionally, this includes information system component inventories and a security impact analysis control."
  children = [
    benchmark.nist_800_53_rev_5_cm_1,
    benchmark.nist_800_53_rev_5_cm_2,
    benchmark.nist_800_53_rev_5_cm_6,
    benchmark.nist_800_53_rev_5_cm_7,
    benchmark.nist_800_53_rev_5_cm_8,
    benchmark.nist_800_53_rev_5_cm_9
  ]

  tags = local.nist_800_53_rev_5_common_tags
}

benchmark "nist_800_53_rev_5_cm_1" {
  title       = "Configuration Management Policy and Procedures (CM-1)"
  description = "TDevelops, documents, and disseminates to Assignment: organization-defined personnel or roles: a configuration management policy that addresses purpose, scope, roles, responsibilities, management commitment, coordination among organizational entities, and compliance; and Procedures to facilitate the implementation of the configuration management policy and associated configuration management controls; and reviews and updates the current: configuration management policy Assignment: organization-defined frequency; and configuration management procedures Assignment: organization-defined frequency."
  children = [
    control.sql_instance_sql_3625_trace_database_flag_on,
    control.sql_instance_sql_user_connections_database_flag_configured,
    control.sql_instance_sql_user_options_database_flag_not_configured
  ]

  tags = local.nist_800_53_rev_5_common_tags
}

benchmark "nist_800_53_rev_5_cm_2" {
  title       = "Baseline Configuration (CM-2)"
  description = "The organization develops, documents, and maintains under configuration control, a current baseline configuration of the information system."
  children = [
    control.compute_network_contains_no_default_network,
    control.compute_network_contains_no_legacy_network,
    control.dns_managed_zone_dnssec_enabled,
    control.dnssec_prevent_rsasha1_ksk,
    control.sql_instance_sql_3625_trace_database_flag_on,
    control.sql_instance_sql_user_connections_database_flag_configured,
    control.sql_instance_sql_user_options_database_flag_not_configured
  ]

  tags = local.nist_800_53_rev_5_common_tags
}

benchmark "nist_800_53_rev_5_cm_6" {
  title       = "Configuration Settings (CM-6)"
  description = "The organization: (i) establishes mandatory configuration settings for information technology products employed within the information system; (ii) configures the security settings of information technology products to the most restrictive mode consistent with operational requirements; (iii) documents the configuration settings; and (iv) enforces the configuration settings in all components of the information system."
  children = [
    control.compute_instance_serial_port_connection_disabled,
    control.compute_network_contains_no_default_network,
    control.compute_network_contains_no_legacy_network,
    control.dns_managed_zone_dnssec_enabled,
    control.dnssec_prevent_rsasha1_ksk,
    control.sql_instance_mysql_local_infile_database_flag_off,
    control.sql_instance_sql_3625_trace_database_flag_on,
    control.sql_instance_sql_remote_access_database_flag_off,
    control.sql_instance_sql_user_connections_database_flag_configured,
    control.sql_instance_sql_user_options_database_flag_not_configured
  ]

  tags = local.nist_800_53_rev_5_common_tags
}

benchmark "nist_800_53_rev_5_cm_7" {
  title       = "Least Functionality (CM-7)"
  description = "The organization configures the information system to provide only essential capabilities and prohibits or restricts the use of the functions, ports, protocols, and/or services."
  children = [
    control.compute_instance_serial_port_connection_disabled,
    control.compute_network_contains_no_default_network,
    control.compute_network_contains_no_legacy_network,
    control.dns_managed_zone_dnssec_enabled,
    control.dnssec_prevent_rsasha1_ksk,
    control.sql_instance_mysql_local_infile_database_flag_off,
    control.sql_instance_sql_3625_trace_database_flag_on,
    control.sql_instance_sql_external_scripts_enabled_database_flag_off,
    control.sql_instance_sql_remote_access_database_flag_off,
    control.sql_instance_sql_user_connections_database_flag_configured,
    control.sql_instance_sql_user_options_database_flag_not_configured
  ]

  tags = local.nist_800_53_rev_5_common_tags
}

benchmark "nist_800_53_rev_5_cm_8" {
  title       = "System Component Inventory (CM-8)"
  description = "The organization develops and documents an inventory of information system components that accurately reflects the current information system, includes all components within the authorization boundary of the information system, is at the level of granularity deemed necessary for tracking and reporting and reviews and updates the information system component inventory."
  children = [
    control.project_service_cloudasset_api_enabled
  ]

  tags = local.nist_800_53_rev_5_common_tags
}

benchmark "nist_800_53_rev_5_cm_9" {
  title       = "Configuration Management Plan (CM-9)"
  description = "Develop, document, and implement a configuration management plan for the system that: a. Addresses roles, responsibilities, and configuration management processes and procedures; b. Establishes a process for identifying configuration items throughout the system development life cycle and for managing the configuration of the configuration items; c. Defines the configuration items for the system and places the configuration items under configuration management; d. Is reviewed and approved by [Assignment: organization-defined personnel or roles]; and e. Protects the configuration management plan from unauthorized disclosure and modification."
  children = [
    control.compute_network_contains_no_default_network,
    control.compute_network_contains_no_legacy_network,
    control.dns_managed_zone_dnssec_enabled,
    control.dnssec_prevent_rsasha1_ksk,
    control.sql_instance_sql_3625_trace_database_flag_on,
    control.sql_instance_sql_user_connections_database_flag_configured,
    control.sql_instance_sql_user_options_database_flag_not_configured
  ]

  tags = local.nist_800_53_rev_5_common_tags
}