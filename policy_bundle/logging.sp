locals {
  policy_bundle_logging_common_tags = merge(local.gcp_compliance_common_tags, {
    service = "GCP/Logging"
  })
}

control "logging_bucket_retention_policy_enabled" {
  title       = "Ensure that retention policies on log buckets are configured using Bucket Lock"
  description = "Enabling retention policies on log buckets will protect logs stored in cloud storage buckets from being overwritten or accidentally deleted. It is recommended to set up retention policies and configure Bucket Lock on all storage buckets that are used as log sinks."
  query       = query.logging_bucket_retention_policy_enabled

  tags = local.policy_bundle_logging_common_tags
}

control "logging_metric_alert_audit_configuration_changes" {
  title       = "Ensure that the log metric filter and alerts exist for Audit Configuration changes"
  description = "Cloud audit logging records information includes the identity of the API caller, the time of the API call, the source IP address of the API caller, the request parameters, and the response elements returned by GCP services. Cloud audit logging provides a history of GCP API calls for an account, including API calls made via the console, SDKs, command-line tools, and other GCP services."
  query       = query.logging_metric_alert_audit_configuration_changes

  tags = merge(local.policy_bundle_logging_common_tags, {
    hipaa = "true"
  })
}

control "logging_metric_alert_custom_role_changes" {
  title       = "Ensure that the log metric filter and alerts exist for Custom Role changes"
  description = "It is recommended that a metric filter and alarm be established for changes to Identity and Access Management (IAM) role creation, deletion and updating activities."
  query       = query.logging_metric_alert_custom_role_changes

  tags = merge(local.policy_bundle_logging_common_tags, {
    hipaa = "true"
  })
}

control "logging_metric_alert_firewall_rule_changes" {
  title       = "Ensure that the log metric filter and alerts exist for VPC Network Firewall rule changes"
  description = "It is recommended that a metric filter and alarm be established for Virtual Private Cloud (VPC) Network Firewall rule changes."
  query       = query.logging_metric_alert_firewall_rule_changes

  tags = merge(local.policy_bundle_logging_common_tags, {
    hipaa = "true"
  })
}

control "logging_metric_alert_network_changes" {
  title       = "Ensure that the log metric filter and alerts exist for VPC network changes"
  description = "It is recommended that a metric filter and alarm be established for Virtual Private Cloud (VPC) network changes."
  query       = query.logging_metric_alert_network_changes

  tags = merge(local.policy_bundle_logging_common_tags, {
    hipaa = "true"
  })
}

control "logging_metric_alert_network_route_changes" {
  title       = "Ensure that the log metric filter and alerts exist for VPC network route changes"
  description = "It is recommended that a metric filter and alarm be established for Virtual Private Cloud (VPC) network route changes."
  query       = query.logging_metric_alert_network_route_changes

  tags = merge(local.policy_bundle_logging_common_tags, {
    hipaa = "true"
  })
}

control "logging_metric_alert_project_ownership_assignment" {
  title       = "Ensure log metric filter and alerts exist for project ownership assignments/changes"
  description = "In order to prevent unnecessary project ownership assignments to users/service-accounts and further misuses of projects and resources, all roles/Owner assignments should be monitored. Members (users/Service-Accounts) with a role assignment to primitive role roles/Owner are project owners."
  query       = query.logging_metric_alert_project_ownership_assignment

  tags = merge(local.policy_bundle_logging_common_tags, {
    hipaa = "true"
  })
}

control "logging_metric_alert_sql_instance_configuration_changes" {
  title       = "Ensure that the log metric filter and alerts exist for SQL instance configuration changes"
  description = "It is recommended that a metric filter and alarm be established for SQL instance configuration changes."
  query       = query.logging_metric_alert_sql_instance_configuration_changes

  tags = merge(local.policy_bundle_logging_common_tags, {
    hipaa = "true"
  })
}

control "logging_metric_alert_storage_iam_permission_changes" {
  title       = "Ensure that the log metric filter and alerts exist for Cloud Storage IAM permission changes"
  description = "It is recommended that a metric filter and alarm be established for Cloud Storage Bucket IAM changes."
  query       = query.logging_metric_alert_storage_iam_permission_changes

  tags = merge(local.policy_bundle_logging_common_tags, {
    hipaa = "true"
  })
}

