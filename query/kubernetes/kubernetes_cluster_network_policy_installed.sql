select
  -- Required Columns
  self_link resource,
  case
    when network_policy is not null then 'ok'
    else 'alarm'
  end status,
  case
    when network_policy is not null then title || ' network policy defined.'
    else title || ' network policy not defined.'
  end reason,
  -- Additional Dimensions
  project
from
  gcp_kubernetes_cluster;