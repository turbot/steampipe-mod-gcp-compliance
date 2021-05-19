select
  -- Required Columns
  self_link resource,
  case
    when database_version not like 'POSTGRES%' then 'skip'
    when database_flags @> '[{"name":"log_min_error_statement"}]' then 'ok'
    else 'alarm'
  end status,
  case
    when database_version not like 'POSTGRES%'
      then title || ' not a PostgreSQL database.'
    when database_flags @> '[{"name":"log_min_error_statement"}]'
      then title || ' ''log_min_error_statement'' database flag set.'
    else title || ' ''log_min_error_statement'' database flag not set.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_sql_database_instance;