locals {
  policy_bundle_kms_common_tags = merge(local.gcp_compliance_common_tags, {
    service = "GCP/KMS"
  })
}

control "cmek_rotation_one_hundred_days" {
  title = "Check that CMEK rotation policy is in place and is sufficiently short"
  query = query.kms_key_rotated_within_100_day

  tags = merge(local.policy_bundle_kms_common_tags, {
    forseti_security_v226 = "true"
    severity              = "high"
  })
}

control "kms_key_not_publicly_accessible" {
  title         = "Ensure that Cloud KMS cryptokeys are not anonymously or publicly accessible"
  description   = "It is recommended that the IAM policy on Cloud KMS cryptokeys should restrict anonymous and/or public access."
  query = query.kms_key_not_publicly_accessible

  tags = local.policy_bundle_kms_common_tags
}

control "kms_key_rotated_within_90_day" {
  title         = "Ensure KMS encryption keys are rotated within a period of 90 days"
  description   = "Google Cloud Key Management Service stores cryptographic keys in a hierarchical structure designed for useful and elegant access control management. The format for the rotation schedule depends on the client library that is used. For the gcloud command-line tool, the next rotation time must be in ISO or RFC3339 format, and the rotation period must be in the form INTEGER[UNIT], where units can be one of seconds (s), minutes (m), hours (h) or days (d)."
  query = query.kms_key_rotated_within_90_day

  tags = local.policy_bundle_kms_common_tags
}

control "kms_key_separation_of_duties_enforced" {
  title         = "Ensure that Separation of duties is enforced while assigning KMS related roles to users"
  description   = "It is recommended that the principle of 'Separation of Duties' is enforced while assigning KMS related roles to users."
  query = query.kms_key_separation_of_duties_enforced

  tags = local.policy_bundle_kms_common_tags
}

query "kms_key_rotated_within_100_day" {
  sql = <<-EOQ
    select
      self_link as resource,
      case
        when "primary" ->> 'state' = 'DESTROYED' then 'skip'
        when "primary" ->> 'state' = 'DESTROY_SCHEDULED' then 'skip'
        when "primary" ->> 'state' = 'DISABLED' then 'skip'
        when split_part(rotation_period, 's', 1) :: int <= 8640000 then 'ok'
        else 'alarm'
      end as status,
      case
        when "primary" ->> 'state' = 'DESTROYED' then title || ' is destroyed.'
        when "primary" ->> 'state' = 'DESTROY_SCHEDULED' then title || ' is scheduled for deletion.'
        when "primary" ->> 'state' = 'DISABLED' then title || ' is disabled.'
        when rotation_period is null then title || ' in ' || key_ring_name || ' requires manual rotation.'
        else key_ring_name || ' ' || title || ' rotation period set for ' || (split_part(rotation_period, 's', 1) :: int)/86400 || ' day(s).'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_kms_key;
  EOQ
}

query "kms_key_not_publicly_accessible" {
  sql = <<-EOQ
    with public_keys as (
      select
        distinct self_link
      from
        gcp_kms_key,
        jsonb_array_elements(iam_policy -> 'bindings') as b
      where
        b -> 'members' ?| array['allAuthenticatedUsers', 'allUsers']
    )
    select
      k.self_link as resource,
      case
        when p.self_link is null then 'ok'
        else 'alarm'
      end as status,
      case
        when p.self_link is null then title || ' in ' || k.key_ring_name || ' key ring not publicly accessible.'
        else title || ' in ' || k.key_ring_name || ' key ring publicly accessible.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_kms_key k
    left join public_keys p on k.self_link = p.self_link;
  EOQ
}

query "kms_key_rotated_within_90_day" {
  sql = <<-EOQ
    select
      self_link as resource,
      case
        when "primary" ->> 'state' = 'DESTROYED' then 'skip'
        when "primary" ->> 'state' = 'DESTROY_SCHEDULED' then 'skip'
        when "primary" ->> 'state' = 'DISABLED' then 'skip'
        when split_part(rotation_period, 's', 1) :: int <= 7776000 then 'ok'
        else 'alarm'
      end as status,
      case
        when "primary" ->> 'state' = 'DESTROYED' then title || ' is destroyed.'
        when "primary" ->> 'state' = 'DESTROY_SCHEDULED' then title || ' is scheduled for deletion.'
        when "primary" ->> 'state' = 'DISABLED' then title || ' is disabled.'
        when rotation_period is null then title || ' in ' || key_ring_name || ' requires manual rotation.'
        else key_ring_name || ' ' || title || ' rotation period set for ' || (split_part(rotation_period, 's', 1) :: int)/86400 || ' day(s).'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_kms_key;
  EOQ
}

query "kms_key_separation_of_duties_enforced" {
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
    kms_roles_users as(
      select
        user_name,
        project,
        assigned_role
      from
        users_with_roles
      where
        assigned_role in ('roles/cloudkms.admin', 'roles/cloudkms.cryptoKeyEncrypterDecrypter', 'roles/cloudkms.cryptoKeyEncrypter', 'roles/cloudkms.cryptoKeyDecrypter')
    )
    select
      distinct r.user_name as resource,
      case
        when r.user_name in (select user_name from kms_roles_users) then 'alarm'
        else 'ok'
      end as status,
      case
        when r.user_name in (select user_name from kms_roles_users) then r.user_name || ' assigned ' ||
        concat_ws(', ',
          case when 'roles/cloudkms.admin' in (select assigned_role from kms_roles_users where user_name = r.user_name) then 'roles/cloudkms.admin' end,
          case when 'roles/cloudkms.cryptoKeyEncrypterDecrypter' in (select assigned_role from kms_roles_users where user_name = r.user_name) then 'roles/cloudkms.cryptoKeyEncrypterDecrypter' end,
          case when 'roles/cloudkms.cryptoKeyEncrypter' in (select assigned_role from kms_roles_users where user_name = r.user_name) then 'roles/cloudkms.cryptoKeyEncrypter' end,
          case when 'roles/cloudkms.cryptoKeyDecrypter' in (select assigned_role from kms_roles_users where user_name = r.user_name) then 'roles/cloudkms.cryptoKeyDecrypter' end
          ) || ' KMS role(s).'
        else user_name || ' not assigned KMS admin and additional encrypter/decrypter roles.'
      end as reason
      ${local.common_dimensions_global_sql}
    from
      users_with_roles as r;
  EOQ
}
