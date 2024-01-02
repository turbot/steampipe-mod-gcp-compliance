locals {
  policy_bundle_cloudfunction_common_tags = merge(local.gcp_compliance_common_tags, {
    service = "GCP/CloudFunctions"
  })
}

control "cloudfunction_function_vpc_connector_enabled" {
  title       = "Cloudfunction functions VPC connector should be enabled"
  description = "It is recommended that Cloudfunction functions VPC connector is enabled."
  query       = query.cloudfunction_function_vpc_connector_enabled

  tags = local.policy_bundle_cloudfunction_common_tags
}

control "cloudfunction_function_no_ingress_settings_allow_all" {
  title       = "Cloudfunction functions ingress settings should not be set to allow all"
  description = "It is recommended that Cloudfunction functions ingress settings should not be set to `allow all` as it allow all inbound requests to the function."
  query       = query.cloudfunction_function_no_ingress_settings_allow_all

  tags = local.policy_bundle_cloudfunction_common_tags
}

control "cloudfunction_function_restricted_permission" {
  title       = "Cloudfunction functions no roles/editor or roles/owner permission"
  description = "It is recommended that Cloudfunction functions should not have roles/editor or roles/owner permission."
  query       = query.cloudfunction_function_restricted_permission

  tags = local.policy_bundle_cloudfunction_common_tags
}

control "cloudfunction_function_restrict_public_access" {
  title       = "Cloudfunction functions should restrict public access"
  description = "This is control ensures that Cloudfunction function is not publicly accessible."
  query       = query.cloudfunction_function_restrict_public_access

  tags = local.policy_bundle_cloudfunction_common_tags
}

control "cloudfunction_function_no_deployments_manager_permission" {
  title       = "Cloudfunction functions should restrict deployments manager permission"
  description = "This is control ensures that Cloudfunction function does not allow deployments manager permissions."
  query       = query.cloudfunction_function_no_deployments_manager_permission

  tags = local.policy_bundle_cloudfunction_common_tags
}

control "cloudfunction_function_no_disrupt_logging_permission" {
  title       = "Cloudfunction functions should restrict disrupt logging permission"
  description = "This is control ensures that Cloudfunction function does not disrupt logging permissions."
  query       = query.cloudfunction_function_no_disrupt_logging_permission

  tags = local.policy_bundle_cloudfunction_common_tags
}

query "cloudfunction_function_vpc_connector_enabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when vpc_connector is null or vpc_connector = '' then 'alarm'
        else 'ok'
      end as status,
      case
        when vpc_connector is null or vpc_connector = '' then name || ' VPC connector disabled.'
        else name || ' VPC connector enabled.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_cloudfunctions_function;
  EOQ
}

query "cloudfunction_function_no_ingress_settings_allow_all" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when ingress_settings  = 'ALLOW_ALL' then 'alarm'
        else 'ok'
      end as status,
      case
        when ingress_settings = 'ALLOW_ALL' then name || ' ingress settings is set to allow all.'
        else name || ' ingress settings is not set to allow all.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_cloudfunctions_function;
  EOQ
}

query "cloudfunction_function_restricted_permission" {
  sql = <<-EOQ
    with unapproved_bindings as (
      select
        project,
        p,
        entity
      from
        gcp_iam_policy,
        jsonb_array_elements(bindings) as p,
        jsonb_array_elements_text(p -> 'members') as entity
      where
        p ->> 'role' in ('roles/editor','roles/owner')
    )
    select
      f.project as resource,
      case
        when f.service_account_email is not null then 'alarm'
        else 'ok'
      end as status,
      case
        when f.service_account_email is not null then f.title || ' allow roles/editor or roles/owner permission.'
        else f.title || ' restrict roles/editor and roles/owner permision permission.'
      end as reason
      ${replace(local.common_dimensions_qualifier_global_sql, "__QUALIFIER__", "f.")}
      ${replace(local.common_dimensions_qualifier_global_sql, "__QUALIFIER__", "f.")}
    from
      gcp_cloudfunctions_function as f
      left join unapproved_bindings as b on f.project = b.project and b.entity = concat('serviceAccount:' || f.service_account_email);
  EOQ
}

