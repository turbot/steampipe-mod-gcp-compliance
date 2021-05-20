with user_roles as (
select
  distinct split_part(entity, ':', 2) as user_name
from
  gcp_iam_policy,
  jsonb_array_elements(bindings) as p,
  jsonb_array_elements_text(p -> 'members') as entity
where
  p ->> 'role' like any (array ['%admin','%Admin','%Editor','%Owner','%editor','%owner'])
  and split_part(entity, ':', 2) like '%@' || project || '.iam.gserviceaccount.com'
)
select
  -- Required Columns
  'https://iam.googleapis.com/v1/projects/' || project || '/serviceAccounts/' || name as resource,
  case
    when name not like '%@' || project || '.iam.gserviceaccount.com' then 'skip'
    when name in (select user_name from user_roles) then 'alarm'
    else 'ok'
  end status,
  case
    when name not like '%@' || project || '.iam.gserviceaccount.com' then 'Google-created service account ' || title || ' excluded.'
    when name in (select user_name from user_roles) then title || ' has admin privileges.'
    else title || ' has no admin privileges.'
  end reason,
  -- Additional Dimensions
  project
from
  gcp_service_account;
