locals {
  policy_bundle_appengine_common_tags = merge(local.gcp_compliance_common_tags, {
    service = "GCP/AppEngine"    
  })
}

control "service_versions" {
  title         = "Limit the number of App Engine application versions simultaneously running or installed"
  sql           = query.manual_control.sql

  tags = merge(local.policy_bundle_appengine_common_tags, {
    cft_scorecard_v1    = "true"
    severity            = "high"
  })
}