locals {
  cis_v120_2_common_tags = merge(local.cis_v120_common_tags, {
    cis_section_id = "2"
  })
}

benchmark "cis_v120_2" {
  title          = "2 Logging and Monitoring"
  documentation = file("./cis_v120/docs/cis_v120_2.md")
  children = [
    control.cis_v120_2_1,
    control.cis_v120_2_2,
    control.cis_v120_2_3,
    control.cis_v120_2_4,
    control.cis_v120_2_5,
    control.cis_v120_2_6,
    control.cis_v120_2_7,
    control.cis_v120_2_8,
    control.cis_v120_2_9,
    control.cis_v120_2_10,
    control.cis_v120_2_11,
    control.cis_v120_2_12
  ]
  tags = local.cis_v120_2_common_tags
}

control "cis_v120_2_1" {
  title          = "2.1 Ensure that Cloud Audit Logging is configured properly across all services and all users from a project"
  description    = "It is recommended that Cloud Audit Logging is configured to track all admin activities and read, write access to user data."
  sql            = query.audit_logging_configured_for_all_service.sql
  documentation = file("./cis_v120/docs/cis_v120_2_1.md")

  tags = merge(local.cis_v120_2_common_tags, {
    cis_item_id = "2.1"
    cis_level   = "1"
    cis_type    = "automated"
  })
}

control "cis_v120_2_2" {
  title          = "2.2 Ensure that sinks are configured for all log entries"
  description    = "It is recommended to create a sink that will export copies of all the log entries. This can help aggregate logs from multiple projects and export them to a Security Information and Event Management (SIEM)."
  sql            = query.logging_sink_configured_for_all_resource.sql
  documentation = file("./cis_v120/docs/cis_v120_2_2.md")

  tags = merge(local.cis_v120_2_common_tags, {
    cis_item_id = "2.2"
    cis_level   = "1"
    cis_type    = "automated"
  })
}

control "cis_v120_2_3" {
  title          = "2.3 Ensure that retention policies on log buckets are configured using Bucket Lock"
  description    = "Enabling retention policies on log buckets will protect logs stored in cloud storage buckets from being overwritten or accidentally deleted. It is recommended to set up retention policies and configure Bucket Lock on all storage buckets that are used as log sinks."
  sql            = query.logging_bucket_retention_policy_enabled.sql
  #documentation = file("./cis_v120/docs/cis_v120_2_3.md")

  tags = merge(local.cis_v120_2_common_tags, {
    cis_item_id = "2.3"
    cis_level   = "1"
    cis_type    = "automated"
  })
}

control "cis_v120_2_4" {
  title          = "2.4 Ensure log metric filter and alerts exist for project ownership assignments/changes"
  description    = "In order to prevent unnecessary project ownership assignments to users/service-accounts and further misuses of projects and resources, all roles/Owner assignments should be monitored. Members (users/Service-Accounts) with a role assignment to primitive role roles/Owner are project owners."
  sql            = query.logging_metric_alert_project_ownership_assignment.sql
  #documentation = file("./cis_v120/docs/cis_v120_2_4.md")

  tags = merge(local.cis_v120_2_common_tags, {
    cis_item_id = "2.4"
    cis_level   = "1"
    cis_type    = "automated"
  })
}

control "cis_v120_2_5" {
  title          = "2.5 Ensure that the log metric filter and alerts exist for Audit Configuration changes"
  description    = "Cloud audit logging records information includes the identity of the API caller, the time of the API call, the source IP address of the API caller, the request parameters, and the response elements returned by GCP services. Cloud audit logging provides a history of GCP API calls for an account, including API calls made via the console, SDKs, command-line tools, and other GCP services."
  sql            = query.logging_metric_alert_audit_configuration_changes.sql
  #documentation = file("./cis_v120/docs/cis_v120_2_5.md")

  tags = merge(local.cis_v120_2_common_tags, {
    cis_item_id = "2.5"
    cis_level   = "1"
    cis_type    = "automated"
  })
}

