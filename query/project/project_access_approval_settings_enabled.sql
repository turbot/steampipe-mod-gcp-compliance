select
  -- Required Columns
  self_link as resource,
  case
    when access_approval_settings is not null and access_approval_settings -> 'notificationEmails' is not null then 'ok'
    else 'alarm'
  end status,
  case
    when access_approval_settings is not null and access_approval_settings -> 'notificationEmails' is not null
      then name || ' access approval is enabled.'
    else name || ' access approval is disabled.'
  end reason,
  -- Additional Dimensions
  project_id
from
  gcp_project;