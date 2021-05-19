with project_sink_count as (
  select
    count(*) no_of_sink,
    string_agg(project, ',') gcp_project
  from
    gcp_logging_sink
  where
    filter = ''
    and destination != ''
)
select
  -- Required Columns
  'https://www.googleapis.com/logging/v2/projects/' || split_part(s.gcp_project, ',', 1) resource,
  case
    when s.no_of_sink > 0 then 'ok'
    else 'alarm'
  end status,
  case
    when s.no_of_sink > 0
      then 'Sinks configured for all log entries.'
    else 'Sinks not configured for all log entries.'
  end reason,
  -- Additional Dimensions
  p.project as project
from
  gcp_iam_policy p
  left join project_sink_count s on split_part(s.gcp_project, ',', 1) = p.project;