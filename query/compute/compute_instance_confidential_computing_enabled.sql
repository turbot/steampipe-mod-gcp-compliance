select
  -- Required Columns
  self_link resource,
  case
    when confidential_instance_config @> '{"enableConfidentialCompute": true}' then 'ok'
    else 'alarm'
  end status,
  case
    when confidential_instance_config @> '{"enableConfidentialCompute": true}'
      then title || ' confidential computing enabled.'
    else title || ' confidential computing not enabled.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_compute_instance;