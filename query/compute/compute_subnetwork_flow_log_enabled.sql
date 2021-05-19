select
  -- Required Columns
  self_link resource,
  case
    when enable_flow_logs then 'ok'
    else 'alarm'
  end status,
  case
    when enable_flow_logs
      then title || ' flow logging enabled.'
    else title || ' flow logging disabled.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_compute_subnetwork;