select
  -- Required Columns
  self_link resource,
  case
    when allowed @> '[{"IPProtocol":"tcp","ports":["80"]}]' and source_ranges ?& array['130.211.0.0/22', '35.191.0.0/16'] then 'ok'
    else 'alarm'
  end status,
  case
    when allowed @> '[{"IPProtocol":"tcp","ports":["80"]}]' and source_ranges ?& array['130.211.0.0/22', '35.191.0.0/16']
      then title || ' only allows traffic proxied by IAP.'
    else title || ' not configured to only allow connections proxied by IAP.'
  end reason,
  -- Additional Dimensions
  project
from
  gcp_compute_firewall;