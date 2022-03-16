select
  -- Required Columns
  self_link resource,
  case
    when private_cluster_config is null then 'alarm'
    else 'ok'
  end status,
  case
    when private_cluster_config is null then title || ' private cluster config disabled.'
    else title || ' private cluster config enabled.'
  end reason,
  -- Additional Dimensions
  project
from
  gcp_kubernetes_cluster;