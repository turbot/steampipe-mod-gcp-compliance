select
  -- Required Columns
  cluster_name resource,
  case
    when config -> 'encryptionConfig' ->> 'gcePdKmsKeyName' is null then 'alarm'
    else 'ok'
  end status,
  case
    when config -> 'encryptionConfig' ->> 'gcePdKmsKeyName' is null
      then title || ' is not encrypted using customer-managed encryption keys (CMEK).'
    else title || ' is encrypted using customer-managed encryption keys (CMEK).'
  end reason,
  -- Additional Dimensions
  project
from
  gcp_dataproc_cluster;