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
      -- Required Columns
      a.project as resource,
      case
        when b.project is null then 'ok'
        else 'alarm'
      end as status,
      case
        when b.project is null then 'No public users have access to resources via IAM.'
        else 'Public users have access to resources via IAM.'
      end as reason
      -- Additional Dimensions
      ${replace(local.tag_dimensions_qualifier_sql, "__QUALIFIER__", "a.")}
      ${replace(local.common_dimensions_qualifier_sql, "__QUALIFIER__", "a.")}
    from
      gcp_iam_policy as a
      left join user_with_acces as b on a.project = b.project;
  EOQ
}

query "iam_user_uses_corporate_login_credentials" {
  sql = <<-EOQ
    with user_with_acces as (
    select
      distinct split_part(m, ':', 2) as member,
      project,
      location
    from
      gcp_iam_policy,
      jsonb_array_elements(bindings) as b,
      jsonb_array_elements_text(b -> 'members') as m
    where
      m like 'user:%'
    )
    select
      -- Required Columns
      a.member as resource,
      case
        when org.display_name is null then 'alarm'
        else 'ok'
      end as status,
      case
        when org.display_name is null then a.member || ' uses non-corporate login credentials.'
        else a.member || ' uses corporate login credentials.'
      end as reason
      -- Additional Dimensions
      ${replace(local.tag_dimensions_qualifier_sql, "__QUALIFIER__", "a.")}
      ${replace(local.common_dimensions_qualifier_sql, "__QUALIFIER__", "a.")}
    from
      user_with_acces as a
      left join gcp_organization as org on split_part(a.member, '@', 2) = org.display_name;
  EOQ
}

query "iam_service_account_key_age_100" {
  sql = <<-EOQ
    select
    -- Required Columns
      'https://iam.googleapis.com/v1/projects/' || project || '/serviceAccounts/' || service_account_name || '/keys/' || name as resource,
    case
      when valid_after_time <= (current_date - interval '100' day) then 'alarm'
      else 'ok'
    end status,
    service_account_name || ' ' || name || ' created ' || to_char(valid_after_time , 'DD-Mon-YYYY') ||
      ' (' || extract(day from current_timestamp - valid_after_time) || ' days).'
    as reason
    -- Additional Dimensions
    ${local.tag_dimensions_sql}
    ${local.common_dimensions_sql}
  from
    gcp_service_account_key;
  EOQ
}