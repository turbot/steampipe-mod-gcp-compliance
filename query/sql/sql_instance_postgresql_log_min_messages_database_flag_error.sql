select 
  -- Required Columns
  self_link as resource,
  case
    when database_version not like 'POSTGRES%' then 'skip'
    when database_flags is null or not (database_flags @> '[{"name":"log_min_messages"}]') then 'alarm'
    when database_flags @> '[{"name":"log_min_messages","value":"error"}]' or database_flags @> '[{"name":"log_min_messages","value":"warning"}]' then 'ok'
    else 'alarm'
  end as status,
  case
    when database_version not like 'POSTGRES%' then title || ' not a PostgreSQL database.'
    when database_flags is null or not (database_flags @> '[{"name":"log_min_messages"}]') then title || ' log_min_messages database flag not set.'
    when database_flags @> '[{"name":"log_min_messages","value":"error"}]' then title || ' log_min_messages database flag set to ERROR.'
    when database_flags @> '[{"name":"log_min_messages","value":"warning"}]' then title || ' log_min_messages database flag set to WARNING.'
    else title || ' log_min_messages database flag not set at minimum to WARNING.'
  end as reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_sql_database_instance;