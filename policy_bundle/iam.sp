locals {
  policy_bundle_iam_common_tags = merge(local.gcp_compliance_common_tags, {
    service = "GCP/IAM"
  })
}

control "denylist_public_users" {
  title = "Prevent public users from having access to resources via IAM"
  query = query.iam_user_denylist_public

  tags = merge(local.policy_bundle_iam_common_tags, {
    cft_scorecard_v1      = "true"
    forseti_security_v226 = "true"
    severity              = "high"
  })
}

control "only_my_domain" {
  title = "Only allow members from my domain to be added to IAM roles"
  query = query.iam_user_uses_corporate_login_credentials

  tags = merge(local.policy_bundle_iam_common_tags, {
    forseti_security_v226 = "true"
    severity              = "high"
  })
}

control "iam_restrict_service_account_key_age_one_hundred_days" {
  title = "Check if service account keys are older than 100 days"
  query = query.iam_service_account_key_age_100

  tags = merge(local.policy_bundle_iam_common_tags, {
    forseti_security_v226 = "true"
    severity              = "high"
  })
}

control "iam_service_account_gcp_managed_key" {
  title       = "Ensure that there are only GCP-managed service account keys for each service account"
  description = "User managed service accounts should not have user-managed keys."
  query       = query.iam_service_account_gcp_managed_key

  tags = local.policy_bundle_iam_common_tags
}

control "iam_service_account_key_age_90" {
  title       = "Ensure user-managed/external keys for service accounts are rotated every 90 days or less"
  description = "Service Account keys consist of a key ID (Private_key_Id) and Private key, which are used to sign programmatic requests users make to Google cloud services accessible to that particular service account. It is recommended that all Service Account keys are regularly rotated."
  query       = query.iam_service_account_key_age_90

  tags = local.policy_bundle_iam_common_tags
}

control "iam_api_key_age_90" {
  title       = "Ensure API keys are rotated every 90 days"
  description = "It is recommended to rotate API keys every 90 days."
  query       = query.iam_api_key_age_90

  tags = merge(local.cis_v120_1_common_tags, {
    nist_csf_v10 = "true"
  })
}

control "iam_api_key_restricts_apis" {
  title       = "Ensure API keys are restricted to only APIs that application needs access"
  description = "API keys are insecure because they can be viewed publicly, such as from within a browser, or they can be accessed on a device where the key resides. It is recommended to restrict API keys to use (call) only APIs required by an application."
  query       = query.iam_api_key_restricts_apis

  tags = merge(local.cis_v120_1_common_tags, {
    nist_csf_v10 = "true"
  })
}

control "iam_api_key_restricts_websites_hosts_apps" {
  title       = "Ensure API keys are restricted to use by only specified Hosts and Apps"
  description = "Unrestricted keys are insecure because they can be viewed publicly, such as from within a browser, or they can be accessed on a device where the key resides. It is recommended to restrict API key usage to trusted hosts, HTTP referrers and apps."
  query       = query.iam_api_key_restricts_websites_hosts_apps

  tags = local.policy_bundle_iam_common_tags
}

control "iam_service_account_without_admin_privilege" {
  title       = "Ensure that Service Account has no Admin privileges"
  description = "A service account is a special Google account that belongs to an application or a VM, instead of to an individual end-user. The application uses the service account to call the service's Google API so that users aren't directly involved. It's recommended not to use admin access for ServiceAccount."
  query       = query.iam_service_account_without_admin_privilege

  tags = merge(local.policy_bundle_iam_common_tags, {
    nist_csf_v10 = "true"
  })
}

control "iam_user_not_assigned_service_account_user_role_project_level" {
  title       = "Ensure that IAM users are not assigned the Service Account User or Service Account Token Creator roles at project level"
  description = "It is recommended to assign the Service Account User (iam.serviceAccountUser) and Service Account Token Creator (iam.serviceAccountTokenCreator) roles to a user for a specific service account rather than assigning the role to a user at project level."
  query       = query.iam_user_not_assigned_service_account_user_role_project_level

  tags = merge(local.policy_bundle_iam_common_tags, {
    hipaa        = "true"
    nist_csf_v10 = "true"
    pci_dss_v321 = "true"
  })
}

