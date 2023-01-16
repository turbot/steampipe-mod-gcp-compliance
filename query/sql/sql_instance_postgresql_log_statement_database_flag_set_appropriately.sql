select 
  -- Required Columns
  self_link resource,
  case
    when database_flags is null or not (database_flags @> '[{"name":"log_statement"}]') then 'alarm'
    when database_flags @> '[{"name": "log_statement","value":"ddl"}]' then 'ok'
    else 'alarm'
  end status,
  case
    when database_flags is null or not (database_flags @> '[{"name":"log_statement"}]') then title || ' log_statement database flag not set.'
    when database_flags @> '[{"name": "log_statement","value":"ddl"}]' then title || ' log_statement database flag set to ddl.'
    else title || ' log_statement database flag not set to ddl.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_sql_database_instance;