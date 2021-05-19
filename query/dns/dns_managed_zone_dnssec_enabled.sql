select 
  -- Required Columns
  self_link resource,
  case
    when visibility = 'private' then 'skip'
    when visibility = 'public' and (dnssec_config_state is null or dnssec_config_state = 'off') then 'alarm'
    else 'ok'
  end status,
  case
    when visibility = 'private'
      then title || ' is private.'
    when visibility = 'public' and (dnssec_config_state is null or dnssec_config_state = 'off')
      then title || ' DNSSEC not enabled.'
    else title || ' DNSSEC enabled.'
  end reason,
  -- Additional Dimensions
  project
from
  gcp_dns_managed_zone;