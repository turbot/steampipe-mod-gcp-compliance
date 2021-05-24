select
  -- Required Columns
  'https://cloudresourcemanager.googleapis.com/v1/projects/' || project_id resource,
  'info' status,
  'Manual verification required.' reason,
  -- Additional Dimensions
  project_id
from
  gcp_project;
