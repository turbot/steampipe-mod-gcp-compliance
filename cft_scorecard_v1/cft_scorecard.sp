locals {
  cft_scorecard_common_tags = {
    cft_scorecard_v1   = "true"
    plugin             = "gcp"
  }
}

benchmark "cft_scorecard" {
  title         = "CFT Scorecard v1"
  documentation = file("./cft_scorecard_v1/docs/cft_scorecard_overview.md")
  tags          = local.cft_scorecard_common_tags
  children = [
      control.allow_only_private_cluster,
      control.denylist_public_users,
      control.disable_gke_dashboard,
      control.disable_gke_default_service_account,
      control.disable_gke_legacy_abac,
      control.disable_gke_legacy_endpoints,
      control.dnssec_prevent_rsasha1_ksk,
      control.dnssec_prevent_rsasha1_zsk,
      control.enable_alias_ip_ranges,
      control.enable_auto_repair,
      control.enable_auto_upgrade,
      control.enable_gke_master_authorized_networks,
      control.enable_network_flow_logs,
      control.enable_network_private_google_access,
      control.gke_container_optimized_os,
      control.gke_restrict_pod_traffic,
      control.prevent_public_ip_cloudsql,
      control.require_bq_table_iam,
      control.require_bucket_policy_only,
      control.require_ssl_sql,
      control.restrict_firewall_rule_rdp_world_open,
      control.restrict_firewall_rule_ssh_world_open,
      control.restrict_firewall_rule_world_open,
      control.restrict_gmail_bigquery_dataset,
      control.restrict_googlegroups_bigquery_dataset,
      control.service_versions,
      control.sql_world_readable
  ]
}

control "denylist_public_users" {
  title         = "Prevent public users from having access to resources via IAM"
  sql           = query.iam_user_denylist_public.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity     = "high"
  })
}

control "require_bq_table_iam" {
  title         = "Check if BigQuery datasets are publicly readable"
  sql           = query.bigquery_dataset_not_publicly_accessible.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity     = "high"
  })
}

control "restrict_firewall_rule_world_open" {
  title         = "Check for open firewall rules allowing ingress from the internet"
  sql           = query.compute_firewall_rule_ssh_access_restricted.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity     = "high"
  })
}

control "restrict_firewall_rule_rdp_world_open" {
  title         = "Check for open firewall rules allowing RDP from the internet"
  sql           = query.compute_firewall_rule_rdp_access_restricted.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity     = "high"
  })
}

control "restrict_firewall_rule_ssh_world_open" {
  title         = "Check for open firewall rules allowing SSH from the internet"
  sql           = query.compute_firewall_rule_ssh_access_restricted.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity     = "high"
  })
}

control "restrict_gmail_bigquery_dataset" {
  title         = "Enforce corporate domain by banning gmail.com addresses access to BigQuery datasets"
  sql           = query.bigquery_dataset_restrict_gmail.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity     = "high"
  })
}

control "restrict_googlegroups_bigquery_dataset" {
  title         = "Enforce corporate domain by banning googlegroups.com addresses access to BigQuery datasets"
  sql           = query.bigquery_dataset_restrict_googlegroups.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity     = "high"

  })
}

control "sql_world_readable" {
  title         = "Check if Cloud SQL instances are world readable"
  sql           = query.sql_instance_not_open_to_internet.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity     = "high"
  })
}

control "prevent_public_ip_cloudsql" {
  title         = "Prevent a public IP from being assigned to a Cloud SQL instance"
  sql           = query.sql_instance_with_no_public_ips.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity     = "high"
  })
}

control "require_ssl_sql" {
  title         = "Check if Cloud SQL instances have SSL turned on"
  sql           = query.sql_instance_require_ssl_enabled.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity     = "high"
  })
}

control "require_bucket_policy_only" {
  title         = "Check if Cloud Storage buckets have Bucket Only Policy turned on"
  sql           = query.storage_bucket_bucket_policy_only_enabled.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity     = "high"

  })
}

control "dnssec_prevent_rsasha1_ksk" {
  title         = "Ensure that RSASHA1 is not used for key-signing key in Cloud DNS"
  sql           = query.dns_managed_zone_key_signing_not_using_rsasha1.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity     = "high"
  })
}

control "dnssec_prevent_rsasha1_zsk" {
  title         = "Ensure that RSASHA1 is not used for zone-signing key in Cloud DNS"
  sql           = query.dns_managed_zone_zone_signing_not_using_rsasha1.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity     = "high"
  })
}

control "enable_network_flow_logs" {
  title         = "Ensure VPC Flow logs is enabled for every subnet in VPC Network"
  sql           = query.compute_subnetwork_flow_log_enabled.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity     = "high"
  })
}

control "enable_network_private_google_access" {
  title         = "Ensure Private Google Access is enabled for all subnetworks in VPC"
  sql           = query.compute_subnetwork_private_ip_google_access.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity     = "high"
  })
}

control "allow_only_private_cluster" {
  title         = "Verify all GKE clusters are Private Clusters"
  sql           = query.kubernetes_cluster_private_cluster_config_enabled.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity     = "high"
  })
}

control "disable_gke_dashboard" {
  title         = "Ensure Kubernetes web UI/Dashboard is disabled"
  sql           = query.kubernetes_cluster_dashboard_disabled.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity     = "high"
  })
}

control "disable_gke_default_service_account" {
  title         = "Ensure default Service account is not used for Project access in Kubernetes Engine clusters"
  sql           = query.kubernetes_cluster_service_account_default.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity     = "high"
  })
}

control "disable_gke_legacy_abac" {
  title         = "Ensure Legacy Authorization is set to Disabled on Kubernetes Engine Clusters"
  sql           = query.kubernetes_cluster_legacy_abac_enabled.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity     = "high"
  })
}

control "disable_gke_legacy_endpoints" {
  title         = "Check that legacy metadata endpoints are disabled on Kubernetes clusters(disabled by default since GKE 1.12+)"
  sql           = query.kubernetes_cluster_legacy_endpoints_disabled.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity     = "high"
  })
}

control "enable_alias_ip_ranges" {
  title         = "Ensure Kubernetes Cluster is created with Alias IP ranges enabled"
  sql           = query.kubernetes_cluster_use_ip_aliases.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity     = "high"
  })
}

control "enable_auto_repair" {
  title         = "Ensure automatic node repair is enabled on all node pools in a GKE cluster"
  sql           = query.kubernetes_cluster_auto_repair_enabled.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity     = "high"
  })
}

control "enable_auto_upgrade" {
  title         = "Ensure Automatic node upgrades is enabled on Kubernetes Engine Clusters nodes"
  sql           = query.kubernetes_cluster_auto_repair_enabled.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity     = "high"
  })
}

control "enable_gke_master_authorized_networks" {
  title         = "Ensure Master authorized networks is set to Enabled on Kubernetes Engine Clusters"
  sql           = query.kubernetes_cluster_master_authorized_networks_config_enabled.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity     = "high"
  })
}

control "gke_container_optimized_os" {
  title         = "Ensure Container-Optimized OS (cos) is used for Kubernetes engine clusters"
  sql           = query.kubernetes_cluster_node_config_image_cos_containerd.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity     = "high"
  })
}

control "gke_restrict_pod_traffic" {
  title         = "Check that GKE clusters have a Network Policy installed"
  sql           = query.kubernetes_cluster_network_policy_installed.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity     = "high"
  })
}

control "service_versions" {
  title         = "Limit the number of App Engine application versions simultaneously running or installed"
  sql           = query.manual_control.sql

  tags = merge(local.cft_scorecard_common_tags, {
    severity     = "high"
  })
}