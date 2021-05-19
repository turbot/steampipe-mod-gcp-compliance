select
  -- Required Columns
  i.self_link resource,
  case
    when m.common_instance_metadata -> 'items' is null or not(m.common_instance_metadata -> 'items' @> '[{"key":"enable-oslogin"}]') then 'alarm'
    when m.common_instance_metadata -> 'items' @> '[{"key":"enable-oslogin","value":"FALSE"}]' then 'alarm'
    when m.common_instance_metadata -> 'items' @> '[{"key":"enable-oslogin","value":"TRUE"}]' and i.metadata -> 'items' @> '[{"key":"enable-oslogin","value":"FALSE"}]' then 'alarm'
    else 'ok'
  end status,
  case
    when
      m.common_instance_metadata -> 'items' is null 
      or not(m.common_instance_metadata -> 'items' @> '[{"key":"enable-oslogin"}]') 
      or m.common_instance_metadata -> 'items' @> '[{"key": "enable-oslogin", "value": "FALSE"}]'
      then i.title || ' has OS login disabled at project level.'
    when m.common_instance_metadata -> 'items' @> '[{"key":"enable-oslogin","value":"TRUE"}]' and i.metadata -> 'items' @> '[{"key":"enable-oslogin","value":"FALSE"}]'
      then i.title || ' OS login settings is disabled.'
    when m.common_instance_metadata -> 'items' @> '[{"key":"enable-oslogin","value":"TRUE"}]' and i.metadata -> 'items' is null
      then i.title || ' inherits OS login settings from project level.'
    else i.title || ' OS login enabled.'
  end reason,
  -- Additional Dimensions
  i.location as location,
  i.project as project
from
  gcp_compute_instance i
  left join gcp_compute_project_metadata m on i.project = m.project;