control "logging_sink_configured_for_all_resource" {
  title       = "Ensure that sinks are configured for all log entries"
  description = "It is recommended to create a sink that will export copies of all the log entries. This can help aggregate logs from multiple projects and export them to a Security Information and Event Management (SIEM)."
  query       = query.logging_sink_configured_for_all_resource

  tags = merge(local.policy_bundle_logging_common_tags, {
    hipaa = "true"
  })
}

query "logging_bucket_retention_policy_enabled" {
  sql = <<-EOQ
    with logging_sinks as (
      select
        self_link,
        title,
        _ctx,
        project,
        destination
      from
        gcp_logging_sink
    )
    select
      s.self_link resource,
      case
        when b.retention_policy is not null and b.retention_policy ->> 'isLocked' = 'true' then 'ok'
        else 'alarm'
      end as status,
      case
        when b.retention_policy is not null and b.retention_policy ->> 'isLocked' = 'true'
          then s.title || '''s logging bucket ' || b.name || ' has retention policies configured.'
        else s.title || '''s logging bucket ' || b.name || ' has retention policies not configured.'
      end as reason
      ${replace(local.common_dimensions_qualifier_global_sql, "__QUALIFIER__", "s.")}
    from
      gcp_storage_bucket b
      join logging_sinks s on (
      split_part(s.destination, '/', 1) = 'storage.googleapis.com'
      and split_part(s.destination, '/', 2) = b.name
    );
  EOQ
}

query "logging_metric_alert_audit_configuration_changes" {
  sql = <<-EOQ
    with filter_data as (
      select
        m.project as project,
        display_name alert_name,
        count(m.name) metric_name
      from
        gcp_monitoring_alert_policy,
        jsonb_array_elements(conditions) as filter_condition
        join gcp_logging_metric m on m.filter ~ '\s*protoPayload.methodName\s*=\s*"SetIamPolicy"\s*AND\s*protoPayload.serviceData.policyDelta.auditConfigDeltas:\*\s*'
        and filter_condition -> 'conditionThreshold' ->> 'filter' like '%metric.type="' || m.metric_descriptor_type || '"%'
      where
        enabled
      group by
        m.project, display_name, m.name
    )
    select
      'https://cloudresourcemanager.googleapis.com/v1/projects/' || project_id resource,
      case
        when d.metric_name > 0 then 'ok'
        else 'alarm'
      end as status,
      case
        when d.metric_name > 0
          then 'Log metric and alert exist for audit configuration changes.'
        else 'Log metric and alert do not exist for audit configuration changes.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_project_sql}
    from
      gcp_project as p
      left join filter_data as d on d.project = p.name;
  EOQ
}

query "logging_metric_alert_custom_role_changes" {
  sql = <<-EOQ
    with filter_data as (
      select
        m.project as project,
        display_name alert_name,
        count(m.name) metric_name
      from
        gcp_monitoring_alert_policy,
        jsonb_array_elements(conditions) as filter_condition
        join gcp_logging_metric m on m.filter ~ '\s*resource\.type\s*=\s*"iam_role"\s*AND\s*\(\s*protoPayload\.methodName\s*=\s*"google\.iam\.admin\.v1\.CreateRole"\s*OR\s*protoPayload\.methodName\s*=\s*"google\.iam\.admin\.v1\.DeleteRole"\s*OR\s*protoPayload\.methodName\s*=\s*"google\.iam\.admin\.v1\.UpdateRole"\s*\)'
        and filter_condition -> 'conditionThreshold' ->> 'filter' like '%metric.type="' || m.metric_descriptor_type || '"%'
      where
        enabled
      group by
        m.project, display_name, m.name
    )
    select
      'https://cloudresourcemanager.googleapis.com/v1/projects/' || project_id resource,
      case
        when d.metric_name > 0 then 'ok'
        else 'alarm'
      end as status,
      case
        when d.metric_name > 0
          then 'Log metric and alert exist for custom role changes.'
        else 'Log metric and alert do not exist for custom role changes.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_project_sql}
    from
      gcp_project as p
      left join filter_data as d on d.project = p.name;
  EOQ
}

