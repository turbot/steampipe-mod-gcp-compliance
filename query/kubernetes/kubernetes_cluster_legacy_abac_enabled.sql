select
  -- Required Columns
  self_link resource,
  case
    when legacy_abac_enabled then 'alarm'
    else 'ok'
  end status,
  case
    when legacy_abac_enabled then title || ' Legacy Authorization enabled.'
    else title || ' Legacy Authorization disabled.'
  end reason,
  -- Additional Dimensions
  project
from
  gcp_kubernetes_cluster;