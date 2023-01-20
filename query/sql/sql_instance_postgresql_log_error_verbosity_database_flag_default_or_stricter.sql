select 
  -- Required Columns
  self_link as resource,
  case
    when database_version not like 'POSTGRES%' then 'skip'
    when database_flags @> '[{"name": "log_error_verbosity","value":"default"}]' or database_flags @> '[{"name": "log_error_verbosity","value":"verbose"}]' then 'ok'
    else 'alarm'
  end as status,
  case
    when database_version not like 'POSTGRES%' then title || ' not a PostgreSQL database.'
    when database_flags @> '[{"name": "log_error_verbosity","value":"default"}]' then title || ' log_error_verbosity database flag set to DEFAULT.'
    when database_flags @> '[{"name": "log_error_verbosity","value":"verbose"}]' then title || ' log_error_verbosity database flag set to VERBOSE.'
    when database_flags @> '[{"name": "log_error_verbosity","value":"terse"}]' then title || ' log_error_verbosity database flag set to TERSE.'
    else title || ' log_error_verbosity database flag not set.'
  end as reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_sql_database_instance;
