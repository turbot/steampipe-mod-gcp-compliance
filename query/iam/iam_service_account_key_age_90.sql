select
  -- Required Columns
  'https://iam.googleapis.com/v1/projects/' || project || '/serviceAccounts/' || service_account_name || '/keys/' || name as resource,
  case
    when valid_after_time <= (current_date - interval '90' day) then 'alarm'
    else 'ok'
  end status,
  service_account_name || ' ' || name || ' created ' || to_char(valid_after_time , 'DD-Mon-YYYY') ||
    ' (' || extract(day from current_timestamp - valid_after_time) || ' days).'
  as reason,
  -- Additional Dimensions
  project
from
  gcp_service_account_key
where
  key_type = 'USER_MANAGED';
