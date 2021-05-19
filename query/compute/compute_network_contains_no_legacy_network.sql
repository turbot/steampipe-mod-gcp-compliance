select
  -- Required Columns
  self_link resource,
  case
    when ipv4_range is not null then 'alarm'
    else 'ok'
  end status,
  case
    when ipv4_range is not null
      then title || ' is a legacy network.'
    else title || ' not a legacy network.'
  end reason,
  -- Additional Dimensions
  project
from
  gcp_compute_network;