control "iam_user_separation_of_duty_enforced" {
  title       = "Ensure that Separation of duties is enforced while assigning service account related roles to users"
  description = "It is recommended that the principle of 'Separation of Duties' is enforced while assigning service-account related roles to users."
  query       = query.iam_user_separation_of_duty_enforced

  tags = merge(local.policy_bundle_iam_common_tags, {
    nist_csf_v10 = "true"
  })
}

control "iam_user_kms_separation_of_duty_enforced" {
  title       = "Ensure that Separation of duties is enforced while assigning KMS related roles to users"
  description = "It is recommended that the principle of 'Separation of Duties' is enforced while assigning KMS related roles to users."
  query       = query.iam_user_kms_separation_of_duty_enforced

  tags = local.policy_bundle_iam_common_tags
}

query "iam_user_denylist_public" {
  sql = <<-EOQ
    with user_with_acces as (
      select
        distinct project
      from
        gcp_iam_policy,
        jsonb_array_elements(bindings) as b,
        jsonb_array_elements_text(b -> 'members') as m
      where
        m like 'allUsers'
    )
    select
      a.project as resource,
      case
        when b.project is null then 'ok'
        else 'alarm'
      end as status,
      case
        when b.project is null then 'No public users have access to resources via IAM.'
        else 'Public users have access to resources via IAM.'
      end as reason
      ${replace(local.common_dimensions_qualifier_global_sql, "__QUALIFIER__", "a.")}
    from
      gcp_iam_policy as a
      left join user_with_acces as b on a.project = b.project;
  EOQ
}

query "iam_user_uses_corporate_login_credentials" {
  sql = <<-EOQ
    -- Please note: The table gcp_organization requires the resourcemanager.organizations.get permission to retrieve organization details.
    with user_with_access as (
      select
        distinct split_part(m, ':', 2) as member,
        project,
        _ctx,
        location
      from
        gcp_iam_policy,
        jsonb_array_elements(bindings) as b,
        jsonb_array_elements_text(b -> 'members') as m
      where
        m like 'user:%'
    )
    select
      case when (select count(*) from gcp_organization) = 0 then a.project else a.member end as resource,
      case
        when (select count(*) from gcp_organization) = 0 then 'info'
        when org.display_name is null then 'alarm'
        else 'ok'
      end as status,
      case
        when (select count(*) from gcp_organization) = 0 then 'Plugin authentication mechanism does not have organization viewer permission.'
        when org.display_name is null then a.member || ' uses non-corporate login credentials.'
        else a.member || ' uses corporate login credentials.'
      end as reason
      ${replace(local.common_dimensions_qualifier_global_sql, "__QUALIFIER__", "a.")}
    from
      user_with_access as a
      left join gcp_organization as org on split_part(a.member, '@', 2) = org.display_name
      limit case when (select count(*) from gcp_organization) = 0 then 1 end;
  EOQ
}

query "iam_service_account_key_age_100" {
  sql = <<-EOQ
    select
      'https://iam.googleapis.com/v1/projects/' || project || '/serviceAccounts/' || service_account_name || '/keys/' || name as resource,
    case
      when valid_after_time <= (current_date - interval '100' day) then 'alarm'
      else 'ok'
    end as status,
    service_account_name || ' ' || name || ' created ' || to_char(valid_after_time , 'DD-Mon-YYYY') ||
      ' (' || extract(day from current_timestamp - valid_after_time) || ' days).'
    as reason
    ${local.common_dimensions_global_sql}
  from
    gcp_service_account_key;
  EOQ
}

query "iam_service_account_gcp_managed_key" {
  sql = <<-EOQ
    with service_account_key as (
      select
        distinct service_account_name
      from
        gcp_service_account_key
      where
        key_type = 'USER_MANAGED'
    )
    select
      'https://iam.googleapis.com/v1/projects/' || project || '/serviceAccounts/' || name as resource,
      case
        when name like '%iam.gserviceaccount.com' and name in (select service_account_name from service_account_key) then 'alarm'
        else 'ok'
      end as status,
      case
        when name like '%iam.gserviceaccount.com' and name in (select service_account_name from service_account_key)
          then title || ' has user-managed keys.'
        else title || ' does not have user-managed keys.'
      end as reason
      ${local.common_dimensions_global_sql}
    from
      gcp_service_account;
  EOQ
}

