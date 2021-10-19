select
  -- Required Columns
  self_link resource,
  case
    when log_config_enable then 'ok'
    else 'alarm'
  end status,
  case
    when log_config_enable
      then title || ' logging enabled.'
    else title || ' logging disabled.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_compute_firewall;