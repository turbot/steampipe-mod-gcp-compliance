select
  -- Required Columns
  self_link resource,
  case
    when iam_configuration_uniform_bucket_level_access_enabled then 'ok'
    else 'alarm'
  end status,
  case
    when iam_configuration_uniform_bucket_level_access_enabled
      then title || ' uniform bucket-level access enabled.'
    else title || ' uniform bucket-level access not enabled.'
  end reason,
  -- Additional Dimensions
  lower(location) as location,
  project
from
  gcp_storage_bucket;