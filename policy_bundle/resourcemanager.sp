locals {
  policy_bundle_resourcemanager_common_tags = {
    service = "resourcemanager"
  }
}

control "audit_log_all" {
  title         = "Checks that all services have all types of audit logs enabled"
  sql           = query.audit_logging_configured_for_all_service.sql

  tags = merge(local.policy_bundle_resourcemanager_common_tags, {
    healthcare_baseline_v1   = "true"
    severity                 = "high"
  })
}