query "iam_service_account_key_age_90" {
  sql = <<-EOQ
    select
      'https://iam.googleapis.com/v1/projects/' || project || '/serviceAccounts/' || service_account_name || '/keys/' || name as resource,
      case
        when valid_after_time <= (current_date - interval '90' day) then 'alarm'
        else 'ok'
      end as status,
      service_account_name || ' ' || name || ' created ' || to_char(valid_after_time , 'DD-Mon-YYYY') ||
        ' (' || extract(day from current_timestamp - valid_after_time) || ' days).'
      as reason
      ${local.common_dimensions_global_sql}
    from
      gcp_service_account_key
    where
      key_type = 'USER_MANAGED';
  EOQ
}

query "iam_api_key_age_90" {
  sql = <<-EOQ
    select
      'https://iam.googleapis.com/v1/projects/' || project || '/apikeys/' || name as resource,
      case
        when create_time <= (current_date - interval '90' day) then 'alarm'
        else 'ok'
      end as status,
      display_name || ' ' || uid || ' created ' || to_char(create_time , 'DD-Mon-YYYY') ||
        ' (' || extract(day from current_timestamp - create_time) || ' days).'
      as reason
      ${local.common_dimensions_global_sql}
    from
      gcp_apikeys_key;
  EOQ
}

query "iam_api_key_restricts_apis" {
  sql = <<-EOQ
    select
     'https://iam.googleapis.com/v1/projects/' || project || '/apikeys/' || name as resource,
    case
      when restrictions -> 'apiTargets' is null then 'alarm'
      else 'ok'
    end as status,
    case
      when restrictions -> 'apiTargets' is null then title || ' API key is not restricted to required APIs.'
      else title || ' API key is restricted to only required APIs.'
    end as reason
    ${local.common_dimensions_sql}
  from
    gcp_apikeys_key;
  EOQ
}

query "iam_api_key_restricts_websites_hosts_apps" {
  sql = <<-EOQ
    select
      'https://iam.googleapis.com/v1/projects/' || project || '/apikeys/' || name as resource,
      case
        when restrictions -> 'serverKeyRestrictions' is null
          and restrictions -> 'browserKeyRestrictions' is null
          and restrictions -> 'androidKeyRestrictions' is null
          and restrictions -> 'iosKeyRestrictions' is null then 'alarm'
        when restrictions -> 'serverKeyRestrictions' @> any( array[
        '{"allowedIps": ["0.0.0.0"]}', '{"allowedIps": ["0.0.0.0/0"]}', '{"allowedIps": ["::0"]}']::jsonb[]) then 'alarm'
        when restrictions -> 'browserKeyRestrictions' @> any( array[
        '{"allowedReferrers": ["*"]}','{"allowedReferrers": ["*.[TLD]/*"]}','{"allowedReferrers": ["*.[TLD]"]}' ]::jsonb[] ) then 'alarm'
        else 'ok'
      end as status,
      case
        when restrictions -> 'serverKeyRestrictions' is null
          and restrictions -> 'browserKeyRestrictions' is null
          and restrictions -> 'androidKeyRestrictions' is null
          and restrictions -> 'iosKeyRestrictions' is null
          then title || ' API key not restricted to use any specified Websites, Hosts and Apps.'
        when restrictions -> 'serverKeyRestrictions' @> any( array[
        '{"allowedIps": ["0.0.0.0"]}', '{"allowedIps": ["0.0.0.0/0"]}', '{"allowedIps": ["::0"]}']::jsonb[]) then title || ' API key open to any hosts.'
        when restrictions -> 'browserKeyRestrictions' @> any( array[
        '{"allowedReferrers": ["*"]}','{"allowedReferrers": ["*.[TLD]/*"]}','{"allowedReferrers": ["*.[TLD]"]}' ]::jsonb[] ) then  title || ' API key open to any or wide range of HTTP referrer(s).'
        else title || ' API key is restricted with specific Website(s), Host(s) and App(s).'
      end as reason
      ${local.common_dimensions_sql}
    from
      gcp_apikeys_key;
  EOQ
}

