 select
  -- Required Columns
  self_link resource,
  case
    when node_config ->> 'serviceAccount' = 'default' then 'alarm'
    else 'ok'
  end status,
  case
    when node_config ->> 'serviceAccount' = 'default' then title || ' default service account is used for project access.'
    else title || ' default service account is not used for project access.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_kubernetes_cluster;