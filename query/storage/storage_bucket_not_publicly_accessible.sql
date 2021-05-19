select
  -- Required Columns
  self_link resource,
  case
    when iam_policy ->> 'bindings' like any (array ['%allAuthenticatedUsers%','%allUsers%']) then 'alarm'
    else 'ok'
  end status,
  case
    when iam_policy ->> 'bindings' like any (array ['%allAuthenticatedUsers%','%allUsers%'])
      then title || ' publicly accessible.'
    else title || ' not publicly accessible.'
  end reason,
  -- Additional Dimensions
  lower(location) as location,
  project
from
  gcp_storage_bucket;