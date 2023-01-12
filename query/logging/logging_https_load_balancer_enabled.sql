select
  -- Required Columns
  self_link as resource,
  case
    when log_config_enable then 'ok'
    else 'alarm'
  end status,
  case
    when log_config_enable then name || ' logging on HTTP(S) Load Balancer is enabled.'
    else name || ' logging on HTTP(S) Load Balancer is disabled.'
  end reason,
  -- Additional Dimensions
  project
from
  gcp_compute_backend_service
where
  protocol = 'HTTP';