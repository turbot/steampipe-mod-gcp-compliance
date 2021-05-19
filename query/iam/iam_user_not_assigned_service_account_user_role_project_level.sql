select
  -- Required Columns
  split_part(string_agg(project, ', '), ',', 1 ) as resource,
  case
    when count(*) > 1 then 'alarm'
    else 'ok'
  end status,
  case
    when count(*) > 1
      then 'IAM users associated with ''iam.serviceAccountTokenCreator'' or ''iam.serviceAccountUser'' role.'
    else 'No IAM users associated with ''iam.serviceAccountTokenCreator'' or ''iam.serviceAccountUser'' role.'
  end reason,
  -- Additional Dimensions
  split_part(string_agg(project, ', '), ',', 1 )
from
  gcp_iam_policy,
  jsonb_array_elements(bindings) as p,
  jsonb_array_elements_text(p -> 'members') as entity
where
  p ->> 'role' in ('roles/iam.serviceAccountTokenCreator','roles/iam.serviceAccountUser')
  and entity not like '%iam.gserviceaccount.com';
