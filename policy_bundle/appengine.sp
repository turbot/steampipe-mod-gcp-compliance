locals {
  control_library_appengine_common_tags = {
    service = "appengine"
  }
}

control "service_versions" {
  title         = "Limit the number of App Engine application versions simultaneously running or installed"
  sql           = query.manual_control.sql

  tags = merge(local.control_library_appengine_common_tags, {
    cft_scorecard_v1    = "true"
    severity            = "high"
  })
}