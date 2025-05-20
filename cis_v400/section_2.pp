locals {
  cis_v400_2_common_tags = merge(local.cis_v400_common_tags, {
    cis_section_id = "2"
  })
}

benchmark "cis_v400_2" {
  title         = "2 Logging and Monitoring"
  documentation = file("./cis_v400/docs/cis_v400_2.md")
  children = [
    control.cis_v400_2_1,
    control.cis_v400_2_2,
    control.cis_v400_2_3,
    control.cis_v400_2_4,
    control.cis_v400_2_5,
    control.cis_v400_2_6,
    control.cis_v400_2_7,
    control.cis_v400_2_8,
    control.cis_v400_2_9,
    control.cis_v400_2_10,
    control.cis_v400_2_11,
    control.cis_v400_2_12,
    control.cis_v400_2_13,
    control.cis_v400_2_14,
    control.cis_v400_2_15,
    control.cis_v400_2_16
  ]

  tags = merge(local.cis_v400_2_common_tags, {
    type = "Benchmark"
  })
}

control "cis_v400_2_1" {
  title         = "2.1 Ensure That Cloud Audit Logging Is Configured Properly "
  description   = "It is recommended that Cloud Audit Logging is configured to track all admin activities and read, write access to user data."
  query         = query.audit_logging_configured_for_all_service
  documentation = file("./cis_v400/docs/cis_v400_2_1.md")

  tags = merge(local.cis_v400_2_common_tags, {
    cis_item_id = "2.1"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/Logging"
  })
}

control "cis_v400_2_2" {
  title         = "2.2 Ensure That Sinks Are Configured for All Log Entries"
  description   = "It is recommended to create a sink that will export copies of all the log entries. This can help aggregate logs from multiple projects and export them to a Security Information and Event Management (SIEM)."
  query         = query.logging_sink_configured_for_all_resource
  documentation = file("./cis_v400/docs/cis_v400_2_2.md")

  tags = merge(local.cis_v400_2_common_tags, {
    cis_item_id = "2.2"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/Logging"
  })
}

control "cis_v400_2_3" {
  title         = "2.3 Ensure That Retention Policies on Cloud Storage Buckets Used for Exporting Logs Are Configured Using Bucket Lock"
  description   = "Enabling retention policies on log buckets will protect logs stored in cloud storage buckets from being overwritten or accidentally deleted. It is recommended to set up retention policies and configure Bucket Lock on all storage buckets that are used as log sinks."
  query         = query.logging_bucket_retention_policy_enabled
  documentation = file("./cis_v400/docs/cis_v400_2_3.md")

  tags = merge(local.cis_v400_2_common_tags, {
    cis_item_id = "2.3"
    cis_level   = "2"
    cis_type    = "automated"
    service     = "GCP/Logging"
  })
}

control "cis_v400_2_4" {
  title         = "2.4 Ensure Log Metric Filter and Alerts Exist for Project Ownership Assignments/Changes "
  description   = "In order to prevent unnecessary project ownership assignments to users/service-accounts and further misuses of projects and resources, all roles/Owner assignments should be monitored. Members (users/Service-Accounts) with a role assignment to primitive role roles/Owner are project owners."
  query         = query.logging_metric_alert_project_ownership_assignment
  documentation = file("./cis_v400/docs/cis_v400_2_4.md")

  tags = merge(local.cis_v400_2_common_tags, {
    cis_item_id = "2.4"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/Logging"
  })
}

control "cis_v400_2_5" {
  title         = "2.5 Ensure That the Log Metric Filter and Alerts Exist for Audit Configuration Changes"
  description   = "Google Cloud Platform (GCP) services write audit log entries to the Admin Activity and Data Access logs to help answer the questions of, 'who did what, where, and when?' within GCP projects."
  query         = query.logging_metric_alert_audit_configuration_changes
  documentation = file("./cis_v400/docs/cis_v400_2_5.md")

  tags = merge(local.cis_v400_2_common_tags, {
    cis_item_id = "2.5"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/Logging"
  })
}

control "cis_v400_2_6" {
  title         = "2.6 Ensure That the Log Metric Filter and Alerts Exist for Custom Role Changes"
  description   = "It is recommended that a metric filter and alarm be established for changes to Identity and Access Management (IAM) role creation, deletion and updating activities."
  query         = query.logging_metric_alert_custom_role_changes
  documentation = file("./cis_v400/docs/cis_v400_2_6.md")

  tags = merge(local.cis_v400_2_common_tags, {
    cis_item_id = "2.6"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/Logging"
  })
}

control "cis_v400_2_7" {
  title         = "2.7 Ensure That the Log Metric Filter and Alerts Exist for VPC Network Firewall Rule Changes"
  description   = "It is recommended that a metric filter and alarm be established for Virtual Private Cloud (VPC) Network Firewall rule changes."
  query         = query.logging_metric_alert_firewall_rule_changes
  documentation = file("./cis_v400/docs/cis_v400_2_7.md")

  tags = merge(local.cis_v400_2_common_tags, {
    cis_item_id = "2.7"
    cis_level   = "2"
    cis_type    = "automated"
    service     = "GCP/Logging"
  })
}

