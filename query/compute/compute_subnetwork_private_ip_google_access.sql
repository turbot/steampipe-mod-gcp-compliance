select
  -- Required Columns
  self_link resource,
  case
    when private_ip_google_access then 'ok'
    else 'alarm'
  end status,
  case
    when private_ip_google_access then title || ' private Google Access is enabled.'
    else title || ' private Google Access is disabled.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_compute_subnetwork;