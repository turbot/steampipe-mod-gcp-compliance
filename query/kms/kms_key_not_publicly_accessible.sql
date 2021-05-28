with public_keys as (
  select
    distinct self_link
  from
    gcp_kms_key,
    jsonb_array_elements(iam_policy -> 'bindings') as b
  where
    b -> 'members' ?| array['allAuthenticatedUsers', 'allUsers']
)
select
  k.self_link as resource,
  case
    when p.self_link is null then 'ok'
    else 'alarm'
  end as status,
  case
    when p.self_link is null then title || ' in ' || k.key_ring_name || ' key ring not publicly accessible.'
    else title || ' in ' || k.key_ring_name || ' key ring publicly accessible.'
  end as reason
from
  gcp_kms_key k
left join public_keys p on k.self_link = p.self_link;