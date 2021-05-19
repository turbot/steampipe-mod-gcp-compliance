with service_account_key as (
  select
    distinct service_account_name
  from
    gcp_service_account_key
  where
    key_type = 'USER_MANAGED'
)
select
  -- Required Columns
  'https://iam.googleapis.com/v1/projects/' || project || '/serviceAccounts/' || name as resource,
  case
    when name like '%iam.gserviceaccount.com' and name in (select service_account_name from service_account_key) then 'alarm'
    else 'ok'
  end status,
  case
    when name like '%iam.gserviceaccount.com' and name in (select service_account_name from service_account_key)
      then title || ' has user-managed keys.'
    else title || ' does not have user-managed keys.'
  end reason,
  -- Additional Dimensions
  project
from
  gcp_service_account;