query "iam_service_account_without_admin_privilege" {
  sql = <<-EOQ
    with user_roles as (
    select
      distinct split_part(entity, ':', 2) as user_name
    from
      gcp_iam_policy,
      jsonb_array_elements(bindings) as p,
      jsonb_array_elements_text(p -> 'members') as entity
    where
      p ->> 'role' like any (array ['%admin','%Admin','%Editor','%Owner','%editor','%owner'])
      and split_part(entity, ':', 2) like '%@' || project || '.iam.gserviceaccount.com'
    )
    select
      'https://iam.googleapis.com/v1/projects/' || project || '/serviceAccounts/' || name as resource,
      case
        when name not like '%@' || project || '.iam.gserviceaccount.com' then 'skip'
        when name in (select user_name from user_roles) then 'alarm'
        else 'ok'
      end as status,
      case
        when name not like '%@' || project || '.iam.gserviceaccount.com' then 'Google-created service account ' || title || ' excluded.'
        when name in (select user_name from user_roles) then title || ' has admin privileges.'
        else title || ' has no admin privileges.'
      end as reason
      ${local.common_dimensions_global_sql}
    from
      gcp_service_account;
  EOQ
}

query "iam_user_not_assigned_service_account_user_role_project_level" {
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
        p ->> 'role' in ('roles/iam.serviceAccountTokenCreator','roles/iam.serviceAccountUser')
        and entity not like '%iam.gserviceaccount.com'
    )
    select
      p.project as resource,
      case
        when entity is not null then 'alarm'
        else 'ok'
      end as status,
      case
        when entity is not null
          then 'IAM users associated with iam.serviceAccountTokenCreator or iam.serviceAccountUser role.'
        else 'No IAM users associated with iam.serviceAccountTokenCreator or iam.serviceAccountUser role.'
      end as reason
      ${replace(local.common_dimensions_qualifier_global_sql, "__QUALIFIER__", "p.")}
    from
      gcp_iam_policy as p
      left join unapproved_bindings as b on p.project = b.project;
  EOQ
}

query "iam_user_kms_separation_of_duty_enforced" {
  sql = <<-EOQ
    with users_with_roles as (
      select
        distinct split_part(member_entity, ':', 2) as user_name,
        project,
        _ctx,
        p ->> 'role' as assigned_role
      from
        gcp_iam_policy,
        jsonb_array_elements(bindings) as p,
        jsonb_array_elements_text(p -> 'members') as member_entity
      where
        split_part(member_entity, ':', 1) = 'user'
    ),
    kms_admin_users as(
      select
        user_name,
        project
      from
        users_with_roles
      where
        assigned_role = 'roles/cloudkms.admin'
    )
    select
      distinct user_name as resource,
      case
        when user_name in (select user_name from kms_admin_users) then 'alarm'
        else 'ok'
      end as status,
      case
        when user_name in (select user_name from kms_admin_users) then  user_name || ' assigned with KMS Admin role.'
        else user_name || ' not assigned KMS Admin role.'
      end as reason
      ${local.common_dimensions_global_sql}
    from
      users_with_roles;
  EOQ
}

query "iam_user_separation_of_duty_enforced" {
  sql = <<-EOQ
    with users_with_roles as (
      select
        distinct split_part(member_entity, ':', 2) as user_name,
        project,
        _ctx,
        p ->> 'role' as assigned_role
      from
        gcp_iam_policy,
        jsonb_array_elements(bindings) as p,
        jsonb_array_elements_text(p -> 'members') as member_entity
      where
        split_part(member_entity, ':', 1) = 'user'
    ),
    account_admin_users as(
      select
        user_name,
        project
      from
        users_with_roles
      where assigned_role = 'roles/iam.serviceAccountAdmin'
    ),
    account_users as(
      select
        user_name,
        project
      from
        users_with_roles
      where assigned_role = 'roles/iam.serviceAccountUser'
    )
    select
      distinct user_name as resource,
      case
        when user_name in (select user_name from account_users) and user_name in (select user_name from account_admin_users) then 'alarm'
        else 'ok'
      end as status,
      case
        when user_name in (select user_name from account_users) and user_name in (select user_name from account_admin_users)
          then  user_name || ' assigned with both Service Account Admin and Service Account User roles.'
        else user_name || ' not assigned with both Service Account Admin and Service Account User roles.'
      end as reason
      ${local.common_dimensions_global_sql}
    from
      users_with_roles;
  EOQ
}
