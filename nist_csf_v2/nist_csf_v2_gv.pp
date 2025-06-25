benchmark "nist_csf_v2_gv" {
  title       = "GOVERN (GV)"
  description = "The organization's cybersecurity risk management strategy, expectations, and policy are established, communicated, and monitored."
  children = [
    benchmark.nist_csf_v2_gv_oc,
    benchmark.nist_csf_v2_gv_rm,
    benchmark.nist_csf_v2_gv_rr,
    benchmark.nist_csf_v2_gv_po,
    benchmark.nist_csf_v2_gv_ov,
    benchmark.nist_csf_v2_gv_sc
  ]
}

benchmark "nist_csf_v2_gv_oc" {
  title       = "Organizational Context (GV.OC)"
  description = "The circumstances — mission, stakeholder expectations, dependencies, and legal, regulatory, and contractual requirements — surrounding the organization's cybersecurity risk management decisions are understood."
  children = [
    benchmark.nist_csf_v2_gv_oc_01,
    benchmark.nist_csf_v2_gv_oc_02,
    benchmark.nist_csf_v2_gv_oc_03,
    benchmark.nist_csf_v2_gv_oc_04,
    benchmark.nist_csf_v2_gv_oc_05
  ]
}

benchmark "nist_csf_v2_gv_oc_01" {
  title       = "GV.OC-01"
  description = "The organizational mission is understood and informs cybersecurity risk management."
  children = [
    control.organization_essential_contacts_configured,
    control.project_access_approval_settings_enabled,
    control.project_service_cloudasset_api_enabled,
    control.only_my_domain,
    control.restrict_gmail_bigquery_dataset,
    control.restrict_googlegroups_bigquery_dataset
  ]
}

benchmark "nist_csf_v2_gv_oc_02" {
  title       = "GV.OC-02"
  description = " Internal and external stakeholders are understood, and their needs and expectations regarding cybersecurity risk management are understood and considered."
  children = [
    control.organization_essential_contacts_configured
  ]
}

benchmark "nist_csf_v2_gv_oc_03" {
  title       = "GV.OC-03"
  description = "Legal, regulatory, and contractual requirements regarding cybersecurity — including privacy and civil liberties obligations — are understood and managed."
  children = [
    control.logging_bucket_retention_policy_enabled,
    control.logging_metric_alert_audit_configuration_changes,
    control.logging_metric_alert_custom_role_changes,
    control.logging_metric_alert_custom_role_changes_with_iam_admin_undelete_role,
    control.logging_metric_alert_firewall_rule_changes,
    control.logging_metric_alert_network_changes,
    control.logging_metric_alert_network_route_changes,
    control.logging_metric_alert_project_ownership_assignment,
    control.logging_metric_alert_sql_instance_configuration_changes,
    control.logging_metric_alert_storage_iam_permission_changes,
    control.logging_sink_configured_for_all_resource
  ]
}

benchmark "nist_csf_v2_gv_oc_04" {
  title       = "GV.OC-04"
  description = "Critical objectives, capabilities, and services that external stakeholders depend on or expect from the organization are understood and communicated."
  children = [
    control.organization_essential_contacts_configured,
    control.project_service_cloudasset_api_enabled
  ]
}

benchmark "nist_csf_v2_gv_oc_05" {
  title       = "GV.OC-05"
  description = "Outcomes, capabilities, and services that the organization depends on are understood and communicated."
  children = [
    control.organization_essential_contacts_configured,
    control.project_service_cloudasset_api_enabled
  ]
}

benchmark "nist_csf_v2_gv_rm" {
  title       = "Risk Management Strategy (GV.RM)"
  description = "The organization's priorities, constraints, risk tolerance and appetite statements, and assumptions are established, communicated, and used to support operational risk decisions."
  children = [
    benchmark.nist_csf_v2_gv_rm_01,
    benchmark.nist_csf_v2_gv_rm_02,
    benchmark.nist_csf_v2_gv_rm_03,
    benchmark.nist_csf_v2_gv_rm_04,
    benchmark.nist_csf_v2_gv_rm_05,
    benchmark.nist_csf_v2_gv_rm_06,
    benchmark.nist_csf_v2_gv_rm_07
  ]
}

