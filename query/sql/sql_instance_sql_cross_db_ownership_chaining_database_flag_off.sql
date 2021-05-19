select
  -- Required Columns
  self_link resource,
  case
    when database_version not like 'SQLSERVER%' then 'skip'
    when database_flags @> '[{"name":"cross db ownership chaining","value":"off"}]' then 'ok'
    else 'alarm'
  end status,
  case
    when database_version not like 'SQLSERVER%'
      then title || ' not a SQL Server database.'
    when database_flags is null or not (database_flags @> '[{"name":"cross db ownership chaining"}]')
      then title || ' ''cross db ownership chaining'' not set.'
    when database_flags @> '[{"name":"cross db ownership chaining","value":"off"}]'
      then title || ' ''cross db ownership chaining'' database flag set to ''off''.'
    else title || ' ''cross db ownership chaining'' database flag set to ''on''.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_sql_database_instance;