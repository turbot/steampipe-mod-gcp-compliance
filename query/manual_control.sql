select
  -- Required Columns
  'https://cloudresourcemanager.googleapis.com/v1/projects/' || project as resource,
  'info' as status,
  'This is a manual control, you must verify compliance manually.' as reason,
  -- Additional Dimensions
  project
from
  gcp_iam_policy;