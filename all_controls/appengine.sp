locals {
  all_controls_appengine_common_tags = merge(local.all_controls_common_tags, {
    service = "GCP/AppEngine"
  })
}

benchmark "all_controls_appengine" {
  title       = "App Engine"
  description = "This section contains recommendations for configuring App Engine resources."
  children = [
    control.app_engine_application_iap_enabled
  ]

  tags = merge(local.all_controls_appengine_common_tags, {
    type = "Benchmark"
  })
}
