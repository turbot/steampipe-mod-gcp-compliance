benchmark "nist_800_53_rev_5_ca" {
  title       = "Assessment, Authorization, And Monitoring (CA)"
  description = "The Security Assessment and Authorization control family includes controls that supplement the execution of security assessments, authorizations, continuous monitoring, plan of actions and milestones, and system interconnections."
  children = [
    benchmark.nist_800_53_rev_5_ca_9
  ]

  tags = local.nist_800_53_rev_5_common_tags
}

benchmark "nist_800_53_rev_5_ca_9" {
  title       = "Internal System Connections (CA-9)"
  description = "a. Authorize internal connections of [Assignment: organization-defined system components or classes of components] to the system; b. Document, for each internal connection, the interface characteristics, security and privacy requirements, and the nature of the information communicated; c. Terminate internal system connections after [Assignment: organization-defined conditions]; and d. Review [Assignment: organization-defined frequency] the continued need for each internal connection."
  children = [
    control.compute_instance_ip_forwarding_disabled,
    control.restrict_firewall_rule_rdp_world_open,
    control.restrict_firewall_rule_ssh_world_open
  ]

  tags = local.nist_800_53_rev_5_common_tags
}