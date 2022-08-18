select
  -- Required Columns
  self_link resource,
  case
    when database_version not like 'POSTGRES%' then 'skip'
    when database_flags @> '[{"name":"cloudsql.enable_pgaudit","value":"on"}]' then 'ok'
    else 'alarm'
  end status,
  case
    when database_version not like 'POSTGRES%'
      then title || ' not a PostgreSQL database.'
    when database_flags is null or not (database_flags @> '[{"name":"cloudsql.enable_pgaudit"}]')
      then title || ' ''cloudsql.enable_pgaudit'' database flag not set.'
    when database_flags @> '[{"name":"cloudsql.enable_pgaudit","value":"on"}]'
      then title || ' ''cloudsql.enable_pgaudit'' database flag enabled.'
    else title || ' ''cloudsql.enable_pgaudit'' database flag disabled.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_sql_database_instance;