select 
  -- Required Columns
  self_link resource,
  case
    when ip_configuration -> 'requireSsl' is null then 'alarm'
    else 'ok'
  end status,
  case
    when ip_configuration -> 'requireSsl' is null
      then title || ' does not enforce SSL connections.'
    else title || ' enforces SSL connections.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_sql_database_instance;