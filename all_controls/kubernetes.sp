locals {
  all_controls_kubernetes_common_tags = merge(local.all_controls_common_tags, {
    service = "GCP/Kubernetes"
  })
}

benchmark "all_controls_kubernetes" {
  title       = "Kubernetes"
  description = "This section contains recommendations for configuring Kubernetes resources."
  children = [
    control.allow_only_private_cluster,
    control.disable_gke_dashboard,
    control.disable_gke_default_service_account,
    control.disable_gke_legacy_abac,
    control.disable_gke_legacy_endpoints,
    control.enable_alias_ip_ranges,
    control.enable_auto_repair,
    control.enable_auto_upgrade,
    control.enable_gke_master_authorized_networks,
    control.gke_container_optimized_os,
    control.gke_restrict_pod_traffic
  ]

  tags = merge(local.all_controls_kubernetes_common_tags, {
    type = "Benchmark"
  })
}
