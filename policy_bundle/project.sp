locals {
  policy_bundle_project_common_tags = merge(local.gcp_compliance_common_tags, {
    service = "GCP/Project"
  })
}

control "project_access_approval_settings_enabled" {
  title         = "Ensure 'Access Approval' is 'Enabled'"
  description   = "GCP Access Approval enables you to require your organizations' explicit approval whenever Google support try to access your projects. You can then select users within your organization who can approve these requests through giving them a security role in IAM. All access requests display which Google Employee requested them in an email or Pub/Sub message that you can choose to Approve. This adds an additional control and logging of who in your organization approved/denied these requests."
  query = query.project_access_approval_settings_enabled

  tags = local.policy_bundle_project_common_tags
}

control "project_service_cloudasset_api_enabled" {
  title         = "Ensure Cloud Asset Inventory Is Enabled"
  description   = "GCP Cloud Asset Inventory is services that provides a historical view of GCP resources and IAM policies through a time-series database. The information recorded includes metadata on Google Cloud resources, metadata on policies set on Google Cloud projects or resources, and runtime information gathered within a Google Cloud resource."
  query = query.project_service_cloudasset_api_enabled

  tags = local.policy_bundle_project_common_tags
}

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
