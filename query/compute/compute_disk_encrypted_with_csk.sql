select
  -- Required Columns
  self_link resource,
  case
    when disk_encryption_key_type = 'Customer supplied' then 'ok'
    else 'alarm'
  end status,
  case
    when disk_encryption_key_type = 'Customer supplied'
      then title || ' encrypted with customer-supplied encryption keys (CSEK).'
    when disk_encryption_key_type = 'Customer managed'
      then title || ' encrypted with customer-managed encryption keys.'
    else title || ' encrypted with default Google-managed keys.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_compute_disk;