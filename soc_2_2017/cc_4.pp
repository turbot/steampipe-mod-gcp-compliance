locals {
  soc_2_2017_cc_4_common_tags = merge(local.soc_2_2017_common_tags, {
    soc_2_2017_section_id = "cc4"
  })
}

benchmark "soc_2_2017_cc_4" {
  title       = "CC4 Monitoring Activities"
  description = "The criteria relevant to how the entity (i) conducts ongoing and/or separate evaluations, and (ii) evaluates and communicates deficiencies."

  children = [
    benchmark.soc_2_2017_cc_4_1
  ]

  tags = local.soc_2_2017_cc_4_common_tags
}

benchmark "soc_2_2017_cc_4_1" {
  title       = "CC4.1  COSO Principle 16: The entity selects, develops, and performs ongoing and/or separate evaluations to ascertain whether the components of internal control are present and functioning"

  children = [
    benchmark.soc_2_2017_cc_4_1_1,
    benchmark.soc_2_2017_cc_4_1_2,
    benchmark.soc_2_2017_cc_4_1_4,
    benchmark.soc_2_2017_cc_4_1_3,
    benchmark.soc_2_2017_cc_4_1_5,
    benchmark.soc_2_2017_cc_4_1_6,
    benchmark.soc_2_2017_cc_4_1_7,
    benchmark.soc_2_2017_cc_4_1_8
  ]

  tags = merge(local.soc_2_2017_cc_4_common_tags, {
    soc_2_2017_item_id = "4.1"
  })
}

benchmark "soc_2_2017_cc_4_1_1" {
  title       = "CC4.1.1"
  description = "Entity's Senior Management assigns the role of Information Security Officer who is delegated to centrally-manage, coordinate, develop, implement and maintain an enterprise-wide cybersecurity and privacy program."

  children = [
    control.audit_logging_configured_for_all_service,
    control.compute_network_dns_logging_enabled
  ]

  tags = merge(local.soc_2_2017_cc_4_common_tags, {
    soc_2_2017_item_id = "4.1.1"
  })
}

benchmark "soc_2_2017_cc_4_1_2" {
  title       = "CC4.1.2"
  description = "Entity has set up mechanism to assign and manage asset ownership responsibilities and establish a common understanding of asset protection requirements."

  children = [
    control.audit_logging_configured_for_all_service,
    control.compute_network_dns_logging_enabled
  ]

  tags = merge(local.soc_2_2017_cc_4_common_tags, {
    soc_2_2017_item_id = "4.1.2"
  })
}

benchmark "soc_2_2017_cc_4_1_3" {
  title       = "CC4.1.3"
  description = "Entity uses Sprinto, a continuous monitoring system, to track and report the health of the information security program to the Information Security Officer and other stakeholders."

  children = [
    control.audit_logging_configured_for_all_service,
    control.compute_network_dns_logging_enabled
  ]

  tags = merge(local.soc_2_2017_cc_4_common_tags, {
    soc_2_2017_item_id = "4.1.3"
  })
}

benchmark "soc_2_2017_cc_4_1_4" {
  title       = "CC4.1.4"
  description = "Entity's Senior Management reviews and approves all company policies annually."

  children = [
    control.audit_logging_configured_for_all_service,
    control.compute_network_dns_logging_enabled
  ]

  tags = merge(local.soc_2_2017_cc_4_common_tags, {
    soc_2_2017_item_id = "4.1.4"
  })
}

benchmark "soc_2_2017_cc_4_1_5" {
  title       = "CC4.1.5"
  description = "Entity's Senior Management reviews and approves the state of the Information Security program including policies, standards and procedures, at planned intervals or if significant changes occur to ensure their continuing suitability, adequacy and effectiveness."

  children = [
    control.audit_logging_configured_for_all_service,
    control.compute_network_dns_logging_enabled
  ]

  tags = merge(local.soc_2_2017_cc_4_common_tags, {
    soc_2_2017_item_id = "4.1.5"
  })
}

benchmark "soc_2_2017_cc_4_1_6" {
  title       = "CC4.1.6"
  description = "Entity periodically updates and reviews the inventory of systems as a part of installations, removals and system updates."

  children = [
    control.audit_logging_configured_for_all_service,
    control.compute_network_dns_logging_enabled
  ]

  tags = merge(local.soc_2_2017_cc_4_common_tags, {
    soc_2_2017_item_id = "4.1.6"
  })
}

benchmark "soc_2_2017_cc_4_1_7" {
  title       = "CC4.1.7"
  description = "Entity's Senior Management reviews and approves the Organizational Chart for all employees annually."

  children = [
    control.audit_logging_configured_for_all_service,
    control.compute_network_dns_logging_enabled
  ]

  tags = merge(local.soc_2_2017_cc_4_common_tags, {
    soc_2_2017_item_id = "4.1.7"
  })
}

benchmark "soc_2_2017_cc_4_1_8" {
  title       = "CC4.1.8"
  description = "Entity's Senior Management reviews and approves the `Risk Assessment Report` annually."

  children = [
    control.audit_logging_configured_for_all_service,
    control.compute_network_dns_logging_enabled
  ]

  tags = merge(local.soc_2_2017_cc_4_common_tags, {
    soc_2_2017_item_id = "4.1.8"
  })
}