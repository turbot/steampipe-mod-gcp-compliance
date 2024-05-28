locals {
  pci_dss_v321_requirement_6_common_tags = merge(local.pci_dss_v321_common_tags, {
    control_set = "6"
  })
}

benchmark "pci_dss_v321_requirement_6" {
  title       = "Requirement 6: Develop and maintain secure systems and applications"
  description = "It is important to define and implement a process that allows to identify and classify the risk of security vulnerabilities in the PCI DSS environment through reliable external sources. Organizations must limit the potential for exploits by deploying critical patches in a timely manner. Patch all systems in the card data environment, including: Operating systems, Firewalls, Routers, Switches, Application software, Databases and POS terminals."

  children = [
    benchmark.pci_dss_v321_requirement_6_6
  ]

  tags = local.pci_dss_v321_requirement_6_common_tags
}

benchmark "pci_dss_v321_requirement_6_6" {
  title       = "6.6 For public-facing web applications, address new threats and vulnerabilities on an ongoing basis and ensure these applications are protected against known attacks by methods like reviewing public-facing web applications via manual or  installing an automated technical solution that detects and prevents web-based attacks (for example, a web-application firewall) in front of public-facing web applications, to continually check all traffic"
  description = "Customers are responsible for Web Application Filtering or application security reviews for web applications deployed on customer-managed GCE instances."

  children = [
    control.disable_gke_dashboard
  ]

  tags = merge(local.pci_dss_v321_requirement_6_common_tags, {
    pci_dss_v321_item_id = "6.6"
  })
}

