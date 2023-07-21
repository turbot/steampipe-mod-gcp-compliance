query "logging_bucket_retention_policy_enabled" {
  sql = <<-EOQ
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
    join gcp_logging_sink s on (
      split_part(s.destination, '/', 1) = 'storage.googleapis.com'
      and split_part(s.destination, '/', 2) = b.name
    );
  EOQ
}

query "logging_metric_alert_audit_configuration_changes" {
  sql = <<-EOQ
    with filter_data as (
      select
        display_name alert_name,
        m.name metric_name
      from
        gcp_monitoring_alert_policy,
        jsonb_array_elements(conditions) as filter_condition
        join gcp_logging_metric m on m.filter ~ '\s*protoPayload.methodName\s*=\s*"SetIamPolicy"\s*AND\s*protoPayload.serviceData.policyDelta.auditConfigDeltas:\*\s*'
        and filter_condition -> 'conditionThreshold' ->> 'filter' like '%metric.type="' || m.metric_descriptor_type || '"%'
      where
        enabled
    )
    select
      'https://cloudresourcemanager.googleapis.com/v1/projects/' || project_id resource,
      case
        when (select count(metric_name) from filter_data) > 0 then 'ok'
        else 'alarm'
      end as status,
      case
        when (select count(metric_name) from filter_data) > 0
          then 'Log metric and alert exist for audit configuration changes.'
        else 'Log metric and alert do not exist for audit configuration changes.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_project_sql}
    from
      gcp_project;
  EOQ
}

query "logging_metric_alert_custom_role_changes" {
  sql = <<-EOQ
    with filter_data as (
      select
        display_name alert_name,
        m.name metric_name
      from
        gcp_monitoring_alert_policy,
        jsonb_array_elements(conditions) as filter_condition
        join gcp_logging_metric m on m.filter ~ '\s*resource.type\s*=\s*"iam_role"\s*AND\s*protoPayload.methodName\s*=\s*\"google.iam.admin.v1.CreateRole"\s*OR\s*protoPayload.methodName\s*=\s*"google.iam.admin.v1.DeleteRole"\s*OR\s*protoPayload.methodName\s*=\s*"google.iam.admin.v1.UpdateRole"\s*'
        and filter_condition -> 'conditionThreshold' ->> 'filter' like '%metric.type="' || m.metric_descriptor_type || '"%'
      where
        enabled
    )
    select
      'https://cloudresourcemanager.googleapis.com/v1/projects/' || project_id resource,
      case
        when (select count(metric_name) from filter_data) > 0 then 'ok'
        else 'alarm'
      end as status,
      case
        when (select count(metric_name) from filter_data) > 0
          then 'Log metric and alert exist for custom role changes.'
        else 'Log metric and alert do not exist for custom role changes.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_project_sql}
    from
      gcp_project;
  EOQ
}

query "logging_metric_alert_firewall_rule_changes" {
  sql = <<-EOQ
    with filter_data as (
      select
        display_name alert_name,
        m.name metric_name
      from
        gcp_monitoring_alert_policy,
        jsonb_array_elements(conditions) as filter_condition
        join gcp_logging_metric m on m.filter ~ '\s*resource.type\s*=\s*"gce_firewall_rule"\s*AND\s*protoPayload.methodName\s*=\s*"v1.compute.firewalls.patch"\s*OR\s*protoPayload.methodName\s*=\s*"v1.compute.firewalls.insert"\s*'
        and filter_condition -> 'conditionThreshold' ->> 'filter' like '%metric.type="' || m.metric_descriptor_type || '"%'
      where
        enabled
    )
    select
      'https://cloudresourcemanager.googleapis.com/v1/projects/' || project_id resource,
      case
        when (select count(metric_name) from filter_data) > 0 then 'ok'
        else 'alarm'
      end as status,
      case
        when (select count(metric_name) from filter_data) > 0
          then 'Log metric and alert exist for network firewall rule changes.'
        else 'Log metric and alert do not exist network for firewall rule changes.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_project_sql}
    from
      gcp_project;
  EOQ
}

query "logging_metric_alert_network_changes" {
  sql = <<-EOQ
    with filter_data as (
      select
        display_name alert_name,
        m.name metric_name
      from
        gcp_monitoring_alert_policy,
        jsonb_array_elements(conditions) as filter_condition
        join gcp_logging_metric m on m.filter ~ '\s*resource.type\s*=\s*gce_network\s*AND\s*protoPayload.methodName\s*=\s*"beta.compute.networks.insert"\s*OR\s*protoPayload.methodName\s*=\s*"beta.compute.networks.patch"\s*OR\s*protoPayload.methodName\s*=\s*"v1.compute.networks.delete"\s*OR\s*protoPayload.methodName\s*=\s*"v1.compute.networks.removePeering"\s*OR\s*protoPayload.methodName\s*=\s*"v1.compute.networks.addPeering"\s*'
        and filter_condition -> 'conditionThreshold' ->> 'filter' like '%metric.type="' || m.metric_descriptor_type || '"%'
      where
        enabled
    )
    select
      'https://cloudresourcemanager.googleapis.com/v1/projects/' || project_id resource,
      case
        when (select count(metric_name) from filter_data) > 0 then 'ok'
        else 'alarm'
      end as status,
      case
        when (select count(metric_name) from filter_data) > 0
          then 'Log metric and alert exist for network changes.'
        else 'Log metric and alert do not exist for network changes.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_project_sql}
    from
      gcp_project;
  EOQ
}

