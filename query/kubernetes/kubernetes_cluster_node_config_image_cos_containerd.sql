 select
  -- Required Columns
  self_link resource,
  case
    when node_config ->> 'imageType' = 'COS_CONTAINERD' then 'ok'
    else 'alarm'
  end status,
  case
    when node_config ->> 'imageType' = 'COS_CONTAINERD' then title || ' Container-Optimized OS(COS) is used.'
    else title || ' Container-Optimized OS(COS) not used.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_kubernetes_cluster;