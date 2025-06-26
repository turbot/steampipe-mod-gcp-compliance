benchmark "nist_csf_v2_rc" {
  title       = "RECOVER (RC)"
  description = "Assets and operations affected by a cybersecurity incident are restored."
  children = [
    benchmark.nist_csf_v2_rc_rp,
    benchmark.nist_csf_v2_rc_co
  ]
}

benchmark "nist_csf_v2_rc_rp" {
  title       = "RC.RP"
  description = "Incident Recovery Plan Execution (RC.RP): Restoration activities are performed to ensure operational availability of systems and services affected by cybersecurity incidents."
  children = [
    benchmark.nist_csf_v2_rc_rp_01,
    benchmark.nist_csf_v2_rc_rp_02,
    benchmark.nist_csf_v2_rc_rp_03,
    benchmark.nist_csf_v2_rc_rp_04,
    benchmark.nist_csf_v2_rc_rp_05,
    benchmark.nist_csf_v2_rc_rp_06
  ]
}

benchmark "nist_csf_v2_rc_rp_01" {
  title       = "RC.RP-01"
  description = "The recovery portion of the incident response plan is executed once initiated from the incident response process."
  children = [
    control.organization_essential_contacts_configured
  ]
}

benchmark "nist_csf_v2_rc_rp_02" {
  title       = "RC.RP-02"
  description = "Recovery actions are selected, scoped, prioritized, and performed."
  children = [
    control.sql_instance_automated_backups_enabled,
    control.storage_bucket_log_object_versioning_enabled,
    control.storage_bucket_log_retention_policy_enabled
  ]
}

benchmark "nist_csf_v2_rc_rp_03" {
  title       = "RC.RP-03"
  description = "The integrity of backups and other restoration assets is verified before using them for restoration."
  children = [
    control.logging_bucket_retention_policy_enabled,
    control.sql_instance_automated_backups_enabled,
    control.storage_bucket_log_retention_policy_enabled
  ]
}

benchmark "nist_csf_v2_rc_rp_04" {
  title       = "RC.RP-04"
  description = "Critical mission functions and cybersecurity risk management are considered to establish post-incident operational norms."
  children = [
    control.logging_metric_alert_project_ownership_assignment,
    control.logging_metric_alert_storage_iam_permission_changes
  ]
}

benchmark "nist_csf_v2_rc_rp_05" {
  title       = "RC.RP-05"
  description = "The integrity of restored assets is verified, systems and services are restored, and normal operating status is confirmed."
  children = [
    control.logging_bucket_retention_policy_enabled,
    control.sql_instance_automated_backups_enabled,
    control.storage_bucket_log_retention_policy_enabled
  ]
}

benchmark "nist_csf_v2_rc_rp_06" {
  title       = "RC.RP-06"
  description = "The end of incident recovery is declared based on criteria, and incident-related documentation is completed."
  children = [
    control.audit_logging_configured_for_all_service,
    control.logging_bucket_retention_policy_enabled
  ]
}

benchmark "nist_csf_v2_rc_co" {
  title       = "RC.CO"
  description = "Incident Recovery Communication (RC.CO): Restoration activities are coordinated with internal and external parties."
  children = [
    benchmark.nist_csf_v2_rc_co_03,
    benchmark.nist_csf_v2_rc_co_04
  ]
}

benchmark "nist_csf_v2_rc_co_03" {
  title       = "RC.CO-03"
  description = "Recovery activities and progress in restoring operational capabilities are communicated to designated internal and external stakeholders."
  children = [
    control.organization_essential_contacts_configured
  ]
}

benchmark "nist_csf_v2_rc_co_04" {
  title       = "RC.CO-04"
  description = "Public updates on incident recovery are shared using approved methods and messaging."
  children = [
    control.organization_essential_contacts_configured
  ]
}