control "cis_v120_2_6" {
  title          = "2.6 Ensure that the log metric filter and alerts exist for Custom Role changes"
  description    = "It is recommended that a metric filter and alarm be established for changes to Identity and Access Management (IAM) role creation, deletion and updating activities."
  sql            = query.logging_metric_alert_custom_role_changes.sql
  #documentation = file("./cis_v120/docs/cis_v120_2_6.md")

  tags = merge(local.cis_v120_2_common_tags, {
    cis_item_id = "2.6"
    cis_level   = "1"
    cis_type    = "automated"
  })
}

control "cis_v120_2_7" {
  title          = "2.7 Ensure that the log metric filter and alerts exist for VPC Network Firewall rule changes"
  description    = "It is recommended that a metric filter and alarm be established for Virtual Private Cloud (VPC) Network Firewall rule changes."
  sql            = query.logging_metric_alert_firewall_rule_changes.sql
  #documentation = file("./cis_v120/docs/cis_v120_2_7.md")

  tags = merge(local.cis_v120_2_common_tags, {
    cis_item_id = "2.7"
    cis_level   = "1"
    cis_type    = "automated"
  })
}

control "cis_v120_2_8" {
  title          = "2.8 Ensure that the log metric filter and alerts exist for VPC network route changes"
  description    = "It is recommended that a metric filter and alarm be established for Virtual Private Cloud (VPC) network route changes."
  sql            = query.logging_metric_alert_network_route_changes.sql
  #documentation = file("./cis_v120/docs/cis_v120_2_8.md")

  tags = merge(local.cis_v120_2_common_tags, {
    cis_item_id = "2.8"
    cis_level   = "1"
    cis_type    = "automated"
  })
}

control "cis_v120_2_9" {
  title          = "2.9 Ensure that the log metric filter and alerts exist for VPC network changes"
  description    = "It is recommended that a metric filter and alarm be established for Virtual Private Cloud (VPC) network changes."
  sql            = query.logging_metric_alert_network_changes.sql
  #documentation = file("./cis_v120/docs/cis_v120_2_9.md")

  tags = merge(local.cis_v120_2_common_tags, {
    cis_item_id = "2.9"
    cis_level   = "1"
    cis_type    = "automated"
  })
}

control "cis_v120_2_10" {
  title          = "2.10 Ensure that the log metric filter and alerts exist for Cloud Storage IAM permission changes"
  description    = "It is recommended that a metric filter and alarm be established for Cloud Storage Bucket IAM changes."
  sql            = query.logging_metric_alert_storage_iam_permission_changes.sql
  #documentation = file("./cis_v120/docs/cis_v120_2_10.md")

  tags = merge(local.cis_v120_2_common_tags, {
    cis_item_id = "2.10"
    cis_level   = "1"
    cis_type    = "automated"
  })
}

control "cis_v120_2_11" {
  title          = "2.11 Ensure that the log metric filter and alerts exist for SQL instance configuration changes"
  description    = "It is recommended that a metric filter and alarm be established for SQL instance configuration changes."
  sql            = query.logging_metric_alert_sql_instance_configuration_changes.sql
  #documentation = file("./cis_v120/docs/cis_v120_2_11.md")

  tags = merge(local.cis_v120_2_common_tags, {
    cis_item_id = "2.11"
    cis_level   = "1"
    cis_type    = "automated"
  })
}

control "cis_v120_2_12" {
  title          = "2.12 Ensure that Cloud DNS logging is enabled for all VPC networks"
  description    = "Cloud DNS logging records the queries from the name servers within your VPC to Stackdriver. Logged queries can come from Compute Engine VMs, GKE containers, or other GCP resources provisioned within the VPC."
  sql            = query.manual_control.sql
  #documentation = file("./cis_v120/docs/cis_v120_2_12.md")

  tags = merge(local.cis_v120_2_common_tags, {
    cis_item_id = "2.12"
    cis_level   = "1"
    cis_type    = "automated"
  })
}