query "cloudfunction_function_restrict_public_access" {
  sql = <<-EOQ
    with publicly_accessible_functions as (
      select
        self_link
      from
        gcp_cloudfunctions_function,
        jsonb_array_elements(iam_policy -> 'bindings') as p,
        jsonb_array_elements_text(p -> 'members') as entity
      where
        entity in ('allAuthenticatedUsers', 'allUsers')
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
      gcp_cloudfunctions_function as f
      left join publicly_accessible_functions as b on f.self_link = b.self_link;
  EOQ
}

query "cloudfunction_function_no_deployments_manager_permission" {
  sql = <<-EOQ
    with role_with_deployments_manager_permission as (
      select
        distinct name,
        project
      from
        gcp_iam_role,
        jsonb_array_elements_text(included_permissions) as p
      where
        not is_gcp_managed
        and p  in ('deploymentmanager.deployments.create', 'deploymentmanager.deployments.update' )
      ), policy_with_deployments_manager_permission as (
      select
        distinct entity,
        project
      from
        gcp_iam_policy,
        jsonb_array_elements(bindings) as p,
        jsonb_array_elements_text(p -> 'members') as entity
      where
        p ->> 'role' in ('roles/deploymentmanager.editor' )
        or p ->> 'role' in (select name from role_with_deployments_manager_permission )
    )
    select
      f.project as resource,
      case
        when f.service_account_email is not null then 'alarm'
        else 'ok'
      end as status,
      case
        when f.service_account_email is not null then f.title || ' allow deployment managers permission.'
        else f.title || ' restrict deployment managers permission'
      end as reason
      ${replace(local.common_dimensions_qualifier_global_sql, "__QUALIFIER__", "f.")}
      ${replace(local.common_dimensions_qualifier_global_sql, "__QUALIFIER__", "f.")}
    from
      gcp_cloudfunctions_function as f
      left join policy_with_deployments_manager_permission as b on f.project = b.project and b.entity = concat('serviceAccount:' || f.service_account_email);
  EOQ
}

query "cloudfunction_function_no_disrupt_logging_permission" {
  sql = <<-EOQ
    with role_with_disrupt_logging_permission as (
      select
        distinct name,
        project
      from
        gcp_iam_role,
        jsonb_array_elements_text(included_permissions) as p
      where
        not is_gcp_managed
        and p  in ('logging.buckets.delete', 'logging.buckets.update', 'logging.logMetrics.delete', 'logging.logMetrics.update', 'logging.logs.delete', 'logging.sinks.delete', 'logging.sinks.update' )
      ), policy_with_disrupt_logging_permission as (
      select
        distinct entity,
        project
      from
        gcp_iam_policy,
        jsonb_array_elements(bindings) as p,
        jsonb_array_elements_text(p -> 'members') as entity
      where
        p ->> 'role' in ('roles/logging.bucketWriter', 'roles/logging.configWriter', 'roles/logging.admin' )
        or p ->> 'role' in (select name from role_with_disrupt_logging_permission )
    )
    select
      f.project as resource,
      case
        when f.service_account_email is not null then 'alarm'
        else 'ok'
      end as status,
      case
        when f.service_account_email is not null then f.title || ' allow disrupt logging permission.'
        else f.title || ' restrict disrupt logging permission'
      end as reason
      ${replace(local.common_dimensions_qualifier_global_sql, "__QUALIFIER__", "f.")}
      ${replace(local.common_dimensions_qualifier_global_sql, "__QUALIFIER__", "f.")}
    from
      gcp_cloudfunctions_function as f
      left join policy_with_disrupt_logging_permission as b on f.project = b.project and b.entity = concat('serviceAccount:' || f.service_account_email);
  EOQ
}