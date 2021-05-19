select
  -- Required Columns
  s.self_link resource,
  case
    when b.retention_policy is not null and b.retention_policy ->> 'isLocked' = 'true' then 'ok'
    else 'alarm'
  end status,
  case
    when b.retention_policy is not null and b.retention_policy ->> 'isLocked' = 'true'
      then s.title || '''s logging bucket ' || b.name || ' has retention policies configured.'
    else s.title || '''s logging bucket ' || b.name || ' has retention policies not configured.'
  end reason,
  -- Additional Dimensions
  s.project as project
from
  gcp_storage_bucket b
join gcp_logging_sink s on (
  split_part(s.destination, '/', 1) = 'storage.googleapis.com'
  and split_part(s.destination, '/', 2) = b.name
);