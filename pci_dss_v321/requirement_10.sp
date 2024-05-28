locals {
  pci_dss_v321_requirement_10_common_tags = merge(local.pci_dss_v321_common_tags, {
    control_set = "10"
  })
}

benchmark "pci_dss_v321_requirement_10" {
  title       = "Requirement 10: Track and monitor all access to network resources and cardholder data"
  description = "The vulnerabilities in physical and wireless networks make it easier for cyber criminals to steal card data. This requirement requires that all the systems must have correct audit policy set and send the logs to centralized syslog server. These logs must be reviewed at least daily to look for anomalies, and suspicious activities. Security Information and Event Monitoring tools (SIEM), can help you log system and network activities, monitor logs and alert of suspicious activity. PCI DSS also requires that audit trail records must meet a certain standard in terms of the information contained. Time synchronization is required. Audit data must be secured, and such data must be maintained for a period no shorter than a year."

  children = [
    benchmark.pci_dss_v321_requirement_10_1,
    benchmark.pci_dss_v321_requirement_10_2,
    benchmark.pci_dss_v321_requirement_10_4,
    benchmark.pci_dss_v321_requirement_10_5
  ]

  tags = local.pci_dss_v321_requirement_10_common_tags
}

benchmark "pci_dss_v321_requirement_10_1" {
  title       = "10.1 Implement audit trails to link all access to system components to each individual user."
  description = "GCP customers are responsible for configuring logging parameters, when available. Customers are responsible to log and monitor their GCE, and GKE instances, systems and applications in alignment with PCI DSS requirements."

  children = [
    control.compute_firewall_rule_logging_enabled,
    control.audit_logging_configured_for_all_service,
    control.kubernetes_cluster_logging_enabled,
    control.enable_network_flow_logs,
  ]

  tags = merge(local.pci_dss_v321_requirement_10_common_tags, {
    pci_dss_v321_item_id = "10.1"
  })
}

benchmark "pci_dss_v321_requirement_10_2" {
  title       = "10.2  Implement automated audit trails for all system components to reconstruct the events"
  description = "GCP customers are responsible for configuring logging parameters, when available. Customers are responsible to log and monitor their GCE, and GKE instances, systems and applications in alignment with PCI DSS requirements."

  children = [
    benchmark.pci_dss_v321_requirement_10_2_2,
    benchmark.pci_dss_v321_requirement_10_2_7,
    control.compute_firewall_rule_logging_enabled,
    control.audit_logging_configured_for_all_service,
    control.kubernetes_cluster_logging_enabled,
    control.enable_network_flow_logs,
  ]

  tags = merge(local.pci_dss_v321_requirement_10_common_tags, {
    pci_dss_v321_item_id = "10.2"
  })
}

benchmark "pci_dss_v321_requirement_10_2_2" {
  title       = "10.2.2  All actions taken by any individual with root or administrative privileges"
  description = "GCP customers are responsible for configuring logging parameters, when available. Customers are responsible to log and monitor their GCE, and GKE instances, systems and applications in alignment with PCI DSS requirements."

  children = [
    control.kubernetes_cluster_logging_enabled
  ]

  tags = merge(local.pci_dss_v321_requirement_10_common_tags, {
    pci_dss_v321_item_id = "10.2.2"
  })
}

benchmark "pci_dss_v321_requirement_10_2_7" {
  title       = "10.2.7  Creation and deletion of system-level objects"
  description = "GCP customers are responsible for configuring logging parameters, when available. Customers are responsible to log and monitor their GCE, and GKE instances, systems and applications in alignment with PCI DSS requirements."

  children = [
    control.kubernetes_cluster_logging_enabled
  ]

  tags = merge(local.pci_dss_v321_requirement_10_common_tags, {
    pci_dss_v321_item_id = "10.2.7"
  })
}

benchmark "pci_dss_v321_requirement_10_4" {
  title       = "10.4  Using time-synchronization technology, synchronize all critical system clocks and times and ensure that the following is implemented for acquiring, distributing, and storing time"
  description = "GCP customers are responsible for appropriately managing network time protocol (NTP) configuration for their GCE and GKE instances."

  children = [
    benchmark.pci_dss_v321_requirement_10_4_1,
    benchmark.pci_dss_v321_requirement_10_4_3,
  ]

  tags = merge(local.pci_dss_v321_requirement_10_common_tags, {
    pci_dss_v321_item_id = "10.4"
  })
}

benchmark "pci_dss_v321_requirement_10_4_1" {
  title       = "10.4.1 Critical systems have the correct and consistent time"
  description = "GCP customers are responsible for appropriately managing network time protocol (NTP) configuration for their GCE and GKE instances."

  children = [
    control.gke_container_optimized_os
  ]

  tags = merge(local.pci_dss_v321_requirement_10_common_tags, {
    pci_dss_v321_item_id = "10.4"
  })
}

benchmark "pci_dss_v321_requirement_10_4_3" {
  title       = "10.4.3 Time settings are received from industry-accepted time sources"
  description = "GCP customers are responsible for appropriately managing network time protocol (NTP) configuration for their GCE and GKE instances"

  children = [
    control.gke_container_optimized_os
  ]

  tags = merge(local.pci_dss_v321_requirement_10_common_tags, {
    pci_dss_v321_item_id = "10.4.3"
  })
}

benchmark "pci_dss_v321_requirement_10_5" {
  title       = "10.5  Secure audit trails so they cannot be altered"
  description = "GCP Customers are responsible for setting permissions and access controls for audit logs. Identity Access Management (IAM) can be used to set permissions for accounts with access to online and offline log storage locations. Customers are responsible to log and monitor their GCE and GKE systems and instances in alignment with PCI DSS requirements."

  children = [
    control.storage_bucket_log_retention_policy_enabled,
    control.storage_bucket_log_object_versioning_enabled,
    control.storage_bucket_log_not_publicly_accessible
  ]

  tags = merge(local.pci_dss_v321_requirement_10_common_tags, {
    pci_dss_v321_item_id = "10.5"
  })
}


