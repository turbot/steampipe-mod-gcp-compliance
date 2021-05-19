with all_proxies as (
  select
    name,
    self_link,
    split_part(kind, '#', 2) proxy_type,
    ssl_policy,
    title,
    location,
    project
  from
    gcp_compute_target_ssl_proxy
  union
  select
    name,
    self_link,
    split_part(kind, '#', 2) proxy_type,
    ssl_policy,
    title,
    location,
    project
  from
    gcp_compute_target_https_proxy
),
ssl_policy_without_weak_cipher as (
  select
    self_link
  from
    gcp_compute_ssl_policy
  where
    (profile = 'MODERN' and min_tls_version = 'TLS_1_2')
    or profile = 'RESTRICTED'
    or (profile = 'CUSTOM' and not (enabled_features ?| array['TLS_RSA_WITH_AES_128_GCM_SHA256', 'TLS_RSA_WITH_AES_256_GCM_SHA384', 'TLS_RSA_WITH_AES_128_CBC_SHA', 'TLS_RSA_WITH_AES_256_CBC_SHA', 'TLS_RSA_WITH_3DES_EDE_CBC_SHA']))
)
select
  -- Required Columns
  self_link resource,
  case
    when ssl_policy is null or ssl_policy in (select self_link from ssl_policy_without_weak_cipher) then 'ok'
    else 'alarm'
  end status,
  case
    when ssl_policy is null
      then proxy_type || ' ' || title || ' has no SSL policy.'
    when ssl_policy is null or ssl_policy in (select self_link from ssl_policy_without_weak_cipher)
      then proxy_type || ' ' || title || ' SSL policy contains CIS compliant cipher.'
    else proxy_type || ' ' || title || ' SSL policy contains weak cipher.'
  end reason,
  -- Additional Dimensions
  location,
  project
from all_proxies;