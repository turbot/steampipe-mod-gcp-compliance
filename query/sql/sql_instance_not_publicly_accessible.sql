select 
  -- Required Columns
  self_link as resource,
  case
    when (ip_addresses @> '[{"type": "PRIVATE"}]' and ip_configuration ->> 'privateNetwork' is not null) and not (ip_addresses @> '[{"type": "PRIMARY"}]') then 'ok'
    else 'alarm'
  end as status,
  case
    when (ip_addresses @> '[{"type": "PRIVATE"}]' and ip_configuration ->> 'privateNetwork' is not null) and not (ip_addresses @> '[{"type": "PRIMARY"}]') then title || ' not publicly accessible.'
    else title || ' publicly accessible.'
  end as reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_sql_database_instance;