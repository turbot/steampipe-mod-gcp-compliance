select 
  -- Required Columns
  self_link as resource,
  case
    when database_version not like 'POSTGRES%' then 'skip'
    when database_flags is null or not (database_flags @> '[{"name":"log_statement"}]') then 'alarm'
    when database_flags @> '[{"name": "log_statement","value":"ddl"}]' then 'ok'
    else 'alarm'
  end as status,
  case
    when database_version not like 'POSTGRES%' then title || ' not a PostgreSQL database.'
    when database_flags is null or not (database_flags @> '[{"name":"log_statement"}]') then title || ' log_statement database flag not set.'
    when database_flags @> '[{"name": "log_statement","value":"ddl"}]' then title || ' log_statement database flag set to ddl.'
    when database_flags @> '[{"name": "log_statement","value":"mod"}]' then title || ' log_statement database flag set to mod.'
    when database_flags @> '[{"name": "log_statement","value":"all"}]' then title || ' log_statement database flag set to all.'
    when database_flags @> '[{"name": "log_statement","value":"none"}]' then title || ' log_statement database flag set to none.'
  end as reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_sql_database_instance;