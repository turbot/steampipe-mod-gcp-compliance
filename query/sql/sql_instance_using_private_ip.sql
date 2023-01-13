select 
  -- Required Columns
  self_link resource,
  case
    when (ip_addresses @> '[{"type": "PRIVATE"}]' and ip_configuration->>'privateNetwork' is not null) and not (ip_addresses @> '[{"type": "PRIMARY"}]') then 'ok'
    else 'alarm'
  end status,
  case
    when (ip_addresses @> '[{"type": "PRIVATE"}]' and ip_configuration->>'privateNetwork' is not null) and not (ip_addresses @> '[{"type": "PRIMARY"}]')  then title || ' associated with private IP.'
    when (ip_addresses @> '[{"type": "PRIVATE"}]' and ip_configuration->>'privateNetwork' is not null) and (ip_addresses @> '[{"type": "PRIMARY"}]')  then title || ' associated with both private and public IPs.'
    else title || ' not associated with private IP.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_sql_database_instance;