select
  -- Required Columns
  self_link resource,
  case
    when metadata -> 'items' @> '[{"key": "serial-port-enable", "value": "true"}]' then 'alarm'
    else 'ok'
  end status,
  case
    when metadata -> 'items' @> '[{"key": "serial-port-enable", "value": "true"}]'
      then title || ' serial port connections enabled.'
    else title || ' serial port connections disabled.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_compute_instance;