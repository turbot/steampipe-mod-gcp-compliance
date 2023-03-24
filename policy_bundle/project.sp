query "project_access_approval_settings_enabled" {
  sql = <<-EOQ
    select
      self_link as resource,
      case
        when access_approval_settings is not null and access_approval_settings -> 'notificationEmails' is not null then 'ok'
        else 'alarm'
      end as status,
      case
        when access_approval_settings is not null and access_approval_settings -> 'notificationEmails' is not null
          then name || ' access approval is enabled.'
        else name || ' access approval is disabled.'
      end as reason
      ${local.common_dimensions_project_sql}
    from
      gcp_project;
  EOQ
}

query "project_service_cloudasset_api_enabled" {
  sql = <<-EOQ
    select
      name as resource,
      case
        when state = 'ENABLED' then 'ok'
        else 'alarm'
      end as status,
      case
        when state = 'ENABLED'
          then name || ' Cloud Asset API is enabled.'
        else name || ' Cloud Asset API is disabled.'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_project_service
    where
      name = 'cloudasset.googleapis.com';
  EOQ
}
