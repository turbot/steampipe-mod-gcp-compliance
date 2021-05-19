select 
  -- Required Columns
  self_link resource,
  case
    when ip_addresses @> '[{"type": "PRIMARY"}]' and backend_type = 'SECOND_GEN' then 'alarm'
    else 'ok'
  end status,
  case
    when ip_addresses @> '[{"type": "PRIMARY"}]' and backend_type = 'SECOND_GEN' 
      then title || ' associated with public IPs.'
    else title || ' not associated with public IPs.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_sql_database_instance;