benchmark "nist_csf_v2_gv_rm_01" {
  title       = "GV.RM-01"
  description = "Risk management objectives are established and agreed to by organizational stakeholders."
  children = [
    control.project_access_approval_settings_enabled,
    control.project_service_cloudasset_api_enabled,
    control.iam_service_account_key_age_90,
    control.iam_service_account_gcp_managed_key,
    control.only_my_domain
  ]
}

benchmark "nist_csf_v2_gv_rm_02" {
  title       = "GV.RM-02"
  description = "Risk appetite and risk tolerance statements are established, communicated, and maintained."
  children = [
    control.logging_bucket_retention_policy_enabled,
    control.iam_service_account_key_age_90,
    control.iam_api_key_age_90,
    control.kms_key_rotated_within_90_day,
    control.cmek_rotation_one_hundred_days,
    control.project_access_approval_settings_enabled
  ]
}

benchmark "nist_csf_v2_gv_rm_03" {
  title       = "GV.RM-03"
  description = "Cybersecurity risk management activities and outcomes are included in enterprise risk management processes."
  children = [
    control.audit_logging_configured_for_all_service,
    control.logging_metric_alert_audit_configuration_changes,
    control.project_access_approval_settings_enabled,
    control.iam_service_account_key_age_90,
    control.kms_key_rotated_within_90_day
  ]
}

benchmark "nist_csf_v2_gv_rm_04" {
  title       = "GV.RM-04"
  description = "Strategic direction that describes appropriate risk response options is established and communicated."
  children = [
    control.project_access_approval_settings_enabled,
    control.organization_essential_contacts_configured,
    control.logging_bucket_retention_policy_enabled,
    control.require_bucket_policy_only,
    control.iam_service_account_key_age_90,
    control.iam_api_key_age_90
  ]
}

benchmark "nist_csf_v2_gv_rm_05" {
  title       = "GV.RM-05"
  description = "Lines of communication across the organization are established for cybersecurity risks, including risks from suppliers and other third parties."
  children = [
    control.organization_essential_contacts_configured,
    control.logging_metric_alert_audit_configuration_changes,
    control.logging_metric_alert_custom_role_changes,
    control.logging_metric_alert_custom_role_changes_with_iam_admin_undelete_role,
    control.logging_metric_alert_firewall_rule_changes,
    control.logging_metric_alert_network_changes,
    control.logging_metric_alert_network_route_changes,
    control.logging_metric_alert_project_ownership_assignment,
    control.logging_metric_alert_sql_instance_configuration_changes,
    control.logging_metric_alert_storage_iam_permission_changes
  ]
}

benchmark "nist_csf_v2_gv_rm_06" {
  title       = "GV.RM-06"
  description = "A standardized method for calculating, documenting, categorizing, and prioritizing cybersecurity risks is established and communicated."
  children = [
    control.audit_logging_configured_for_all_service,
    control.logging_metric_alert_audit_configuration_changes,
    control.logging_metric_alert_custom_role_changes,
    control.logging_metric_alert_custom_role_changes_with_iam_admin_undelete_role,
    control.logging_metric_alert_firewall_rule_changes,
    control.logging_metric_alert_network_changes,
    control.logging_metric_alert_network_route_changes,
    control.logging_metric_alert_project_ownership_assignment,
    control.logging_metric_alert_sql_instance_configuration_changes,
    control.logging_metric_alert_storage_iam_permission_changes
  ]
}

benchmark "nist_csf_v2_gv_rm_07" {
  title       = "GV.RM-07"
  description = "Strategic opportunities (i.e., positive risks) are characterized and are included in organizational cybersecurity risk discussions."
  children = [
    control.audit_logging_configured_for_all_service,
    control.logging_metric_alert_audit_configuration_changes,
    control.logging_metric_alert_custom_role_changes,
    control.logging_metric_alert_custom_role_changes_with_iam_admin_undelete_role,
    control.logging_metric_alert_firewall_rule_changes,
    control.logging_metric_alert_network_changes,
    control.logging_metric_alert_network_route_changes,
    control.logging_metric_alert_project_ownership_assignment,
    control.logging_metric_alert_sql_instance_configuration_changes,
    control.logging_metric_alert_storage_iam_permission_changes
  ]
}

