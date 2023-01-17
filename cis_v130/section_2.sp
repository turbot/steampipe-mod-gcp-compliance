locals {
  cis_v130_2_common_tags = merge(local.cis_v130_common_tags, {
    cis_section_id = "2"
  })
}

benchmark "cis_v130_2" {
  title         = "2 Logging and Monitoring"
  documentation = file("./cis_v130/docs/cis_v130_2.md")
  children = [
    control.cis_v130_2_1,
    control.cis_v130_2_2,
    control.cis_v130_2_3,
    control.cis_v130_2_4,
    control.cis_v130_2_5,
    control.cis_v130_2_6,
    control.cis_v130_2_7,
    control.cis_v130_2_8,
    control.cis_v130_2_9,
    control.cis_v130_2_10,
    control.cis_v130_2_11,
    control.cis_v130_2_12,
    control.cis_v130_2_13,
    control.cis_v130_2_14,
    control.cis_v130_2_15
  ]

  tags = merge(local.cis_v130_2_common_tags, {
    type = "Benchmark"
  })
}

control "cis_v130_2_1" {
  title         = "2.1 Ensure that Cloud Audit Logging is configured properly across all services and all users from a project"
  description   = "It is recommended that Cloud Audit Logging is configured to track all admin activities and read, write access to user data."
  sql           = query.audit_logging_configured_for_all_service.sql
  documentation = file("./cis_v130/docs/cis_v130_2_1.md")

  tags = merge(local.cis_v130_2_common_tags, {
    cis_item_id = "2.1"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/Logging"
  })
}

control "cis_v130_2_2" {
  title         = "2.2 Ensure that sinks are configured for all log entries"
  description   = "It is recommended to create a sink that will export copies of all the log entries. This can help aggregate logs from multiple projects and export them to a Security Information and Event Management (SIEM)."
  sql           = query.logging_sink_configured_for_all_resource.sql
  documentation = file("./cis_v130/docs/cis_v130_2_2.md")

  tags = merge(local.cis_v130_2_common_tags, {
    cis_item_id = "2.2"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/Logging"
  })
}

control "cis_v130_2_3" {
  title         = "2.3 Ensure that retention policies on log buckets are configured using Bucket Lock"
  description   = "Enabling retention policies on log buckets will protect logs stored in cloud storage buckets from being overwritten or accidentally deleted. It is recommended to set up retention policies and configure Bucket Lock on all storage buckets that are used as log sinks."
  sql           = query.logging_bucket_retention_policy_enabled.sql
  documentation = file("./cis_v130/docs/cis_v130_2_3.md")

  tags = merge(local.cis_v130_2_common_tags, {
    cis_item_id = "2.3"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/Logging"
  })
}

control "cis_v130_2_4" {
  title         = "2.4 Ensure log metric filter and alerts exist for project ownership assignments/changes"
  description   = "In order to prevent unnecessary project ownership assignments to users/service-accounts and further misuses of projects and resources, all roles/Owner assignments should be monitored. Members (users/Service-Accounts) with a role assignment to primitive role roles/Owner are project owners."
  sql           = query.logging_metric_alert_project_ownership_assignment.sql
  documentation = file("./cis_v130/docs/cis_v130_2_4.md")

  tags = merge(local.cis_v130_2_common_tags, {
    cis_item_id = "2.4"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/Logging"
  })
}

control "cis_v130_2_5" {
  title         = "2.5 Ensure that the log metric filter and alerts exist for Audit Configuration changes"
  description   = "Cloud audit logging records information includes the identity of the API caller, the time of the API call, the source IP address of the API caller, the request parameters, and the response elements returned by GCP services. Cloud audit logging provides a history of GCP API calls for an account, including API calls made via the console, SDKs, command-line tools, and other GCP services."
  sql           = query.logging_metric_alert_audit_configuration_changes.sql
  documentation = file("./cis_v130/docs/cis_v130_2_5.md")

  tags = merge(local.cis_v130_2_common_tags, {
    cis_item_id = "2.5"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/Logging"
  })
}

control "cis_v130_2_6" {
  title         = "2.6 Ensure that the log metric filter and alerts exist for Custom Role changes"
  description   = "It is recommended that a metric filter and alarm be established for changes to Identity and Access Management (IAM) role creation, deletion and updating activities."
  sql           = query.logging_metric_alert_custom_role_changes.sql
  documentation = file("./cis_v130/docs/cis_v130_2_6.md")

  tags = merge(local.cis_v130_2_common_tags, {
    cis_item_id = "2.6"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/Logging"
  })
}

control "cis_v130_2_7" {
  title         = "2.7 Ensure that the log metric filter and alerts exist for VPC Network Firewall rule changes"
  description   = "It is recommended that a metric filter and alarm be established for Virtual Private Cloud (VPC) Network Firewall rule changes."
  sql           = query.logging_metric_alert_firewall_rule_changes.sql
  documentation = file("./cis_v130/docs/cis_v130_2_7.md")

  tags = merge(local.cis_v130_2_common_tags, {
    cis_item_id = "2.7"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/Logging"
  })
}