query "logging_metric_alert_firewall_rule_changes" {
  sql = <<-EOQ
    with filter_data as (
      select
        m.project as project,
        display_name alert_name,
        count(m.name) metric_name
      from
        gcp_monitoring_alert_policy,
        jsonb_array_elements(conditions) as filter_condition
        join gcp_logging_metric m on m.filter ~ '\s*resource\.type\s*=\s*"gce_firewall_rule"\s*AND\s*\(\s*protoPayload\.methodName\s*:\s*"compute\.firewalls\.patch"\s*OR\s*protoPayload\.methodName\s*:\s*"compute\.firewalls\.insert"\s*OR\s*protoPayload\.methodName\s*:\s*"compute\.firewalls\.delete"\s*\)'
        and filter_condition -> 'conditionThreshold' ->> 'filter' like '%metric.type="' || m.metric_descriptor_type || '"%'
      where
        enabled
      group by
        m.project, display_name, m.name
    )
    select
      'https://cloudresourcemanager.googleapis.com/v1/projects/' || project_id resource,
      case
        when d.metric_name > 0 then 'ok'
        else 'alarm'
      end as status,
      case
        when d.metric_name > 0
          then 'Log metric and alert exist for network firewall rule changes.'
        else 'Log metric and alert do not exist network for firewall rule changes.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_project_sql}
    from
      gcp_project as p
      left join filter_data as d on d.project = p.name;
  EOQ
}

query "logging_metric_alert_network_changes" {
  sql = <<-EOQ
    with filter_data as (
      select
        m.project as project,
        display_name alert_name,
        count(m.name) metric_name
      from
        gcp_monitoring_alert_policy,
        jsonb_array_elements(conditions) as filter_condition
        join gcp_logging_metric m on m.filter ~ '\s*resource\.type\s*=\s*gce_network\s*AND\s*\(\s*protoPayload\.methodName\s*=\s*"beta\.compute\.networks\.insert"\s*OR\s*protoPayload\.methodName\s*=\s*"beta\.compute\.networks\.patch"\s*OR\s*protoPayload\.methodName\s*=\s*"v1\.compute\.networks\.delete"\s*OR\s*protoPayload\.methodName\s*=\s*"v1\.compute\.networks\.removePeering"\s*OR\s*protoPayload\.methodName\s*=\s*"v1\.compute\.networks\.addPeering"\s*\)'
        and filter_condition -> 'conditionThreshold' ->> 'filter' like '%metric.type="' || m.metric_descriptor_type || '"%'
      where
        enabled
      group by
        m.project, display_name, m.name
    )
    select
      'https://cloudresourcemanager.googleapis.com/v1/projects/' || project_id resource,
      case
        when d.metric_name > 0 then 'ok'
        else 'alarm'
      end as status,
      case
        when d.metric_name > 0
          then 'Log metric and alert exist for network changes.'
        else 'Log metric and alert do not exist for network changes.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_project_sql}
    from
      gcp_project as p
      left join filter_data as d on d.project = p.name
  EOQ
}

query "logging_metric_alert_network_route_changes" {
  sql = <<-EOQ
    with filter_data as (
      select
        m.project as project,
        display_name alert_name,
        count(m.name) metric_name
      from
        gcp_monitoring_alert_policy,
        jsonb_array_elements(conditions) as filter_condition
        join gcp_logging_metric m on m.filter ~ '\s*resource\.type\s*=\s*"gce_route"\s*AND\s*\(\s*protoPayload\.methodName\s*:\s*"compute\.routes\.delete"\s*OR\s*protoPayload\.methodName\s*:\s*"compute\.routes\.insert"\s*\)'
        and filter_condition -> 'conditionThreshold' ->> 'filter' like '%metric.type="' || m.metric_descriptor_type || '"%'
      where
        enabled
      group by
        m.project, display_name, m.name
    )
    select
      'https://cloudresourcemanager.googleapis.com/v1/projects/' || project_id resource,
      case
        when d.metric_name > 0 then 'ok'
        else 'alarm'
      end as status,
      case
        when d.metric_name > 0
          then 'Log metric and alert exist for network route changes.'
        else 'Log metric and alert do not exist for network route changes.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_project_sql}
    from
      gcp_project as p
      left join filter_data as d on d.project = p.name;
  EOQ
}

