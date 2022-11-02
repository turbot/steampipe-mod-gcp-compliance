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
kms_admin_users as(
  select
    user_name,
    project
  from
    users_with_roles
  where assigned_role = 'roles/cloudkms.admin'
),
kms_encrypt_decrypt_users as(
  select
    user_name,
    project
  from
    users_with_roles
  where assigned_role in ( 'roles/cloudkms.cryptoKeyEncrypterDecrypter', 'roles/cloudkms.cryptoKeyEncrypter', 'roles/cloudkms.cryptoKeyDecrypter')
)
select
  -- Required Columns
  distinct user_name as resource,
  case
    when user_name in (select user_name from kms_encrypt_decrypt_users) and user_name in (select user_name from kms_admin_users) then 'alarm'
    when user_name in (select user_name from kms_encrypt_decrypt_users) then 'alarm'
    when user_name in (select user_name from kms_admin_users) then 'alarm'
    else 'ok'
  end status,
  case
    when user_name in (select user_name from kms_encrypt_decrypt_users) and user_name in (select user_name from kms_admin_users)
      then user_name || ' assigned KMS admin and additional encrypter/decrypter roles.'
    when user_name in (select user_name from kms_encrypt_decrypt_users) then user_name || ' assigned encrypter/decrypter roles.'
    when user_name in (select user_name from kms_admin_users) then user_name || ' assigned KMS admin roles.'
    else user_name || ' not assigned KMS admin and additional encrypter/decrypter roles.'
  end reason,
  -- Additional Dimensions
  project
from
  users_with_roles;