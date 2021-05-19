select
  -- Required Columns
  self_link resource,
  case
    when database_version not like 'POSTGRES%' then 'skip'
    when database_flags @> '[{"name":"log_min_duration_statement","value":"-1"}]' then 'ok'
    else 'alarm'
  end status,
  case
    when database_version not like 'POSTGRES%'
      then title || ' not a PostgreSQL database.'
    when database_flags is null or not (database_flags @> '[{"name":"log_min_duration_statement"}]')
      then title || ' ''log_min_duration_statement'' database flag not set.'
    when database_flags @> '[{"name":"log_min_duration_statement","value":"-1"}]'
      then title || ' ''log_min_duration_statement'' database flag disabled.'
    else title || ' ''log_min_duration_statement'' database flag enabled.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_sql_database_instance;