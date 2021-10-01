 select
  -- Required Columns
  self_link resource,
  case
    when node_config -> 'metadata' ->> 'disable-legacy-endpoints' = 'true' then 'ok'
    else 'alarm'
  end status,
  case
    when node_config -> 'metadata' ->> 'disable-legacy-endpoints' = 'true' then title || ' legacy endpoints disabled.'
    else title || ' legacy endpoints enabled.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_kubernetes_cluster;