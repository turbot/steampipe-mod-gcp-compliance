locals {
  pci_dss_v321_requirement_2_common_tags = merge(local.pci_dss_v321_common_tags, {
    control_set = "2"
  })
}

benchmark "pci_dss_v321_requirement_2" {
  title       = "Requirement 2: Do not use vendor-supplied defaults for system passwords and other security parameters."
  description = "It focuses on hardening your organization’s systems such as servers, network devices, applications, firewalls, wireless access points, etc. Most of the operating systems and devices come with factory default setting such as usernames, passwords, and other insecure configuration parameters. These default usernames and passwords are simple to guess, and most are even published on the Internet.Such default passwords and other security parameters are not permissible per this requirement. This requirement also asks to maintain an inventory of all the systems, configuration/hardening procedures. These procedures need to be followed every time a new system is introduced in the IT infrastructure."

  children = [
    benchmark.pci_dss_v321_requirement_2_1,
    benchmark.pci_dss_v321_requirement_2_2
  ]

  tags = local.pci_dss_v321_requirement_2_common_tags
}

benchmark "pci_dss_v321_requirement_2_1" {
  title       = "2.1 Always change vendor-supplied defaults and remove or disable unnecessary default accounts before installing a system on the network"
  description = "Customers are responsible for changing vendor-supplied defaults on GCP products as applicable deployed within the customers CDE."

  children = [
    control.kubernetes_cluster_node_no_default_service_account
  ]

  tags = merge(local.pci_dss_v321_requirement_10_common_tags, {
    pci_dss_v321_item_id = "2.1"
  })
}

benchmark "pci_dss_v321_requirement_2_2" {
  title       = "2.2  Develop configuration standards for all system components. Assure that these standards address all known security vulnerabilities and are consistent with industry-accepted system hardening standards"
  description = "Customers are responsible for documenting, developing and implementing configuration standards for the GCP products in use that are within the CDE. This includes configuration standards for GCE, VPC, and GCS based on industry standards and hardening guidelines."

  children = [
    control.enable_auto_repair,
    control.enable_auto_upgrade,
    control.gke_container_optimized_os
  ]

  tags = merge(local.pci_dss_v321_requirement_10_common_tags, {
    pci_dss_v321_item_id = "2.2"
  })
}