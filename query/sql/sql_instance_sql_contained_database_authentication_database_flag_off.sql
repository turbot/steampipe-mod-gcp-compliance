select
  -- Required Columns
  self_link resource,
  case
    when database_version not like 'SQLSERVER%' then 'skip'
    when database_flags @> '[{"name":"contained database authentication","value":"off"}]' then 'ok'
    else 'alarm'
  end status,
  case
    when database_version not like 'SQLSERVER%'
      then title || ' not a SQL Server database.'
    when database_flags is null or not (database_flags @> '[{"name":"contained database authentication"}]')
      then title || ' ''contained database authentication'' not set.'
    when database_flags @> '[{"name":"contained database authentication","value":"off"}]'
      then title || ' ''contained database authentication'' database flag set to ''off''.'
    else title || ' ''contained database authentication'' database flag set to ''on''.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_sql_database_instance;