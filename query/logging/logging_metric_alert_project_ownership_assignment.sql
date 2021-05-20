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
  -- Required Columns
  project_id resource,
  case
    when (select count(metric_name) from filter_data) > 0 then 'ok'
    else 'alarm'
  end status,
  case
    when (select count(metric_name) from filter_data) > 0
      then 'Log metric and alert exist for project ownership assignments/changes.'
    else 'Log metric and alert do not exist exist for project ownership assignments/changes.'
  end reason,
  -- Additional Dimensions
  project_id
from
  gcp_project;