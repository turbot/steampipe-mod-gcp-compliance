select
  -- Required Columns
  self_link resource,
  case
    when kms_key_name is null then 'alarm'
    else 'ok'
  end status,
  case
    when kms_key_name is null
      then title || ' encrypted with Google-managed cryptographic keys.'
    else title || ' encrypted with customer-managed encryption keys.'
  end reason,
  -- Additional Dimensions
  lower(location) as location,
  project
from
  gcp_bigquery_dataset;