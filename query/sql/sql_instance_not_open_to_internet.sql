select 
  -- Required Columns
  self_link as resource,
  case 
    when ip_configuration -> 'authorizedNetworks' @> '[{"name": "internet", "value": "0.0.0.0/0"}]' then 'alarm'
    else 'ok'
  end status,
  case 
    when ip_configuration -> 'authorizedNetworks' @> '[{"name": "internet", "value": "0.0.0.0/0"}]'
      then title || ' is open to internet.'
    else title || ' is not open to internet.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_sql_database_instance;