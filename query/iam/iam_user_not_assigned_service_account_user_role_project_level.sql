with unapproved_bindings as (
  select
    project,
    p,
    entity
  from
    gcp_iam_policy,
    jsonb_array_elements(bindings) as p,
    jsonb_array_elements_text(p -> 'members') as entity
  where
    p ->> 'role' in ('roles/iam.serviceAccountTokenCreator','roles/iam.serviceAccountUser')
    and entity not like '%iam.gserviceaccount.com'
)
select
  p.project as resource,
  case
    when entity is not null then 'alarm'
    else 'ok'
  end status,
  case
    when entity is not null
      then 'IAM users associated with iam.serviceAccountTokenCreator or iam.serviceAccountUser role.'
    else 'No IAM users associated with iam.serviceAccountTokenCreator or iam.serviceAccountUser role.'
  end reason,
  p.project
from
  gcp_iam_policy as p
  left join unapproved_bindings as b on p.project = b.project
