select
  -- Required Columns
  self_link resource,
  case
    when name like 'gke-%' and labels ? 'goog-gke-node' then 'skip'
    when account ->> 'email' like '%-compute@developer.gserviceaccount.com' then 'alarm'
    else 'ok'
  end status,
  case
    when name like 'gke-%' and labels ? 'goog-gke-node'
      then title || ' created by GKE.'
    when account ->> 'email' like '%-compute@developer.gserviceaccount.com'
      then title || ' configured to use default service account.'
    else title || ' not configured with default service account.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_compute_instance,
  jsonb_array_elements(service_accounts) account;