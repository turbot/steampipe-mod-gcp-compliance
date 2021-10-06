with user_with_acces as (
  select
    distinct project
  from
    gcp_iam_policy,
    jsonb_array_elements(bindings) as b,
    jsonb_array_elements_text(b -> 'members') as m
  where
    m like 'allUsers'
)
select
  -- Required Columns
  a.project as resource,
  case
    when b.project is null then 'ok'
    else 'alarm'
  end as status,
  case
    when b.project is null then 'No public users have access to resources via IAM.'
    else 'Public users have access to resources via IAM.'
  end as reason,
  -- Additional Dimensions
  a.project,
  a.title
from
  gcp_iam_policy as a
  left join user_with_acces as b on a.project = b.project;