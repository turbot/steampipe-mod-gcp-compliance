select
  -- Required Columns
  self_link resource,
  case
    when name like 'gke-%' and labels ? 'goog-gke-node' then 'skip'
    when can_ip_forward then 'alarm'
    else 'ok'
  end status,
  case
    when name like 'gke-%' and labels ? 'goog-gke-node'
      then title || ' created by GKE.'
    when can_ip_forward
      then title || ' IP forwarding enabled.'
    else title || ' IP forwarding not enabled.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_compute_instance;
