benchmark "hipaa_164_308_a_1_ii" {
  title       = "164.308(a)(1)(ii) Implementation specifications"
  description = "Conduct an accurate and thorough assessment of the potential risks and vulnerabilities to the confidentiality, integrity, and availability of electronic protected health information held by the covered entity or business associate. Implement security measures sufficient to reduce risks and vulnerabilities to a reasonable and appropriate level to comply with § 164.306(a). Apply appropriate sanctions against workforce members who fail to comply with the security policies and procedures of the covered entity or business associate. Implement procedures to regularly review records of information system activity, such as audit logs, access reports, and security incident tracking reports."
  children = [
    control.audit_logging_configured_for_all_service,
    control.compute_network_dns_logging_enabled
  ]

  tags = merge(local.hipaa_164_308_common_tags, {
    hipaa_security_rule_2003_item_id = "164_308_a_1_ii"
  })
}