control "cis_v130_2_8" {
  title         = "2.8 Ensure that the log metric filter and alerts exist for VPC network route changes"
  description   = "It is recommended that a metric filter and alarm be established for Virtual Private Cloud (VPC) network route changes."
  sql           = query.logging_metric_alert_network_route_changes.sql
  documentation = file("./cis_v130/docs/cis_v130_2_8.md")

  tags = merge(local.cis_v130_2_common_tags, {
    cis_item_id = "2.8"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/Logging"
  })
}

control "cis_v130_2_9" {
  title         = "2.9 Ensure that the log metric filter and alerts exist for VPC network changes"
  description   = "It is recommended that a metric filter and alarm be established for Virtual Private Cloud (VPC) network changes."
  sql           = query.logging_metric_alert_network_changes.sql
  documentation = file("./cis_v130/docs/cis_v130_2_9.md")

  tags = merge(local.cis_v130_2_common_tags, {
    cis_item_id = "2.9"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/Logging"
  })
}

control "cis_v130_2_10" {
  title         = "2.10 Ensure that the log metric filter and alerts exist for Cloud Storage IAM permission changes"
  description   = "It is recommended that a metric filter and alarm be established for Cloud Storage Bucket IAM changes."
  sql           = query.logging_metric_alert_storage_iam_permission_changes.sql
  documentation = file("./cis_v130/docs/cis_v130_2_10.md")

  tags = merge(local.cis_v130_2_common_tags, {
    cis_item_id = "2.10"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/Logging"
  })
}

control "cis_v130_2_11" {
  title         = "2.11 Ensure that the log metric filter and alerts exist for SQL instance configuration changes"
  description   = "It is recommended that a metric filter and alarm be established for SQL instance configuration changes."
  sql           = query.logging_metric_alert_sql_instance_configuration_changes.sql
  documentation = file("./cis_v130/docs/cis_v130_2_11.md")

  tags = merge(local.cis_v130_2_common_tags, {
    cis_item_id = "2.11"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/Logging"
  })
}

control "cis_v130_2_12" {
  title         = "2.12 Ensure that Cloud DNS logging is enabled for all VPC networks"
  description   = "Cloud DNS logging records the queries from the name servers within your VPC to Stackdriver. Logged queries can come from Compute Engine VMs, GKE containers, or other GCP resources provisioned within the VPC."
  sql           = query.compute_network_dns_logging_enabled.sql
  documentation = file("./cis_v130/docs/cis_v130_2_12.md")

  tags = merge(local.cis_v130_2_common_tags, {
    cis_item_id = "2.12"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/DNS"
  })
}

control "cis_v130_2_13" {
  title         = "2.13 Ensure Cloud Asset Inventory Is Enabled"
  description   = "GCP Cloud Asset Inventory is services that provides a historical view of GCP resources and IAM policies through a time-series database. The information recorded includes metadata on Google Cloud resources, metadata on policies set on Google Cloud projects or resources, and runtime information gathered within a Google Cloud resource."
  sql           = query.project_service_cloudasset_api_enabled.sql
  documentation = file("./cis_v130/docs/cis_v130_2_13.md")

  tags = merge(local.cis_v130_2_common_tags, {
    cis_item_id = "2.13"
    cis_level   = "2"
    cis_type    = "automated"
    service     = "GCP/Project"
  })
}

control "cis_v130_2_14" {
  title         = "2.14 Ensure 'Access Transparency' is 'Enabled'"
  description   = "GCP Access Transparency provides audit logs for all actions that Google personnel take in your Google Cloud resources."
  sql           = query.manual_control.sql
  documentation = file("./cis_v130/docs/cis_v130_2_14.md")

  tags = merge(local.cis_v130_2_common_tags, {
    cis_item_id = "2.14"
    cis_level   = "1"
    cis_type    = "manual"
    service     = "GCP/Project"
  })
}

control "cis_v130_2_15" {
  title         = "2.15 Ensure 'Access Approval' is 'Enabled'"
  description   = "GCP Access Approval enables you to require your organizations' explicit approval whenever Google support try to access your projects. You can then select users within your organization who can approve these requests through giving them a security role in IAM. All access requests display which Google Employee requested them in an email or Pub/Sub message that you can choose to Approve. This adds an additional control and logging of who in your organization approved/denied these requests."
  sql           = query.project_access_approval_settings_enabled.sql
  documentation = file("./cis_v130/docs/cis_v130_2_15.md")

  tags = merge(local.cis_v130_2_common_tags, {
    cis_item_id = "2.15"
    cis_level   = "2"
    cis_type    = "automated"
    service     = "GCP/Project"
  })
}
