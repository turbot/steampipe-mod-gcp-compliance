locals {
  policy_bundle_project_common_tags = merge(local.gcp_compliance_common_tags, {
    service = "GCP/Project"
  })
}

control "project_access_approval_settings_enabled" {
  title       = "Ensure 'Access Approval' is 'Enabled'"
  description = "GCP Access Approval enables you to require your organizations' explicit approval whenever Google support try to access your projects. You can then select users within your organization who can approve these requests through giving them a security role in IAM. All access requests display which Google Employee requested them in an email or Pub/Sub message that you can choose to Approve. This adds an additional control and logging of who in your organization approved/denied these requests."
  query       = query.project_access_approval_settings_enabled

  tags = local.policy_bundle_project_common_tags
}

control "project_service_cloudasset_api_enabled" {
  title       = "Ensure Cloud Asset Inventory is Enabled"
  description = "GCP Cloud Asset Inventory is services that provides a historical view of GCP resources and IAM policies through a time-series database. The information recorded includes metadata on Google Cloud resources, metadata on policies set on Google Cloud projects or resources, and runtime information gathered within a Google Cloud resource."
  query       = query.project_service_cloudasset_api_enabled

  tags = local.policy_bundle_project_common_tags
}

control "project_no_api_key" {
  title       = "Project should not have use api keys"
  description = "API keys are best reserved for situations where no alternative authentication methods are available. Within a project, there may be lingering, unused keys that still retain their permissions. The inherent insecurity of keys arises from their susceptibility to public exposure, either through web browsers or when residing on a device. It is advisable to prioritize the adoption of conventional authentication mechanisms over the reliance on API keys."
  query       = query.project_no_api_key

  tags = local.policy_bundle_project_common_tags
}

control "project_service_container_scanning_api_enabled" {
  title       = "Ensure container vulnerability scanning is enabled"
  description = "Container Vulnerability Scanning in Google Cloud Platform (GCP) refers to a security service that automatically performs vulnerability detection on container images stored in Container Registry and Artifact Registry. This service is designed to identify known security vulnerabilities in your container images."
  query       = query.project_service_container_scanning_api_enabled

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

query "project_no_api_key" {
  sql = <<-EOQ
    with project_api_key as (
      select
        project,
        count(*) as api_key_count
      from
        gcp_apikeys_key
      group by
        project
    )
    select
      p.self_link as resource,
      case
        when k.api_key_count > 0  then 'alarm'
        else 'ok'
      end as status,
      case
        when k.api_key_count > 0 then p.name || ' has ' ||  k.api_key_count || ' api key(s).'
        else p.name || ' has no api key(s).'
      end as reason
      ${local.common_dimensions_project_sql}
    from
      gcp_project as p
      left join project_api_key as k on k.project = p.project_id;
  EOQ
}

query "project_service_container_scanning_api_enabled" {
  sql = <<-EOQ
    select
      name as resource,
      case
        when state = 'ENABLED' then 'ok'
        else 'alarm'
      end as status,
      case
        when state = 'ENABLED'
          then name || ' container scanning API is enabled.'
        else name || ' container scanning API is disabled.'
      end as reason
      --${local.common_dimensions_sql}
    from
      gcp_project_service
    where
      name = 'containerscanning.googleapis.com';
  EOQ
}
