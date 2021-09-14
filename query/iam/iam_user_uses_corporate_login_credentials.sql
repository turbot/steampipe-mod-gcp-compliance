with user_with_acces as (
  select
    distinct split_part(m, ':', 2) as member,
    project
  from
    gcp_iam_policy,
    jsonb_array_elements(bindings) as b,
    jsonb_array_elements_text(b -> 'members') as m
  where
    m like 'user:%'
)
select
  -- Required Columns
  a.member as resource,
  case
    when org.display_name is null then 'alarm'
    else 'ok'
  end as status,
  case
    when org.display_name is null then a.member || ' uses non-corporate login credentials.'
    else a.member || ' uses corporate login credentials.'
  end as reason,
  -- Additional Dimensions
  a.project
from
  user_with_acces as a
  left join gcp_organization as org on split_part(a.member, '@', 2) = org.display_name;