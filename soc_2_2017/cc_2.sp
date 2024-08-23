locals {
  soc_2_2017_cc_2_common_tags = merge(local.soc_2_2017_common_tags, {
    soc_2_2017_section_id = "cc2"
  })
}

benchmark "soc_2_2017_cc_2" {
  title       = "CC2 Communication and Information"
  description = "The criteria relevant to how the entity (i) uses relevant information, (ii) communicates internally, and (iii) communicates externally."

  children = [
    benchmark.soc_2_2017_cc_2_3
  ]

  tags = local.soc_2_2017_cc_2_common_tags
}

benchmark "soc_2_2017_cc_2_3" {
  title       = "CC2.3 COSO Principle 15: The entity communicates with external parties regarding matters affecting the functioning of internal control"

  children = [
    benchmark.soc_2_2017_cc_2_3_1
  ]

  tags = merge(local.soc_2_2017_cc_2_common_tags, {
    soc_2_2017_item_id = "2.3"
  })
}

benchmark "soc_2_2017_cc_2_3_1" {
  title       = "CC2.3.1"

  children = [
    control.organization_essential_contacts_configured
  ]

  tags = merge(local.soc_2_2017_cc_2_common_tags, {
    soc_2_2017_item_id = "2.3.1"
  })
}