control "cis_v400_2_8" {
  title         = "2.8 Ensure That the Log Metric Filter and Alerts Exist for VPC Network Route Changes"
  description   = "It is recommended that a metric filter and alarm be established for Virtual Private Cloud (VPC) network route changes."
  query         = query.logging_metric_alert_network_route_changes
  documentation = file("./cis_v400/docs/cis_v400_2_8.md")

  tags = merge(local.cis_v400_2_common_tags, {
    cis_item_id = "2.8"
    cis_level   = "2"
    cis_type    = "automated"
    service     = "GCP/Logging"
  })
}

control "cis_v400_2_9" {
  title         = "2.9 Ensure That the Log Metric Filter and Alerts Exist for VPC Network Changes"
  description   = "It is recommended that a metric filter and alarm be established for Virtual Private Cloud (VPC) network changes."
  query         = query.logging_metric_alert_network_changes
  documentation = file("./cis_v400/docs/cis_v400_2_9.md")

  tags = merge(local.cis_v400_2_common_tags, {
    cis_item_id = "2.9"
    cis_level   = "2"
    cis_type    = "automated"
    service     = "GCP/Logging"
  })
}

control "cis_v400_2_10" {
  title         = "2.10 Ensure That the Log Metric Filter and Alerts Exist for Cloud Storage IAM Permission Changes"
  description   = "It is recommended that a metric filter and alarm be established for Cloud Storage Bucket IAM changes."
  query         = query.logging_metric_alert_storage_iam_permission_changes
  documentation = file("./cis_v400/docs/cis_v400_2_10.md")

  tags = merge(local.cis_v400_2_common_tags, {
    cis_item_id = "2.10"
    cis_level   = "2"
    cis_type    = "automated"
    service     = "GCP/Logging"
  })
}

control "cis_v400_2_11" {
  title         = "2.11 Ensure That the Log Metric Filter and Alerts Exist for SQL Instance Configuration Changes"
  description   = "It is recommended that a metric filter and alarm be established for SQL instance configuration changes."
  query         = query.logging_metric_alert_sql_instance_configuration_changes
  documentation = file("./cis_v400/docs/cis_v400_2_11.md")

  tags = merge(local.cis_v400_2_common_tags, {
    cis_item_id = "2.11"
    cis_level   = "2"
    cis_type    = "automated"
    service     = "GCP/Logging"
  })
}

control "cis_v400_2_12" {
  title         = "2.12 Ensure That Cloud DNS Logging Is Enabled for All VPC Networks"
  description   = "Cloud DNS logging records the queries from the name servers within your VPC to Stackdriver. Logged queries can come from Compute Engine VMs, GKE containers, or other GCP resources provisioned within the VPC."
  query         = query.compute_network_dns_logging_enabled
  documentation = file("./cis_v400/docs/cis_v400_2_12.md")

  tags = merge(local.cis_v400_2_common_tags, {
    cis_item_id = "2.12"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/DNS"
  })
}

control "cis_v400_2_13" {
  title         = "2.13 Ensure Cloud Asset Inventory Is Enabled"
  description   = "GCP Cloud Asset Inventory is services that provides a historical view of GCP resources and IAM policies through a time-series database. The information recorded includes metadata on Google Cloud resources, metadata on policies set on Google Cloud projects or resources, and runtime information gathered within a Google Cloud resource."
  query         = query.project_service_cloudasset_api_enabled
  documentation = file("./cis_v400/docs/cis_v400_2_13.md")

  tags = merge(local.cis_v400_2_common_tags, {
    cis_item_id = "2.13"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/Project"
  })
}

control "cis_v400_2_14" {
  title         = "2.14 Ensure 'Access Transparency' is 'Enabled'"
  description   = "GCP Access Transparency provides audit logs for all actions that Google personnel take in your Google Cloud resources."
  query         = query.manual_control
  documentation = file("./cis_v400/docs/cis_v400_2_14.md")

  tags = merge(local.cis_v400_2_common_tags, {
    cis_item_id = "2.14"
    cis_level   = "2"
    cis_type    = "manual"
    service     = "GCP/Project"
  })
}

control "cis_v400_2_15" {
  title         = "2.15 Ensure 'Access Approval' is 'Enabled'"
  description   = "GCP Access Approval enables you to require your organizations' explicit approval whenever Google support try to access your projects. You can then select users within your organization who can approve these requests through giving them a security role in IAM. All access requests display which Google Employee requested them in an email or Pub/Sub message that you can choose to Approve. This adds an additional control and logging of who in your organization approved/denied these requests."
  query         = query.project_access_approval_settings_enabled
  documentation = file("./cis_v400/docs/cis_v400_2_15.md")

  tags = merge(local.cis_v400_2_common_tags, {
    cis_item_id = "2.15"
    cis_level   = "2"
    cis_type    = "automated"
    service     = "GCP/Project"
  })
}

control "cis_v400_2_16" {
  title         = "2.16 Ensure Logging is enabled for HTTP(S) Load Balancer"
  description   = "Logging enabled on a HTTPS Load Balancer will show all network traffic and its destination."
  query         = query.compute_https_load_balancer_logging_enabled
  documentation = file("./cis_v400/docs/cis_v400_2_16.md")

  tags = merge(local.cis_v400_2_common_tags, {
    cis_item_id = "2.16"
    cis_level   = "2"
    cis_type    = "automated"
    service     = "GCP/Logging"
  })
}
