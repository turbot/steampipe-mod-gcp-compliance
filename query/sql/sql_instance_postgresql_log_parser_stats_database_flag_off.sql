select
  -- Required Columns
  self_link resource,
  case
    when database_version not like 'POSTGRES%' then 'skip'
    when database_flags @> '[{"name":"log_parser_stats","value":"off"}]' then 'ok'
    else 'alarm'
  end status,
  case
    when database_version not like 'POSTGRES%' 
      then title || ' not a PostgreSQL database.'
    when database_flags is null or not (database_flags @> '[{"name":"log_parser_stats"}]')
      then title || ' ''log_parser_stats'' database flag not set.'
    when database_flags @> '[{"name":"log_parser_stats","value":"off"}]'
      then title || ' ''log_parser_stats'' database flag set to ''off''.'
    else title || ' ''log_parser_stats'' database flag set to ''on''.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_sql_database_instance;