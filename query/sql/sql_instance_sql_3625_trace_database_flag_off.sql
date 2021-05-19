select
  -- Required Columns
  self_link resource,
  case
    when database_version not like 'SQLSERVER%' then 'skip'
    when database_flags @> '[{"name":"3625","value":"off"}]' then 'ok'
    else 'alarm'
  end status,
  case
    when database_version not like 'SQLSERVER%'
      then title || ' not a SQL Server database.'
    when database_flags is null or not (database_flags @> '[{"name":"3625"}]')
      then title || ' ''3625 (trace flag)'' not set.'
    when database_flags @> '[{"name":"3625","value":"off"}]'
      then title || ' ''3625 (trace flag)'' database flag set to ''off''.'
    else title || ' ''3625 (trace flag)'' database flag set to ''on''.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_sql_database_instance;