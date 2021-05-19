select
  -- Required Columns
  self_link resource,
  case
    when backup_enabled then 'ok'
    else 'alarm'
  end status,
  case
    when backup_enabled
      then title || ' automatic backups configured.'
    else title || ' automatic backups not configured.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_sql_database_instance;