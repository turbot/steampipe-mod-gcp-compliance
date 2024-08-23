locals {
  soc_2_2017_cc_3_common_tags = merge(local.soc_2_2017_common_tags, {
    soc_2_2017_section_id = "cc3"
  })
}

benchmark "soc_2_2017_cc_3" {
  title       = "CC3 Risk Assessment"
  description = "The criteria relevant to how the entity (i) specifies suitable objectives, (ii) identifies and analyzes risk, and (iii) assess fraud risk."

  children = [
    benchmark.soc_2_2017_cc_3_2
  ]

  tags = local.soc_2_2017_cc_3_common_tags
}

benchmark "soc_2_2017_cc_3_2" {
  title       = "CC3.2 COSO Principle 7: The entity identifies risks to the achievement of its objectives across the entity and analyzes risks as a basis for determining how the risks should be managed"

  children = [
    benchmark.soc_2_2017_cc_3_2_6
  ]

  tags = merge(local.soc_2_2017_cc_3_common_tags, {
    soc_2_2017_item_id = "3.2"
  })
}

benchmark "soc_2_2017_cc_3_2_6" {
  title       = "CC3.2.6"

  children = [
    control.project_service_cloudasset_api_enabled
  ]

  tags = merge(local.soc_2_2017_cc_3_common_tags, {
    soc_2_2017_item_id = "3.2.6"
  })
}