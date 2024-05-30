benchmark "hipaa_164_310_d_2_iii" {
  title       = "164.310(d)(2)(iii) Media re-use"
  description = "Implement procedures for removal of electronic protected health information from electronic media before the media are made available for re-use."
  children = [
    control.project_service_cloudasset_api_enabled
  ]

  tags = merge(local.hipaa_164_310_common_tags, {
    hipaa_security_rule_2003_item_id = "164_310_d_2_iii"
  })
}
