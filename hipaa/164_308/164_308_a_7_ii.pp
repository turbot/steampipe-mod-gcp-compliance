benchmark "hipaa_164_308_a_7_ii" {
  title       = "164.308(a)(7)(ii) Implementation specifications"
  description = "Establish and implement procedures to create and maintain retrievable exact copies of electronic protected health information. Establish and implement procedures to restore any loss of data. Establish and implement procedures to enable the continuation of critical business processes for protecting the security of electronic protected health information while operating in emergency mode. Implement procedures for periodic testing and revision of contingency plans. Assess the relative criticality of specific applications and data to support other contingency plan components."
  children = [
    control.sql_instance_automated_backups_enabled
  ]

  tags = merge(local.hipaa_164_308_common_tags, {
    hipaa_security_rule_2003_item_id = "164_308_a_7_ii"
  })
}
