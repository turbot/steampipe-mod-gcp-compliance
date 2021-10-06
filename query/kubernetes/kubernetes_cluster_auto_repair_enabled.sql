 select
  -- Required Columns
  self_link resource,
  case
    when np -> 'management' -> 'autoRepair' = 'true' then 'ok'
    else 'alarm'
  end status,
  case
    when np -> 'management' -> 'autoRepair' = 'true' then title || ' Node pool auto repair enabled.'
    else title || ' Node pool auto repair disabled.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_kubernetes_cluster,
  jsonb_array_elements(node_pools) as np;