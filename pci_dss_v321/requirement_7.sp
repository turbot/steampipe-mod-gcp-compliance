locals {
  pci_dss_v321_requirement_7_common_tags = merge(local.pci_dss_v321_common_tags, {
    control_set = "7"
  })
}

benchmark "pci_dss_v321_requirement_7" {
  title       = "Requirement 7:  Restrict access to cardholder data by business need to know"
  description = "To implement strong access control measures, service providers and merchants must be able to allow or deny access to cardholder data systems. This requirement is all about role-based access control (RBAC), which grants access to card data and systems on a need-to-know basis. Need to know is a fundamental concept within PCI DSS. Access control system (e.g. Active Directory, LDAP) must assess each request to prevent exposure of sensitive data to those who do not need this information. You must have documented list of all the users with their roles who need to access card data environment. This list must contain, each role, definition of role, current privilege level, expected privilege level and data resources for each user to perform operations on card data."

  children = [
    benchmark.pci_dss_v321_requirement_7_1
  ]

  tags = local.pci_dss_v321_requirement_7_common_tags
}

benchmark "pci_dss_v321_requirement_7_1" {
  title       = "7.1  Limit access to system components and cardholder data to only those individuals whose job requires such access"
  description = "GCP Customers are responsible for managing access to all GCP products (GCE, VPC, GCS) that are included in their CDE. GCP provides various mechanisms for controlling access to the services including IAM for integration with corporate directories and granular access controls to the GCP Management Console."

  children = [
    benchmark.pci_dss_v321_requirement_7_1_2,
    control.require_bq_table_iam,
    control.storage_bucket_not_publicly_accessible
  ]

  tags = merge(local.pci_dss_v321_requirement_7_common_tags, {
    pci_dss_v321_item_id = "7.1"
  })
}

benchmark "pci_dss_v321_requirement_7_1_2" {
  title       = "7.1.2  Restrict access to privileged user IDs to least privileges necessary to perform job responsibilities"
  description = "GCP Customers are responsible for managing access to all GCP products (GCE, VPC, GCS) that are included in their CDE. GCP provides various mechanisms for controlling access to the services including IAM for integration with corporate directories and granular access controls to the GCP Management Console."

  children = [
    control.compute_instance_with_no_default_service_account_with_full_access,
    control.iam_user_not_assigned_service_account_user_role_project_level,
    control.only_my_domain
  ]

  tags = merge(local.pci_dss_v321_requirement_7_common_tags, {
    pci_dss_v321_item_id = "7.1.2"
  })
}
