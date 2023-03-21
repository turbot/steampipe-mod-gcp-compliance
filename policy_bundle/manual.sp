query "manual_control" {
  sql = <<-EOQ
    select
      -- Required Columns
      'https://cloudresourcemanager.googleapis.com/v1/projects/' || project_id resource,
      'info' status,
      'Manual verification required.' reason
      -- Additional Dimensions
      ${local.common_dimensions_project_sql}
    from
      gcp_project;
  EOQ
}
