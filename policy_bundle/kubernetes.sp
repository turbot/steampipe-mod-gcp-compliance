locals {
  policy_bundle_kubernetes_common_tags = merge(local.gcp_compliance_common_tags, {
    service = "GCP/Kubernetes"
  })
}

control "allow_only_private_cluster" {
  title = "Verify all GKE clusters are Private Clusters"
  query = query.kubernetes_cluster_private_cluster_config_enabled

  tags = merge(local.policy_bundle_kubernetes_common_tags, {
    cft_scorecard_v1 = "true"
    severity         = "high"
  })
}

control "disable_gke_dashboard" {
  title = "Ensure Kubernetes web UI/Dashboard is disabled"
  query = query.kubernetes_cluster_dashboard_disabled

  tags = merge(local.policy_bundle_kubernetes_common_tags, {
    cft_scorecard_v1 = "true"
    severity         = "high"
  })
}

control "disable_gke_default_service_account" {
  title = "Ensure default Service account is not used for Project access in Kubernetes Engine clusters"
  query = query.kubernetes_cluster_service_account_default

  tags = merge(local.policy_bundle_kubernetes_common_tags, {
    cft_scorecard_v1 = "true"
    severity         = "high"
  })
}

control "disable_gke_legacy_abac" {
  title = "Ensure Legacy Authorization is set to Disabled on Kubernetes Engine Clusters"
  query = query.kubernetes_cluster_legacy_abac_enabled

  tags = merge(local.policy_bundle_kubernetes_common_tags, {
    cft_scorecard_v1 = "true"
    severity         = "high"
  })
}

control "disable_gke_legacy_endpoints" {
  title = "Check that legacy metadata endpoints are disabled on Kubernetes clusters(disabled by default since GKE 1.12+)"
  query = query.kubernetes_cluster_legacy_endpoints_disabled

  tags = merge(local.policy_bundle_kubernetes_common_tags, {
    cft_scorecard_v1 = "true"
    severity         = "high"
  })
}

control "enable_alias_ip_ranges" {
  title = "Ensure Kubernetes Cluster is created with Alias IP ranges enabled"
  query = query.kubernetes_cluster_use_ip_aliases

  tags = merge(local.policy_bundle_kubernetes_common_tags, {
    cft_scorecard_v1 = "true"
    severity         = "high"
  })
}

control "enable_auto_repair" {
  title = "Ensure automatic node repair is enabled on all node pools in a GKE cluster"
  query = query.kubernetes_cluster_auto_repair_enabled

  tags = merge(local.policy_bundle_kubernetes_common_tags, {
    cft_scorecard_v1 = "true"
    severity         = "high"
  })
}

control "enable_auto_upgrade" {
  title = "Ensure Automatic node upgrades is enabled on Kubernetes Engine Clusters nodes"
  query = query.kubernetes_cluster_auto_repair_enabled

  tags = merge(local.policy_bundle_kubernetes_common_tags, {
    cft_scorecard_v1 = "true"
    severity         = "high"
  })
}

control "enable_gke_master_authorized_networks" {
  title = "Ensure Master authorized networks is set to Enabled on Kubernetes Engine Clusters"
  query = query.kubernetes_cluster_master_authorized_networks_config_enabled

  tags = merge(local.policy_bundle_kubernetes_common_tags, {
    cft_scorecard_v1 = "true"
    severity         = "high"
  })
}

control "gke_container_optimized_os" {
  title = "Ensure Container-Optimized OS (cos) is used for Kubernetes engine clusters"
  query = query.kubernetes_cluster_node_config_image_cos_containerd

  tags = merge(local.policy_bundle_kubernetes_common_tags, {
    cft_scorecard_v1 = "true"
    severity         = "high"
  })
}

control "gke_restrict_pod_traffic" {
  title = "Check that GKE clusters have a Network Policy installed"
  query = query.kubernetes_cluster_network_policy_installed

  tags = merge(local.policy_bundle_kubernetes_common_tags, {
    cft_scorecard_v1 = "true"
    severity         = "high"
  })
}