select
  -- Required Columns
  self_link resource,
  case
    when name like 'gke-%' and labels ? 'goog-gke-node' then 'skip'
    when metadata -> 'items' @> '[{"key": "block-project-ssh-keys", "value": "true"}]' then 'ok'
    else 'alarm'
  end status,
  case
    when name like 'gke-%' and labels ? 'goog-gke-node'
      then title || ' created by GKE.'
    when metadata -> 'items' @> '[{"key": "block-project-ssh-keys", "value": "true"}]'
      then title || ' has "Block Project-wide SSH keys" enabled.'
    else title || ' has "Block Project-wide SSH keys" disabled.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_compute_instance;