benchmark "nist_csf_v2_gv_rr" {
  title       = "Roles, Responsibilities, and Authorities (GV.RR)"
  description = "Cybersecurity roles, responsibilities, and authorities to foster accountability, performance assessment, and continuous improvement are established and communicated."
  children = [
    benchmark.nist_csf_v2_gv_rr_01,
    benchmark.nist_csf_v2_gv_rr_02,
    benchmark.nist_csf_v2_gv_rr_03,
    benchmark.nist_csf_v2_gv_rr_04
  ]
}

benchmark "nist_csf_v2_gv_rr_01" {
  title       = "GV.RR-01"
  description = "Organizational leadership is responsible and accountable for cybersecurity risk and fosters a culture that is risk-aware, ethical, and continually improving."
  children = [
    control.audit_logging_configured_for_all_service,
    control.logging_metric_alert_audit_configuration_changes,
    control.logging_metric_alert_custom_role_changes,
    control.logging_metric_alert_custom_role_changes_with_iam_admin_undelete_role
  ]
}

benchmark "nist_csf_v2_gv_rr_02" {
  title       = "GV.RR-02"
  description = "Roles, responsibilities, and authorities related to cybersecurity risk management are established, communicated, understood, and enforced."
  children = [
    control.logging_metric_alert_custom_role_changes,
    control.logging_metric_alert_custom_role_changes_with_iam_admin_undelete_role,
    control.logging_metric_alert_project_ownership_assignment,
    control.logging_metric_alert_storage_iam_permission_changes,
    control.iam_user_not_assigned_service_account_user_role_project_level,
    control.iam_service_account_gcp_managed_key,
    control.iam_service_account_key_age_90
  ]
}

benchmark "nist_csf_v2_gv_rr_03" {
  title       = "GV.RR-03"
  description = "Adequate resources are allocated commensurate with the cybersecurity risk strategy, roles, responsibilities, and policies."
  children = [
    control.audit_logging_configured_for_all_service,
    control.logging_metric_alert_audit_configuration_changes,
    control.logging_metric_alert_custom_role_changes,
    control.logging_metric_alert_custom_role_changes_with_iam_admin_undelete_role,
    control.logging_metric_alert_project_ownership_assignment,
    control.logging_metric_alert_storage_iam_permission_changes,
    control.iam_user_not_assigned_service_account_user_role_project_level
  ]
}

benchmark "nist_csf_v2_gv_rr_04" {
  title       = "GV.RR-04"
  description = "Cybersecurity is included in human resources practices."
  children = [
    control.project_access_approval_settings_enabled,
    control.logging_metric_alert_custom_role_changes,
    control.logging_metric_alert_custom_role_changes_with_iam_admin_undelete_role,
    control.logging_metric_alert_project_ownership_assignment,
    control.iam_user_not_assigned_service_account_user_role_project_level
  ]
}

benchmark "nist_csf_v2_gv_po" {
  title       = "Policy (GV.PO)"
  description = "Organizational cybersecurity policy is established, communicated, and enforced."
  children = [
    benchmark.nist_csf_v2_gv_po_01,
    benchmark.nist_csf_v2_gv_po_02
  ]
}

benchmark "nist_csf_v2_gv_po_01" {
  title       = "GV.PO-01"
  description = "Policy for managing cybersecurity risks is established based on organizational context, cybersecurity strategy, and priorities and is communicated and enforced."
  children = [
    control.audit_logging_configured_for_all_service,
    control.logging_metric_alert_audit_configuration_changes,
    control.logging_metric_alert_custom_role_changes,
    control.logging_metric_alert_custom_role_changes_with_iam_admin_undelete_role,
    control.logging_metric_alert_firewall_rule_changes,
    control.logging_metric_alert_network_changes,
    control.logging_metric_alert_network_route_changes,
    control.logging_metric_alert_project_ownership_assignment,
    control.logging_metric_alert_sql_instance_configuration_changes,
    control.logging_metric_alert_storage_iam_permission_changes,
  ]
}

benchmark "nist_csf_v2_gv_po_02" {
  title       = "GV.PO-02"
  description = "Policy for managing cybersecurity risks is reviewed, updated, communicated, and enforced to reflect changes in requirements, threats, technology, and organizational mission."
  children = [
    control.audit_logging_configured_for_all_service,
    control.logging_metric_alert_audit_configuration_changes,
    control.logging_metric_alert_custom_role_changes,
    control.logging_metric_alert_custom_role_changes_with_iam_admin_undelete_role,
    control.logging_metric_alert_firewall_rule_changes,
    control.logging_metric_alert_network_changes,
    control.logging_metric_alert_network_route_changes,
    control.logging_metric_alert_project_ownership_assignment,
    control.logging_metric_alert_sql_instance_configuration_changes,
    control.logging_metric_alert_storage_iam_permission_changes,
    control.logging_sink_configured_for_all_resource
  ]
}

