select
  -- Required Columns
  self_link resource,
  case
    when name = 'default' then 'alarm'
    else 'ok'
  end status,
  case
    when name = 'default'
      then title || ' is a default network.'
    else title || ' not a default network.'
  end reason,
  -- Additional Dimensions
  project
from
  gcp_compute_network;