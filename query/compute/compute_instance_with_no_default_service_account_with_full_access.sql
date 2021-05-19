select
  -- Required Columns
  self_link resource,
  case
    when name like 'gke-%' and labels ? 'goog-gke-node' then 'skip'
    when account ->> 'email' like '%-compute@developer.gserviceaccount.com' and account -> 'scopes' ? 'https://www.googleapis.com/auth/cloud-platform' then 'alarm'
    else 'ok'
  end status,
  case
    when name like 'gke-%' and labels ? 'goog-gke-node'
      then title || ' created by GKE.'
    when account ->> 'email' like '%-compute@developer.gserviceaccount.com' and account -> 'scopes' ? 'https://www.googleapis.com/auth/cloud-platform'
      then title || ' configured with default service account with full access.'
    else title || ' not configured with default service account with full access.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_compute_instance,
  jsonb_array_elements(service_accounts) account;