benchmark "nist_csf_v2_gv_ov" {
  title       = "Oversight (GV.OV)"
  description = "Results of organization-wide cybersecurity risk management activities and performance are used to inform, improve, and adjust the risk management strategy."
  children = [
    benchmark.nist_csf_v2_gv_ov_01,
    benchmark.nist_csf_v2_gv_ov_02,
    benchmark.nist_csf_v2_gv_ov_03
  ]
}

benchmark "nist_csf_v2_gv_ov_01" {
  title       = "GV.OV-01"
  description = "Cybersecurity risk management strategy outcomes are reviewed to inform and adjust strategy and direction."
  children = [
    control.audit_logging_configured_for_all_service,
    control.logging_metric_alert_audit_configuration_changes,
    control.logging_metric_alert_custom_role_changes,
    control.logging_metric_alert_custom_role_changes_with_iam_admin_undelete_role,
    control.logging_metric_alert_firewall_rule_changes,
    control.logging_metric_alert_network_changes,
    control.logging_metric_alert_network_route_changes,
    control.logging_metric_alert_project_ownership_assignment,
    control.logging_metric_alert_sql_instance_configuration_changes,
    control.logging_metric_alert_storage_iam_permission_changes,
    control.logging_sink_configured_for_all_resource
  ]
}

benchmark "nist_csf_v2_gv_ov_02" {
  title       = "GV.OV-02"
  description = "The cybersecurity risk management strategy is reviewed and adjusted to ensure coverage of organizational requirements and risks."
  children = [
    control.audit_logging_configured_for_all_service,
    control.logging_metric_alert_audit_configuration_changes,
    control.logging_metric_alert_custom_role_changes,
    control.logging_metric_alert_custom_role_changes_with_iam_admin_undelete_role,
    control.logging_metric_alert_firewall_rule_changes,
    control.logging_metric_alert_network_changes,
    control.logging_metric_alert_network_route_changes,
    control.logging_metric_alert_project_ownership_assignment,
    control.logging_metric_alert_sql_instance_configuration_changes,
    control.logging_metric_alert_storage_iam_permission_changes,
    control.logging_sink_configured_for_all_resource
  ]
}

benchmark "nist_csf_v2_gv_ov_03" {
  title       = "GV.OV-03"
  description = "Organizational cybersecurity risk management performance is evaluated and reviewed for adjustments needed."
  children = [
    control.audit_logging_configured_for_all_service,
    control.logging_metric_alert_audit_configuration_changes,
    control.logging_metric_alert_custom_role_changes,
    control.logging_metric_alert_custom_role_changes_with_iam_admin_undelete_role,
    control.logging_metric_alert_firewall_rule_changes,
    control.logging_metric_alert_network_changes,
    control.logging_metric_alert_network_route_changes,
    control.logging_metric_alert_project_ownership_assignment,
    control.logging_metric_alert_sql_instance_configuration_changes,
    control.logging_metric_alert_storage_iam_permission_changes,
    control.logging_sink_configured_for_all_resource
  ]
}

benchmark "nist_csf_v2_gv_sc" {
  title       = "Cybersecurity Supply Chain Risk Management (GV.SC)"
  description = "Cyber supply chain risk management processes are identified, established, managed, monitored, and improved by organizational stakeholders."
  children = [
    benchmark.nist_csf_v2_gv_sc_01,
    benchmark.nist_csf_v2_gv_sc_02,
    benchmark.nist_csf_v2_gv_sc_03,
    benchmark.nist_csf_v2_gv_sc_04,
    benchmark.nist_csf_v2_gv_sc_05,
    benchmark.nist_csf_v2_gv_sc_06,
    benchmark.nist_csf_v2_gv_sc_07,
    benchmark.nist_csf_v2_gv_sc_08,
    benchmark.nist_csf_v2_gv_sc_09,
    benchmark.nist_csf_v2_gv_sc_10
  ]
}

