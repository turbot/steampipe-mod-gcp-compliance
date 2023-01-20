select
  -- Required Columns
  m.self_link as resource,
  case
    when s.self_link is null then 'skip'
    when s.log_config_enable then 'ok'
    else 'alarm'
  end as status,
  case
    when s.self_link is null then m.name || ' uses backend bucket.'
    when s.log_config_enable then m.name || ' logging enabled.'
    else m.name || ' logging disabled.'
  end as reason,
  -- Additional Dimensions
  m.location,
  m.project
from
  gcp_compute_url_map as m
  left join gcp_compute_backend_service as s on s.self_link = m.default_service;