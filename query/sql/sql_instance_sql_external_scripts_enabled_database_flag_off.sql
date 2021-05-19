select
  -- Required Columns
  self_link resource,
  case
    when database_version not like 'SQLSERVER%' then 'skip'
    when database_flags @> '[{"name":"external scripts enabled","value":"off"}]' then 'ok'
    else 'alarm'
  end status,
  case
    when database_version not like 'SQLSERVER%'
      then title || ' not a SQL Server database.'
    when database_flags is null or not (database_flags @> '[{"name":"external scripts enabled"}]')
      then title || ' ''external scripts enabled'' not set.'
    when database_flags @> '[{"name":"external scripts enabled","value":"off"}]'
      then title || ' ''external scripts enabled'' database flag set to ''off''.'
    else title || ' ''external scripts enabled'' database flag set to ''on''.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_sql_database_instance;