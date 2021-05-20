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
  -- Required Columns
  'https://cloudresourcemanager.googleapis.com/v1/projects/' || project_id resource,
  case
    when (select count(metric_name) from filter_data) > 0 then 'ok'
    else 'alarm'
  end status,
  case
    when (select count(metric_name) from filter_data) > 0
      then 'Log metric and alert exist for SQL instance configuration changes.'
    else 'Log metric and alert do not exist for SQL instance configuration changes.'
  end reason,
  -- Additional Dimensions
  project_id
from
  gcp_project;