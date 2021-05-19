select
  -- Required Columns
  self_link resource,
  case
    when database_version not like 'MYSQL%' then 'skip'
    when database_flags @> '[{"name":"skip_show_database","value":"on"}]' then 'ok'
    else 'alarm'
  end status,
  case
    when database_version not like 'MYSQL%'
      then title || ' not a MySQL database.'
    when database_flags is null or not (database_flags @> '[{"name":"skip_show_database"}]')
      then title || ' ''skip_show_database'' database flag not set.'
    when database_flags @> '[{"name":"skip_show_database","value":"on"}]'
      then title || ' ''skip_show_database'' database flag set to ''on''.'
    else title || ' ''skip_show_database'' database flag set to ''off''.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_sql_database_instance;