query "logging_metric_alert_project_ownership_assignment" {
  sql = <<-EOQ
    with filter_data as (
      select
        m.project as project,
        display_name alert_name,
        count(m.name) metric_name
      from
        gcp_monitoring_alert_policy,
        jsonb_array_elements(conditions) as filter_condition
        join gcp_logging_metric m on m.filter ~ '\s*\(protoPayload.serviceName\s*=\s*"cloudresourcemanager.googleapis.com"\s*\)\s*AND\s*\(\s*ProjectOwnership\s*OR\s*projectOwnerInvitee\s*\)\s*OR\s*\(\s*protoPayload.serviceData.policyDelta.bindingDeltas.action\s*=\s*"REMOVE"\s*AND\s*protoPayload.serviceData.policyDelta.bindingDeltas.role\s*=\s*"roles/owner"\s*\)\s*OR\s*\(\s*protoPayload.serviceData.policyDelta.bindingDeltas.action\s*=\s*"ADD"\s*AND\s*protoPayload.serviceData.policyDelta.bindingDeltas.role\s*=\s*"roles/owner"\s*\)\s*'
        and filter_condition -> 'conditionThreshold' ->> 'filter' like '%metric.type="' || m.metric_descriptor_type || '"%'
      where
        enabled
      group by
        m.project, display_name, m.name
    )
    select
      'https://cloudresourcemanager.googleapis.com/v1/projects/' || project_id resource,
      case
        when d.metric_name > 0  then 'ok'
        else 'alarm'
      end as status,
      case
        when d.metric_name > 0
          then 'Log metric and alert exist for project ownership assignments/changes.'
        else 'Log metric and alert do not exist exist for project ownership assignments/changes.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_project_sql}
    from
      gcp_project as p
      left join filter_data as d on d.project = p.name;
  EOQ
}

query "logging_metric_alert_sql_instance_configuration_changes" {
  sql = <<-EOQ
    with filter_data as (
      select
        m.project as project,
        display_name alert_name,
        count(m.name) metric_name
      from
        gcp_monitoring_alert_policy,
        jsonb_array_elements(conditions) as filter_condition
        join gcp_logging_metric m on m.filter ~ '\s*protoPayload.methodName\s*=\s*"cloudsql.instances.update"\s*'
        and filter_condition -> 'conditionThreshold' ->> 'filter' like '%metric.type="' || m.metric_descriptor_type || '"%'
      where
        enabled
      group by
        m.project, display_name, m.name
    )
    select
      'https://cloudresourcemanager.googleapis.com/v1/projects/' || project_id resource,
      case
        when d.metric_name > 0 then 'ok'
        else 'alarm'
      end as status,
      case
        when d.metric_name > 0
          then 'Log metric and alert exist for SQL instance configuration changes.'
        else 'Log metric and alert do not exist for SQL instance configuration changes.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_project_sql}
    from
      gcp_project as p
      left join filter_data as d on d.project = p.name
  EOQ
}

query "logging_metric_alert_storage_iam_permission_changes" {
  sql = <<-EOQ
    with filter_data as (
      select
        m.project as project,
        display_name alert_name,
        count(m.name) metric_name
      from
        gcp_monitoring_alert_policy,
        jsonb_array_elements(conditions) as filter_condition
        join gcp_logging_metric m on m.filter ~ '\s*resource\.type\s*=\s*"gcs_bucket"\s*AND\s*protoPayload\.methodName\s*=\s*"storage\.setIamPermissions"'
        and filter_condition -> 'conditionThreshold' ->> 'filter' like '%metric.type="' || m.metric_descriptor_type || '"%'
      where
        enabled
      group by
        m.project, display_name, m.name
    )
    select
      'https://cloudresourcemanager.googleapis.com/v1/projects/' || project_id resource,
      case
        when d.metric_name > 0 then 'ok'
        else 'alarm'
      end as status,
      case
        when d.metric_name > 0
          then 'Log metric and alert exist for Storage IAM permission changes.'
        else 'Log metric and alert do not exist for Storage IAM permission changes.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_project_sql}
    from
      gcp_project as p
      left join filter_data as d on d.project = p.name;
  EOQ
}

query "logging_sink_configured_for_all_resource" {
  sql = <<-EOQ
    with project_sink_count as (
      select
        project,
        count(*) no_of_sink
      from
        gcp_logging_sink
      where
        filter = ''
        and destination != ''
      group by
        project
    )
    select
      'https://www.googleapis.com/logging/v2/projects/' || s.project resource,
      case
        when s.no_of_sink > 0 then 'ok'
        else 'alarm'
      end as status,
      case
        when s.no_of_sink > 0
          then 'Sinks configured for all log entries.'
        else 'Sinks not configured for all log entries.'
      end as reason
      ${replace(local.tag_dimensions_qualifier_sql, "__QUALIFIER__", "p.")}
      ${replace(local.common_dimensions_qualifier_project_sql, "__QUALIFIER__", "p.")}
    from
      gcp_project p
      left join project_sink_count s on s.project = p.project_id;
  EOQ
}
