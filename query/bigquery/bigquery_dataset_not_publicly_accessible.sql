select
  -- Required Columns
  self_link resource,
  case
    when access @> '[{"specialGroup": "allAuthenticatedUsers"}]' or access @> '[{"iamMember": "allUsers"}]' then 'alarm'
    else 'ok'
  end status,
  case
    when access @> '[{"specialGroup": "allAuthenticatedUsers"}]' or access @> '[{"iamMember": "allUsers"}]'
      then title || ' publicly accessible.'
    else title || ' not anonymously or publicly accessible.'
  end reason,
  -- Additional Dimensions
  lower(location) as location,
  project
from
  gcp_bigquery_dataset;