benchmark "nist_csf_v2_gv_sc_01" {
  title       = "GV.SC-01"
  description = "A cybersecurity supply chain risk management program, strategy, objectives, policies, and processes are established and agreed to by organizational stakeholders."
  children = [
    control.audit_logging_configured_for_all_service,
    control.logging_metric_alert_audit_configuration_changes,
    control.logging_metric_alert_custom_role_changes,
    control.logging_metric_alert_custom_role_changes_with_iam_admin_undelete_role,
    control.logging_metric_alert_project_ownership_assignment,
    control.logging_metric_alert_storage_iam_permission_changes,
    control.logging_sink_configured_for_all_resource
  ]
}

benchmark "nist_csf_v2_gv_sc_02" {
  title       = "GV.SC-02"
  description = "Cybersecurity roles and responsibilities for suppliers, customers, and partners are established, communicated, and coordinated internally and externally."
  children = [
    control.logging_metric_alert_custom_role_changes,
    control.logging_metric_alert_custom_role_changes_with_iam_admin_undelete_role,
    control.logging_metric_alert_storage_iam_permission_changes,
    control.iam_user_not_assigned_service_account_user_role_project_level,
    control.iam_service_account_gcp_managed_key,
    control.iam_service_account_key_age_90
  ]
}

benchmark "nist_csf_v2_gv_sc_03" {
  title       = "GV.SC-03"
  description = "Cybersecurity supply chain risk management is integrated into cybersecurity and enterprise risk management, risk assessment, and improvement processes."
  children = [
    control.audit_logging_configured_for_all_service,
    control.logging_metric_alert_audit_configuration_changes,
    control.logging_metric_alert_custom_role_changes,
    control.logging_metric_alert_custom_role_changes_with_iam_admin_undelete_role,
    control.logging_metric_alert_project_ownership_assignment,
    control.logging_metric_alert_storage_iam_permission_changes,
    control.logging_sink_configured_for_all_resource
  ]
}

benchmark "nist_csf_v2_gv_sc_04" {
  title       = "GV.SC-04"
  description = "Suppliers are known and prioritized by criticality."
  children = [
    control.organization_essential_contacts_configured,
    control.project_service_cloudasset_api_enabled
  ]
}

benchmark "nist_csf_v2_gv_sc_05" {
  title       = "GV.SC-05"
  description = "Requirements to address cybersecurity risks in supply chains are established, prioritized, and integrated into contracts and other types of agreements with suppliers and other relevant third parties."
  children = [
    control.organization_essential_contacts_configured,
    control.project_access_approval_settings_enabled,
    control.project_service_cloudasset_api_enabled,
    control.logging_metric_alert_custom_role_changes,
    control.logging_metric_alert_custom_role_changes_with_iam_admin_undelete_role,
    control.logging_metric_alert_project_ownership_assignment,
    control.logging_metric_alert_firewall_rule_changes,
    control.logging_metric_alert_network_changes,
    control.logging_metric_alert_network_route_changes,
    control.require_bucket_policy_only,
    control.storage_bucket_not_publicly_accessible,
    control.denylist_public_users,
    control.only_my_domain
  ]
}

benchmark "nist_csf_v2_gv_sc_06" {
  title       = "GV.SC-06"
  description = "Planning and due diligence are performed to reduce risks before entering into formal supplier or other third-party relationships."
  children = [
    control.organization_essential_contacts_configured,
    control.project_access_approval_settings_enabled,
    control.project_service_cloudasset_api_enabled,
    control.logging_metric_alert_custom_role_changes,
    control.logging_metric_alert_custom_role_changes_with_iam_admin_undelete_role,
    control.logging_metric_alert_project_ownership_assignment,
    control.logging_metric_alert_firewall_rule_changes,
    control.logging_metric_alert_network_changes,
    control.logging_metric_alert_network_route_changes,
    control.iam_user_not_assigned_service_account_user_role_project_level,
    control.iam_user_separation_of_duty_enforced,
    control.iam_user_kms_separation_of_duty_enforced
  ]
}

