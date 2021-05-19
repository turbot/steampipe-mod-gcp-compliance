select
  -- Required Columns
  self_link resource,
  case
    when database_version not like 'SQLSERVER%' then 'skip'
    when database_flags @> '[{"name":"user connections"}]' then 'ok'
    else 'alarm'
  end status,
  case
    when database_version not like 'SQLSERVER%'
      then title || ' not a SQL Server database.'
    when database_flags @> '[{"name":"user connections"}]'
      then title || ' ''user connections'' database flag set.'
    else title || ' ''user connections'' database flag not set.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_sql_database_instance;