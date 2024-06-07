benchmark "nist_800_53_rev_5_sa" {
  title       = "System and Services Acquisition (SA)"
  description = "The SA control family correlates with controls that protect allocated resources and an organization’s system development life cycle. This includes information system documentation controls, development configuration management controls, and developer security testing and evaluation controls."
  children = [
    benchmark.nist_800_53_rev_5_sa_3,
    benchmark.nist_800_53_rev_5_sa_8,
    benchmark.nist_800_53_rev_5_sa_10

  ]

  tags = local.nist_800_53_rev_5_common_tags
}

benchmark "nist_800_53_rev_5_sa_3" {
  title       = "System Development Life Cycle (SA-3)"
  description = "Manages the information system using Assignment: organization-defined system development life cycle that incorporates information security considerations; defines and documents information security roles and responsibilities throughout the system development life cycle; identifies individuals having information security roles and responsibilities; and integrates the organizational information security risk management process into system development life cycle activities."
  children = [
    control.sql_instance_sql_3625_trace_database_flag_on,
    control.sql_instance_sql_user_connections_database_flag_configured,
    control.sql_instance_sql_user_options_database_flag_not_configured
  ]

  tags = local.nist_800_53_rev_5_common_tags
}

benchmark "nist_800_53_rev_5_sa_8" {
  title       = "Security Engineering Principles (SA-8)"
  description = "The organization applies information system security engineering principles in the specification, design, development, implementation, and modification of the information system."
  children = [
    control.iam_api_key_age_90,
    control.iam_api_key_restricts_apis,
    control.project_no_api_key,
    control.sql_instance_sql_3625_trace_database_flag_on,
    control.sql_instance_sql_user_connections_database_flag_configured,
    control.sql_instance_sql_user_options_database_flag_not_configured
  ]

  tags = local.nist_800_53_rev_5_common_tags
}

benchmark "nist_800_53_rev_5_sa_10" {
  title       = "Developer Configuration Management (SA-10)"
  description = "The organization requires the developer of the information system, system component, or information system service to: a. Perform configuration management during system, component, or service [Selection (one or more): design; development; implementation; operation]; b. Document, manage, and control the integrity of changes to [Assignment: organization-defined configuration items under configuration management]; c. Implement only organization-approved changes to the system, component, or service; d. Document approved changes to the system, component, or service and the potential security impacts of such changes; and e. Track security flaws and flaw resolution within the system, component, or service and report findings to [Assignment: organization-defined personnel]."
  children = [
    control.sql_instance_sql_3625_trace_database_flag_on,
    control.sql_instance_sql_user_connections_database_flag_configured,
    control.sql_instance_sql_user_options_database_flag_not_configured
  ]

  tags = local.nist_800_53_rev_5_common_tags
}