with dataset_access as (
  select 
    distinct dataset_id
    from 
    gcp_bigquery_dataset,
    jsonb_array_elements(access) as a
    where
    a ->> 'userByEmail' like '%gmail.com'
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
      then a.dataset_id || ' gmail.com addresses do not have access to BigQuery datasets'
    else 
     a.dataset_id || ' gmail.com addresses have access to BigQuery datasets'
  end as reason,
  -- Additional Dimensions
  a.project
from
  gcp_bigquery_dataset as a
  left join dataset_access as b on a.dataset_id = b.dataset_id;