benchmark "nist_csf_v2_gv_sc_07" {
  title       = "GV.SC-07"
  description = "The risks posed by a supplier, their products and services, and other third parties are understood, recorded, prioritized, assessed, responded to, and monitored over the course of the relationship."
  children = [
    control.audit_logging_configured_for_all_service,
    control.logging_bucket_retention_policy_enabled,
    control.logging_metric_alert_audit_configuration_changes,
    control.logging_metric_alert_custom_role_changes,
    control.logging_metric_alert_custom_role_changes_with_iam_admin_undelete_role,
    control.logging_metric_alert_firewall_rule_changes,
    control.logging_metric_alert_network_changes,
    control.logging_metric_alert_network_route_changes,
    control.logging_metric_alert_project_ownership_assignment,
    control.logging_metric_alert_sql_instance_configuration_changes,
    control.logging_metric_alert_storage_iam_permission_changes,
    control.logging_sink_configured_for_all_resource,
    control.storage_bucket_log_retention_policy_enabled,
    control.storage_bucket_log_object_versioning_enabled,
    control.storage_bucket_log_not_publicly_accessible,
    control.compute_firewall_rule_logging_enabled,
    control.kubernetes_cluster_logging_enabled,
    control.kubernetes_cluster_monitoring_enabled,
    control.sql_instance_postgresql_cloudsql_pgaudit_database_flag_enabled,
    control.sql_instance_postgresql_log_checkpoints_database_flag_on,
    control.sql_instance_postgresql_log_connections_database_flag_on,
    control.sql_instance_postgresql_log_statement_database_flag_ddl
  ]
}

benchmark "nist_csf_v2_gv_sc_08" {
  title       = "GV.SC-08"
  description = "Relevant suppliers and other third parties are included in incident planning, response, and recovery activities."
  children = [
    control.organization_essential_contacts_configured,
    control.audit_logging_configured_for_all_service,
    control.logging_bucket_retention_policy_enabled,
    control.logging_metric_alert_audit_configuration_changes,
    control.logging_metric_alert_custom_role_changes,
    control.logging_metric_alert_custom_role_changes_with_iam_admin_undelete_role,
    control.logging_metric_alert_firewall_rule_changes,
    control.logging_metric_alert_network_changes,
    control.logging_metric_alert_network_route_changes,
    control.logging_metric_alert_project_ownership_assignment,
    control.logging_metric_alert_sql_instance_configuration_changes,
    control.logging_metric_alert_storage_iam_permission_changes,
    control.logging_sink_configured_for_all_resource
  ]
}

benchmark "nist_csf_v2_gv_sc_09" {
  title       = "GV.SC-09"
  description = "Supply chain security practices are integrated into cybersecurity and enterprise risk management programs, and their performance is monitored throughout the technology product and service life cycle."
  children = [
    control.audit_logging_configured_for_all_service,
    control.logging_bucket_retention_policy_enabled,
    control.logging_metric_alert_audit_configuration_changes,
    control.logging_metric_alert_custom_role_changes,
    control.logging_metric_alert_custom_role_changes_with_iam_admin_undelete_role,
    control.logging_metric_alert_firewall_rule_changes,
    control.logging_metric_alert_network_changes,
    control.logging_metric_alert_network_route_changes,
    control.logging_metric_alert_project_ownership_assignment,
    control.logging_metric_alert_sql_instance_configuration_changes,
    control.logging_metric_alert_storage_iam_permission_changes,
    control.logging_sink_configured_for_all_resource,
    control.kubernetes_cluster_logging_enabled,
    control.kubernetes_cluster_monitoring_enabled,
    control.kubernetes_cluster_shielded_instance_integrity_monitoring_enabled
  ]
}

benchmark "nist_csf_v2_gv_sc_10" {
  title       = "GV.SC-10"
  description = "Cybersecurity supply chain risk management plans include provisions for activities that occur after the conclusion of a partnership or service agreement."
  children = [
    control.organization_essential_contacts_configured,
    control.project_access_approval_settings_enabled,
    control.project_service_cloudasset_api_enabled,
    control.iam_service_account_gcp_managed_key,
    control.iam_service_account_key_age_90,
    control.iam_api_key_age_90,
    control.iam_user_not_assigned_service_account_user_role_project_level,
    control.iam_user_separation_of_duty_enforced,
    control.kms_key_separation_of_duties_enforced,
    control.kms_key_users_limited_to_3,
    control.logging_metric_alert_custom_role_changes,
    control.logging_metric_alert_custom_role_changes_with_iam_admin_undelete_role,
    control.logging_metric_alert_project_ownership_assignment,
    control.logging_metric_alert_firewall_rule_changes,
    control.logging_metric_alert_network_changes,
    control.logging_metric_alert_network_route_changes,
    control.audit_logging_configured_for_all_service
  ]
}