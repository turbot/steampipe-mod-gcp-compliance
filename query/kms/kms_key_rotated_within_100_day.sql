select
  -- Required Columns
  self_link as resource,
  case
    when split_part(rotation_period, 's', 1) :: int <= 8640000 then 'ok'
    else 'alarm'
  end as status,
  case
    when rotation_period is null then title || ' in ' || key_ring_name || ' requires manual rotation.'
    else key_ring_name || ' ' || title || ' rotation period set for ' || (split_part(rotation_period, 's', 1) :: int)/86400 || ' day(s).'
  end as reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_kms_key;