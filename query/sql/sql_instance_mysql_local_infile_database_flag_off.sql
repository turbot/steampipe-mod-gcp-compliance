select
  -- Required Columns
  self_link resource,
  case
    when database_version not like 'MYSQL%' then 'skip'
    when database_flags @> '[{"name":"local_infile","value":"off"}]' then 'ok'
    else 'alarm'
  end status,
  case
    when database_version not like 'MYSQL%'
      then title || ' not a MySQL database.'
    when database_flags is null or not (database_flags @> '[{"name":"local_infile"}]')
      then title || ' ''local_infile'' database flag not set.'
    when database_flags @> '[{"name":"local_infile","value":"off"}]'
      then title || ' ''local_infile'' database flag set to ''off''.'
    else title || ' ''local_infile'' database flag set to ''on''.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_sql_database_instance;