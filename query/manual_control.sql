select
  -- Required Columns
  'https://cloudresourcemanager.googleapis.com/v1/projects/' || project_id resource,
  'info' status,
  'This is a manual control, you must verify compliance manually.' reason,
  -- Additional Dimensions
  project_id
from
  gcp_project;