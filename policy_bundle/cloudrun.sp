locals {
  policy_bundle_cloudrun_common_tags = merge(local.gcp_compliance_common_tags, {
    service = "GCP/CloudRun"
  })
}

control "cloudrun_service_restrict_public_access" {
  title       = "Cloud Run service should restrict public access"
  description = "This control ensures that Cloud Run service is not publicly accessible."
  query       = query.cloudrun_service_restrict_public_access

  tags = local.policy_bundle_cloudrun_common_tags
}

query "cloudrun_service_restrict_public_access" {
  sql = <<-EOQ
    with publicly_accessible_cloudrun_services as (
      select
        self_link,
        p,
        entity
      from
        gcp_cloud_run_service,
        jsonb_array_elements(iam_policy -> 'bindings') as p,
        jsonb_array_elements_text(p -> 'members') as entity
      where
        entity in ('allAuthenticatedUsers', 'allUsers')
        and p ->> 'role' = 'roles/run.invoker'
    )
    select
      f.project as resource,
      case
        when b.self_link is not null then 'alarm'
        else 'ok'
      end as status,
      case
        when b.self_link is not null then f.title || ' publicly accessible.'
        else f.title || ' not publicly accessible.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_cloud_run_service as f
      left join publicly_accessible_cloudrun_services as b on f.self_link = b.self_link;
  EOQ
}
