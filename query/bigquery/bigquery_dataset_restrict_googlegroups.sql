with dataset_access as (
  select 
    distinct dataset_id
    from 
    gcp_bigquery_dataset,
    jsonb_array_elements(access) as a
    where
    a ->> 'userByEmail' like '%googlegroups.com'
)
select
  -- Required Columns
    a.dataset_id as resource,
  case
    when b.dataset_id is null then 'ok'
    else 'alarm'
  end as status,
  case
    when b.dataset_id is null
      then a.dataset_id || ' enforces corporate domain by banning googlegroups.com addresses access.'
    else 
     a.dataset_id || ' does not enforce corporate domain by banning googlegroups.com addresses access.'
  end as reason,
  -- Additional Dimensions
  a.project
from
  gcp_bigquery_dataset as a
  left join dataset_access as b on a.dataset_id = b.dataset_id;