with associated_networks as (
  select
    split_part(network ->> 'networkUrl', 'networks/', 2) network_name,
    enable_logging
  from
    gcp_dns_policy,
    jsonb_array_elements(networks) network
)
select
  -- Required Columns
  net.self_link resource,
  case
    when p.network_name is null then 'alarm'
    when not p.enable_logging then 'alarm'
    else 'ok'
  end status,
  case
    when p.network_name is null then net.title || ' not associated with DNS policy.'
    when not p.enable_logging then net.title || ' associated with DNS policy with logging disabled.'
    else net.title || ' associated with DNS policy with logging enabled.'
  end reason,
  -- Additional Dimensions
  project
from
  gcp_compute_network net
left join associated_networks p on net.name = p.network_name;