select
  -- Required Columns
  self_link resource,
  case
    when iam_configuration_bucket_policy_only_enabled then 'ok'
    else 'alarm'
  end status,
  case
    when iam_configuration_bucket_policy_only_enabled
      then title || ' bucket only policy turned on.'
    else title || ' bucket only policy turned off'
  end reason,
  -- Additional Dimensions
  lower(location) as location,
  project
from
  gcp_storage_bucket;