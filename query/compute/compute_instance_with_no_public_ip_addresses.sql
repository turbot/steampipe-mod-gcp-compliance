with instance_without_access_config as (
  select
    name
  from
    gcp_compute_instance,
    jsonb_array_elements(network_interfaces) nic
  where
    nic ->> 'accessConfigs' is null
),
instance_with_access_config as (
  select
    name
  from
    gcp_compute_instance,
    jsonb_array_elements(network_interfaces) nic,
    jsonb_array_elements(nic -> 'accessConfigs') d
  where
    d ->> 'natIP' is null
)
select
  -- Required Columns
  self_link resource,
  case
    when name like 'gke-%' and labels ? 'goog-gke-node' then 'skip'
    when name in (select name from instance_without_access_config) then 'ok'
    when name in (select name from instance_with_access_config) then 'ok'
    else 'alarm'
  end status,
  case
    when name like 'gke-%' and labels ? 'goog-gke-node'
      then title || ' created by GKE.'
    when name in (select name from instance_without_access_config) or name in (select name from instance_with_access_config)
      then title || ' not associated with public IP addresses.'
    else title || ' associated with public IP addresses.'
  end reason,
  -- Additional Dimensions
  location,
  project
from
  gcp_compute_instance;