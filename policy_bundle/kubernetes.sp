locals {
  control_library_kubernetes_common_tags = {
    service = "kubernetes"
  }
}

control "allow_only_private_cluster" {
  title         = "Verify all GKE clusters are Private Clusters"
  sql           = query.kubernetes_cluster_private_cluster_config_enabled.sql

  tags = merge(local.control_library_kubernetes_common_tags, {
    cft_scorecard_v1   = "true"
    severity           = "high"
  })
}

control "disable_gke_dashboard" {
  title         = "Ensure Kubernetes web UI/Dashboard is disabled"
  sql           = query.kubernetes_cluster_dashboard_disabled.sql

  tags = merge(local.control_library_kubernetes_common_tags, {
    cft_scorecard_v1   = "true"
    severity           = "high"
  })
}

control "disable_gke_default_service_account" {
  title         = "Ensure default Service account is not used for Project access in Kubernetes Engine clusters"
  sql           = query.kubernetes_cluster_service_account_default.sql

  tags = merge(local.control_library_kubernetes_common_tags, {
    cft_scorecard_v1   = "true"
    severity           = "high"
  })
}

control "disable_gke_legacy_abac" {
  title         = "Ensure Legacy Authorization is set to Disabled on Kubernetes Engine Clusters"
  sql           = query.kubernetes_cluster_legacy_abac_enabled.sql

  tags = merge(local.control_library_kubernetes_common_tags, {
    cft_scorecard_v1   = "true"
    severity           = "high"
  })
}

control "disable_gke_legacy_endpoints" {
  title         = "Check that legacy metadata endpoints are disabled on Kubernetes clusters(disabled by default since GKE 1.12+)"
  sql           = query.kubernetes_cluster_legacy_endpoints_disabled.sql

  tags = merge(local.control_library_kubernetes_common_tags, {
    cft_scorecard_v1   = "true"
    severity           = "high"
  })
}

control "enable_alias_ip_ranges" {
  title         = "Ensure Kubernetes Cluster is created with Alias IP ranges enabled"
  sql           = query.kubernetes_cluster_use_ip_aliases.sql

  tags = merge(local.control_library_kubernetes_common_tags, {
    cft_scorecard_v1   = "true"
    severity           = "high"
  })
}

control "enable_auto_repair" {
  title         = "Ensure automatic node repair is enabled on all node pools in a GKE cluster"
  sql           = query.kubernetes_cluster_auto_repair_enabled.sql

  tags = merge(local.control_library_kubernetes_common_tags, {
    cft_scorecard_v1   = "true"
    severity           = "high"
  })
}

control "enable_auto_upgrade" {
  title         = "Ensure Automatic node upgrades is enabled on Kubernetes Engine Clusters nodes"
  sql           = query.kubernetes_cluster_auto_repair_enabled.sql

  tags = merge(local.control_library_kubernetes_common_tags, {
    cft_scorecard_v1   = "true"
    severity           = "high"
  })
}

control "enable_gke_master_authorized_networks" {
  title         = "Ensure Master authorized networks is set to Enabled on Kubernetes Engine Clusters"
  sql           = query.kubernetes_cluster_master_authorized_networks_config_enabled.sql

  tags = merge(local.control_library_kubernetes_common_tags, {
    cft_scorecard_v1   = "true"
    severity           = "high"
  })
}

control "gke_container_optimized_os" {
  title         = "Ensure Container-Optimized OS (cos) is used for Kubernetes engine clusters"
  sql           = query.kubernetes_cluster_node_config_image_cos_containerd.sql

  tags = merge(local.control_library_kubernetes_common_tags, {
    cft_scorecard_v1   = "true"
    severity           = "high"
  })
}

control "gke_restrict_pod_traffic" {
  title         = "Check that GKE clusters have a Network Policy installed"
  sql           = query.kubernetes_cluster_network_policy_installed.sql

  tags = merge(local.control_library_kubernetes_common_tags, {
    cft_scorecard_v1   = "true"
    severity           = "high"
  })
}