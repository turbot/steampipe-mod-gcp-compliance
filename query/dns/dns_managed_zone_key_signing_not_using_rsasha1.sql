select
  -- Required Columns
  self_link resource,
  case
    when visibility = 'private' then 'skip'
    when dnssec_config_state is null then 'alarm'
    when dnssec_config_default_key_specs @> '[{"keyType": "keySigning", "algorithm": "rsasha1"}]' then 'alarm'
    else 'ok'
  end status,
  case
    when visibility = 'private'
      then title || ' is private.'
    when dnssec_config_state is null
      then title || ' DNSSEC not enabled.'
    when dnssec_config_default_key_specs @> '[{"keyType": "keySigning", "algorithm": "rsasha1"}]'
      then title || ' using RSASHA1 algorithm for key-signing.'
    else title || ' not using RSASHA1 algorithm for key-signing.'
  end reason,
  -- Additional Dimensions
  project
from
  gcp_dns_managed_zone;