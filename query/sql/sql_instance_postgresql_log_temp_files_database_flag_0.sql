select
  -- Required Columns
  self_link resource,
  case
    when database_version not like 'POSTGRES%' then 'skip'
    when database_flags @> '[{"name":"log_temp_files","value":"0"}]' then 'ok'
    else 'alarm'
  end status,
  case
    when database_version not like 'POSTGRES%'
      then title || ' not a PostgreSQL database.'
    when database_flags is null or not (database_flags @> '[{"name":"log_temp_files"}]')
      then title || ' ''log_temp_files'' database flag not set.'
    when database_flags @> '[{"name":"log_temp_files","value":"0"}]'
      then title || ' ''log_temp_files'' database flag set to ''0''.'
    else title || ' ''log_temp_files'' database flag not set to ''0''.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_sql_database_instance;