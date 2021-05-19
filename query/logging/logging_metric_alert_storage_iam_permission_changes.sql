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
  -- Required Columns
  project resource,
  case
    when (select count(metric_name) from filter_data) > 0 then 'ok'
    else 'alarm'
  end status,
  case
    when (select count(metric_name) from filter_data) > 0
      then 'Log metric and alert exist for Storage IAM permission changes.'
    else 'Log metric and alert do not exist for Storage IAM permission changes.'
  end reason,
  -- Additional Dimensions
  project
from
  gcp_iam_policy;