locals {
  policy_bundle_resourcemanager_common_tags = merge(local.gcp_compliance_common_tags, {
    service = "GCP/ResourceManager"
  })
}

control "audit_logging_configured_for_all_service" {
  title       = "Ensure that Cloud Audit Logging is configured properly across all services and all users from a project"
  description = "It is recommended that Cloud Audit Logging is configured to track all admin activities and read, write access to user data."
  query       = query.audit_logging_configured_for_all_service

  tags = merge(local.policy_bundle_resourcemanager_common_tags, {
    pci_dss_v321 = "true"
  })
}

# Non-Config rule query

query "audit_logging_configured_for_all_service" {
  sql = <<-EOQ
    with default_audit_configs as (
      select
        *
      from
        (
          select
            service,
            string_agg(log ->> 'logType', ', ') log_types,
            string_agg(log ->> 'exemptedMembers', ', ') exempted_user,
            _ctx,
            project
          from
            gcp_audit_policy,
            jsonb_array_elements(audit_log_configs) as log
          group by
            service, project, _ctx
        ) logs
      where
        log_types like '%DATA_WRITE%'
        and log_types like '%DATA_READ%'
        and log_types like '%ADMIN_READ%'
        and service = 'allServices'
    )
    select
      default_audit_configs.service resource,
      case
        when default_audit_configs.exempted_user is null then 'ok'
        else 'alarm'
      end as status,
      case
        when default_audit_configs.exempted_user is null
          then 'Audit logging properly configured across all services and no exempted users associated.'
        else 'Audit logging not configured as per CIS requirement or default audit setting having exempted user.'
      end as reason
      ${replace(local.common_dimensions_qualifier_global_sql, "__QUALIFIER__", "default_audit_configs.")}
    from
      default_audit_configs;
  EOQ
}
