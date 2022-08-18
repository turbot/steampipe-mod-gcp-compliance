select
  -- Required Columns
  name as resource,
  case
    when state = 'ENABLED' then 'ok'
    else 'alarm'
  end status,
  case
    when state = 'ENABLED'
      then name || ' Cloud Asset API is enabled.'
    else name || ' Cloud Asset API is disabled.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_project_service
where
  name = 'cloudasset.googleapis.com';