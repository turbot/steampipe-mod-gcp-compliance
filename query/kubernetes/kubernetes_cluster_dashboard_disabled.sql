 select
  -- Required Columns
  self_link resource,
  case
    when addons_config -> 'kubernetesDashboard' ->> 'disabled' = 'true' then 'ok'
    else 'alarm'
  end status,
  case
    when addons_config -> 'kubernetesDashboard' ->> 'disabled' = 'true' then title || ' dashboard disabled.'
    else title || ' dashboard enabled.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_kubernetes_cluster;