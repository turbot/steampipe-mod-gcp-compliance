 select
  -- Required Columns
  self_link resource,
  case
    when ip_allocation_policy ->> 'useIpAliases' = 'true' then 'ok'
    else 'alarm'
  end status,
  case
    when ip_allocation_policy ->> 'useIpAliases' = 'true' then title || ' Alias IP ranges enabled.'
    else title || ' alias IP ranges disabled.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_kubernetes_cluster;