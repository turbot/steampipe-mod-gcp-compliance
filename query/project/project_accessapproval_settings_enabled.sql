select
  -- Required Columns
  self_link as resource,
  case
    when access_approval is not null and access_approval -> 'notificationEmails' is not null then 'ok'
    else 'alarm'
  end status,
  case
    when access_approval is not null and access_approval -> 'notificationEmails' is not null
      then name || ' access approval is enabled.'
    else name || ' access approval is disabled.'
  end reason,
  -- Additional Dimensions
  project_id
from
  gcp_project;