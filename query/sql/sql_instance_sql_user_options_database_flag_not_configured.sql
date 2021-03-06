select
  -- Required Columns
  self_link resource,
  case
    when database_version not like 'SQLSERVER%' then 'skip'
    when database_flags @> '[{"name":"user options"}]' then 'alarm'
    else 'ok'
  end status,
  case
    when database_version not like 'SQLSERVER%'
      then title || ' not a SQL Server database.'
    when database_flags @> '[{"name":"user options"}]'
      then title || ' ''user options'' database flag set.'
    else title || ' ''user options'' database flag not set.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_sql_database_instance;