query "logging_metric_alert_network_route_changes" {
  sql = <<-EOQ
    with filter_data as (
      select
        display_name alert_name,
        m.name metric_name
      from
        gcp_monitoring_alert_policy,
        jsonb_array_elements(conditions) as filter_condition
        join gcp_logging_metric m on m.filter ~ '\s*resource.type\s*=\s*"gce_route"\s*AND\s*protoPayload.methodName\s*=\s*"beta.compute.routes.patch"\s*OR\s*protoPayload.methodName\s*=\s*"beta.compute.routes.insert"\s*'
        and filter_condition -> 'conditionThreshold' ->> 'filter' like '%metric.type="' || m.metric_descriptor_type || '"%'
      where
        enabled
    )
    select
      'https://cloudresourcemanager.googleapis.com/v1/projects/' || project_id resource,
      case
        when (select count(metric_name) from filter_data) > 0 then 'ok'
        else 'alarm'
      end as status,
      case
        when (select count(metric_name) from filter_data) > 0
          then 'Log metric and alert exist for network route changes.'
        else 'Log metric and alert do not exist for network route changes.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_project_sql}
    from
      gcp_project;
  EOQ
}

query "logging_metric_alert_project_ownership_assignment" {
  sql = <<-EOQ
    with filter_data as (
      select
        display_name alert_name,
        m.name metric_name
      from
        gcp_monitoring_alert_policy,
        jsonb_array_elements(conditions) as filter_condition
        join gcp_logging_metric m on m.filter ~ '\s*\(protoPayload.serviceName\s*=\s*"cloudresourcemanager.googleapis.com"\s*\)\s*AND\s*\(\s*ProjectOwnership\s*OR\s*projectOwnerInvitee\s*\)\s*OR\s*\(\s*protoPayload.serviceData.policyDelta.bindingDeltas.action\s*=\s*"REMOVE"\s*AND\s*protoPayload.serviceData.policyDelta.bindingDeltas.role\s*=\s*"roles/owner"\s*\)\s*OR\s*\(\s*protoPayload.serviceData.policyDelta.bindingDeltas.action\s*=\s*"ADD"\s*AND\s*protoPayload.serviceData.policyDelta.bindingDeltas.role\s*=\s*"roles/owner"\s*\)\s*'
        and filter_condition -> 'conditionThreshold' ->> 'filter' like '%metric.type="' || m.metric_descriptor_type || '"%'
      where
        enabled
    )
    select
      'https://cloudresourcemanager.googleapis.com/v1/projects/' || project_id resource,
      case
        when (select count(metric_name) from filter_data) > 0 then 'ok'
        else 'alarm'
      end as status,
      case
        when (select count(metric_name) from filter_data) > 0
          then 'Log metric and alert exist for project ownership assignments/changes.'
        else 'Log metric and alert do not exist exist for project ownership assignments/changes.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_project_sql}
    from
      gcp_project;
  EOQ
}

query "logging_metric_alert_sql_instance_configuration_changes" {
  sql = <<-EOQ
    with filter_data as (
      select
        display_name alert_name,
        m.name metric_name
      from
        gcp_monitoring_alert_policy,
        jsonb_array_elements(conditions) as filter_condition
        join gcp_logging_metric m on m.filter ~ '\s*protoPayload.methodName\s*=\s*"cloudsql.instances.update"\s*'
        and filter_condition -> 'conditionThreshold' ->> 'filter' like '%metric.type="' || m.metric_descriptor_type || '"%'
      where
        enabled
    )
    select
      'https://cloudresourcemanager.googleapis.com/v1/projects/' || project_id resource,
      case
        when (select count(metric_name) from filter_data) > 0 then 'ok'
        else 'alarm'
      end as status,
      case
        when (select count(metric_name) from filter_data) > 0
          then 'Log metric and alert exist for SQL instance configuration changes.'
        else 'Log metric and alert do not exist for SQL instance configuration changes.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_project_sql}
    from
      gcp_project;
  EOQ
}

query "logging_metric_alert_storage_iam_permission_changes" {
  sql = <<-EOQ
    with filter_data as (
      select
        display_name alert_name,
        m.name metric_name
      from
        gcp_monitoring_alert_policy,
        jsonb_array_elements(conditions) as filter_condition
        join gcp_logging_metric m on m.filter ~ '\s*resource.type\s*=\s*gcs_bucket\s*AND\s*protoPayload.methodName\s*=\s*"storage.setIamPermissions"\s*'
        and filter_condition -> 'conditionThreshold' ->> 'filter' like '%metric.type="' || m.metric_descriptor_type || '"%'
      where
        enabled
    )
    select
      'https://cloudresourcemanager.googleapis.com/v1/projects/' || project_id resource,
      case
        when (select count(metric_name) from filter_data) > 0 then 'ok'
        else 'alarm'
      end as status,
      case
        when (select count(metric_name) from filter_data) > 0
          then 'Log metric and alert exist for Storage IAM permission changes.'
        else 'Log metric and alert do not exist for Storage IAM permission changes.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_project_sql}
    from
      gcp_project;
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
  group by project
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
