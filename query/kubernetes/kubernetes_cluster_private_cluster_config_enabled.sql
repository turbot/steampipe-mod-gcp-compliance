select
  -- Required Columns
  self_link resource,
  case
    when private_cluster_config is null or ssl_policy in (select self_link from ssl_policy_without_weak_cipher) then 'ok'
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