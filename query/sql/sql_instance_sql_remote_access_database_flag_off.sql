select
  -- Required Columns
  self_link resource,
  case
    when database_version not like 'SQLSERVER%' then 'skip'
    when database_flags @> '[{"name":"remote access","value":"off"}]' then 'ok'
    else 'alarm'
  end status,
  case
    when database_version not like 'SQLSERVER%'
      then title || ' not a SQL Server database.'
    when database_flags is null or not (database_flags @> '[{"name":"remote access"}]')
      then title || ' ''remote access'' not set.'
    when database_flags @> '[{"name":"remote access","value":"off"}]'
      then title || ' ''remote access'' database flag set to ''off''.'
    else title || ' ''remote access'' database flag set to ''on''.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_sql_database_instance;