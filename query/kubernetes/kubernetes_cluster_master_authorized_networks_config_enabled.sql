 select
  -- Required Columns
  self_link resource,
  case
    when master_authorized_networks_config -> 'enabled' = 'true' then 'ok'
    else 'alarm'
  end status,
  case
    when master_authorized_networks_config -> 'enabled' = 'true' then title || ' master authorized networks is enabled.'
    else title || ' master authorized networks is disabled.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_kubernetes_cluster;