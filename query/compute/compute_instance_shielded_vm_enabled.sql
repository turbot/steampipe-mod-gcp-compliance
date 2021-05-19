select
  -- Required Columns
  self_link resource,
  case
    when shielded_instance_config @> '{"enableVtpm": true, "enableIntegrityMonitoring": true}' then 'ok'
    else 'alarm'
  end status,
  case
    when shielded_instance_config @> '{"enableVtpm": true, "enableIntegrityMonitoring": true}'
      then title || ' shielded VM enabled.'
    else title || ' shielded VM not enabled.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_compute_instance;