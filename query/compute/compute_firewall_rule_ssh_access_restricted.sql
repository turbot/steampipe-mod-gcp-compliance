with ip_protocol_all as (
  select
    name
  from
    gcp_compute_firewall
  where
    direction = 'INGRESS'
    and action = 'Allow'
    and source_ranges ?& array['0.0.0.0/0']
    and (allowed @> '[{"IPProtocol":"all"}]' or allowed::text like '%{"IPProtocol": "tcp"}%')
),
ip_protocol_tcp as (
  select
    name
  from
    gcp_compute_firewall,
    jsonb_array_elements(allowed) as p,
    jsonb_array_elements_text(p -> 'ports') as port
  where
    direction = 'INGRESS'
    and action = 'Allow'
    and source_ranges ?& array['0.0.0.0/0']
    and p ->> 'IPProtocol' = 'tcp'
    and (
      port = '22'
      or (
        port like '%-%'
        and split_part(port, '-', 1) :: integer <= 22
        and split_part(port, '-', 2) :: integer >= 22
      )
    )
)
select
  -- Required Columns
  self_link resource,
  case
    when name in (select name from ip_protocol_tcp) then 'alarm'
    when name in (select name from ip_protocol_all) then 'alarm'
    else 'ok'
  end status,
  case
    when name in (select name from ip_protocol_tcp) or name in (select name from ip_protocol_all)
      then title || ' allows SSH access from internet.'
    else title || ' restricts SSH access from internet.'
  end reason,
  -- Additional Dimensions
  project
from
  gcp_compute_firewall;