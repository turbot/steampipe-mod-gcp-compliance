with users_with_roles as (
  select
    distinct split_part(member_entity, ':', 2) as user_name,
    project,
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
  -- Required Columns
  distinct r.user_name as resource,
  case
    when r.user_name in (select user_name from kms_roles_users) then 'alarm'
    else 'ok'
  end status,
  case
    when r.user_name in (select user_name from kms_roles_users) then r.user_name || ' assigned ' ||
    concat_ws(', ',
      case when 'roles/cloudkms.admin' in (select assigned_role from kms_roles_users where user_name = r.user_name) then 'roles/cloudkms.admin' end,
      case when 'roles/cloudkms.cryptoKeyEncrypterDecrypter' in (select assigned_role from kms_roles_users where user_name = r.user_name) then 'roles/cloudkms.cryptoKeyEncrypterDecrypter' end,
      case when 'roles/cloudkms.cryptoKeyEncrypter' in (select assigned_role from kms_roles_users where user_name = r.user_name) then 'roles/cloudkms.cryptoKeyEncrypter' end,
      case when 'roles/cloudkms.cryptoKeyDecrypter' in (select assigned_role from kms_roles_users where user_name = r.user_name) then 'roles/cloudkms.cryptoKeyDecrypter' end
      ) || ' KMS role(s).'
    else user_name || ' not assigned KMS admin and additional encrypter/decrypter roles.'
  end reason,
  -- Additional Dimensions
  project
from
  users_with_roles as r;