locals {
  policy_bundle_appengine_common_tags = merge(local.gcp_compliance_common_tags, {
    service = "GCP/AppEngine"
  })
}

control "service_versions" {
  title = "Limit the number of App Engine application versions simultaneously running or installed"
  query = query.manual_control

  tags = merge(local.policy_bundle_appengine_common_tags, {
    cft_scorecard_v1 = "true"
    severity         = "high"
  })
}

control "app_engine_application_iap_enabled" {
  title       = "App Engine application IAP should be enabled"
  description = "This control ensures that App Engine application IAP(Identity-Aware Proxy) is enabled. IAP is used to enforce access control policies for applications and resources. Activating Identity-Aware Proxy (IAP) is a suggested practice for enhancing the security of your App Engine application."
  query = query.app_engine_application_iap_enabled

  tags = local.policy_bundle_appengine_common_tags
}

query "app_engine_application_iap_enabled" {
  sql = <<-EOQ
    select
      name as resource,
      case
        when (iap -> 'enabled')::bool then 'ok'
        else 'alarm'
      end as status,
      case
        when (iap -> 'enabled')::bool then title || ' IAP enabled.'
        else title || ' IAP disabled.'
      end as reason
      --${local.common_dimensions_sql}
    from
      gcp_app_engine_application;
  EOQ
}
