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
  query = query.kubernetes_cluster_auto_upgrade_enabled

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

query "kubernetes_cluster_private_cluster_config_enabled" {
  sql = <<-EOQ
    select
    self_link resource,
    case
      when private_cluster_config is null then 'alarm'
      else 'ok'
    end as status,
    case
      when private_cluster_config is null then title || ' private cluster config disabled.'
      else title || ' private cluster config enabled.'
    end as reason
    ${local.tag_dimensions_sql}
    ${local.common_dimensions_sql}
  from
    gcp_kubernetes_cluster;
  EOQ
}

query "kubernetes_cluster_etcd_encryption"{
  sql = <<-EOQ
    select
    self_link resource,
    case
      when database_encryption_state = 'ENCRYPTED' then 'ok'
      else 'alarm'
    end as status,
    case
      when database_encryption_state = 'ENCRYPTED' then title || ' Kubernetes secrets, stored in etcd encrypted with CMEK.'
      else title || ' Kubernetes secrets, stored in etcd not encrypted with CMEK.'
    end as reason
    ${local.tag_dimensions_sql}
    ${local.common_dimensions_sql}
  from
    gcp_kubernetes_cluster;
  EOQ
}

query "kubernetes_cluster_version_management_release_channels"{
  sql = <<-EOQ
    select
    self_link resource,
    case
      when release_channel is null then 'alarm'
      else 'ok'
    end as status,
    case
      when release_channel is null then title || ' GKE version management using Release Channels is not configured.'
      else title || ' GKE version management using Release Channels is configured.'
    end as reason
    ${local.tag_dimensions_sql}
    ${local.common_dimensions_sql}
  from
    gcp_kubernetes_cluster;
  EOQ
}

query "kubernetes_cluster_shielded_nodes_enabled"{
  sql = <<-EOQ
    select
    self_link resource,
    case
      when shielded_nodes_enabled = 'true' then 'ok'
      else 'alarm'
    end as status,
    case
      when shielded_nodes_enabled = 'true' then title || ' Shielded GKE Nodes are enabled.'
      else title || ' Shielded GKE Nodes are not enabled.'
    end as reason
    ${local.tag_dimensions_sql}
    ${local.common_dimensions_sql}
  from
    gcp_kubernetes_cluster;
  EOQ
}

query "kubernetes_cluster_alpha_clusters_disabled"{
  sql = <<-EOQ
    select
    self_link resource,
    case
      when enable_kubernetes_alpha = 'false' then 'ok'
      else 'ok'
    end as status,
    case
      when enable_kubernetes_alpha = 'false' then title || ' Alpha clusters disabled.'
      else title || ' Alpha clusters not disabled.'
    end as reason
    ${local.tag_dimensions_sql}
    ${local.common_dimensions_sql}
  from
    gcp_kubernetes_cluster;
  EOQ
}

query "kubernetes_cluster_private_endpoint_enabled" {
  sql = <<-EOQ
    select
    self_link resource,
    case
      when private_cluster_config -> 'enablePrivateEndpoint' = 'true' then 'ok'
      else 'alarm'
    end as status,
    case
      when private_cluster_config -> 'enablePrivateEndpoint' = 'true' then title || ' private nodes enabled.'
      else title || ' private nodes disabled.'
    end as reason
    ${local.tag_dimensions_sql}
    ${local.common_dimensions_sql}
  from
    gcp_kubernetes_cluster;
  EOQ
}

query "kubernetes_cluster_private_nodes_enabled" {
  sql = <<-EOQ
    select
    self_link resource,
    case
      when private_cluster_config -> 'enablePrivateNodes' = 'true' then 'ok'
      else 'alarm'
    end as status,
    case
      when private_cluster_config -> 'enablePrivateNodes' = 'true' then title || ' private nodes enabled.'
      else title || ' private nodes disabled.'
    end as reason
    ${local.tag_dimensions_sql}
    ${local.common_dimensions_sql}
  from
    gcp_kubernetes_cluster;
  EOQ
}

query "kubernetes_cluster_logging_enabled" {
  sql = <<-EOQ
    select
    self_link resource,
    case
      when logging_service is null then 'alarm'
      else 'ok'
    end as status,
    case
      when logging_service is null then title || ' kubernetes logging is not enabled.'
      else title || ' kubernetes logging is enabled.'
    end as reason
    ${local.tag_dimensions_sql}
    ${local.common_dimensions_sql}
  from
    gcp_kubernetes_cluster;
  EOQ
}

query "kubernetes_cluster_workload_identity_enabled" {
  sql = <<-EOQ
    select
    self_link resource,
    case
      when workload_identity_config -> 'workloadPool' = 'null' then 'alarm'
      else 'ok'
    end as status,
    case
      when workload_identity_config -> 'workloadPool' = 'null' then title || ' workload identity is not configured.'
      else title || ' workload identity is configured.'
    end as reason
    ${local.tag_dimensions_sql}
    ${local.common_dimensions_sql}
  from
    gcp_kubernetes_cluster;
  EOQ
}

query "kubernetes_cluster_dashboard_disabled" {
  sql = <<-EOQ
    select
    self_link resource,
    case
      when addons_config -> 'kubernetesDashboard' ->> 'disabled' = 'true' then 'ok'
      else 'alarm'
    end as status,
    case
      when addons_config -> 'kubernetesDashboard' ->> 'disabled' = 'true' then title || ' dashboard disabled.'
      else title || ' dashboard enabled.'
    end as reason
    ${local.tag_dimensions_sql}
    ${local.common_dimensions_sql}
  from
    gcp_kubernetes_cluster;
  EOQ
}

query "kubernetes_cluster_service_account_default" {
  sql = <<-EOQ
    select
    self_link resource,
    case
      when node_config ->> 'serviceAccount' = 'default' then 'alarm'
      else 'ok'
    end as status,
    case
      when node_config ->> 'serviceAccount' = 'default' then title || ' default service account is used for project access.'
      else title || ' default service account is not used for project access.'
    end as reason
    ${local.tag_dimensions_sql}
    ${local.common_dimensions_sql}
  from
    gcp_kubernetes_cluster;
  EOQ
}

query "kubernetes_cluster_legacy_abac_enabled" {
  sql = <<-EOQ
    select
    self_link resource,
    case
      when legacy_abac_enabled then 'alarm'
      else 'ok'
    end as status,
    case
      when legacy_abac_enabled then title || ' Legacy Authorization enabled.'
      else title || ' Legacy Authorization disabled.'
    end as reason
    ${local.tag_dimensions_sql}
    ${local.common_dimensions_sql}
  from
    gcp_kubernetes_cluster;
  EOQ
}

query "kubernetes_cluster_legacy_endpoints_disabled" {
  sql = <<-EOQ
    select
    self_link resource,
    case
      when node_config -> 'metadata' ->> 'disable-legacy-endpoints' = 'true' then 'ok'
      else 'alarm'
    end as status,
    case
      when node_config -> 'metadata' ->> 'disable-legacy-endpoints' = 'true' then title || ' legacy endpoints disabled.'
      else title || ' legacy endpoints enabled.'
    end as reason
    ${local.tag_dimensions_sql}
    ${local.common_dimensions_sql}
  from
    gcp_kubernetes_cluster;
  EOQ
}

query "kubernetes_cluster_intranode_visibility_enabled" {
  sql = <<-EOQ
    select
    self_link resource,
    case
      when network_config -> 'enableIntraNodeVisibility' = 'true' then 'ok'
      else 'alarm'
    end as status,
    case
      when network_config -> 'enableIntraNodeVisibility' = 'true' then title || ' intra-node visibility is enabled.'
      else title || ' intra-node visibility is enabled.'
    end as reason
    ${local.tag_dimensions_sql}
    ${local.common_dimensions_sql}
  from
    gcp_kubernetes_cluster;
  EOQ
}

query "kubernetes_cluster_integrity_monitoring_enabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when node_config -> 'shieldedInstanceConfig' ->> 'enableIntegrityMonitoring' = 'true' then 'ok'
        else 'alarm'
      end as status,
      case
        when node_config -> 'shieldedInstanceConfig' ->> 'enableIntegrityMonitoring' = 'true' then title || ' Integrity Monitoring for Shielded GKE Nodes is Enabled.'
        else title || ' Integrity Monitoring for Shielded GKE Nodes is not Enabled.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_kubernetes_cluster;
  EOQ
}

query "kubernetes_cluster_secure_boot_enabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when node_config -> 'shieldedInstanceConfig' ->> 'enableSecureBoot' = 'true' then 'ok'
        else 'alarm'
      end as status,
      case
        when node_config -> 'shieldedInstanceConfig' ->> 'enableSecureBoot' = 'true' then title || ' Secure Boot for Shielded GKE Nodes is Enabled.'
        else title || ' Secure Boot for Shielded GKE Nodes is not Enabled.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_kubernetes_cluster;
  EOQ
}

query "kubernetes_cluster_use_ip_aliases" {
  sql = <<-EOQ
    select
    self_link resource,
    case
      when ip_allocation_policy ->> 'useIpAliases' = 'true' then 'ok'
      else 'alarm'
    end as status,
    case
      when ip_allocation_policy ->> 'useIpAliases' = 'true' then title || ' Alias IP ranges enabled.'
      else title || ' alias IP ranges disabled.'
    end as reason
    ${local.tag_dimensions_sql}
    ${local.common_dimensions_sql}
  from
    gcp_kubernetes_cluster;
  EOQ
}

query "kubernetes_cluster_auto_repair_enabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when np -> 'management' -> 'autoRepair' = 'true' then 'ok'
        else 'alarm'
      end as status,
      case
        when np -> 'management' -> 'autoRepair' = 'true' then title || ' Node pool auto repair enabled.'
        else title || ' Node pool auto repair disabled.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_kubernetes_cluster,
      jsonb_array_elements(node_pools) as np;
  EOQ
}

query "kubernetes_cluster_auto_upgrade_enabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when np -> 'management' -> 'autoUpgrade' = 'true' then 'ok'
        else 'alarm'
      end as status,
      case
        when np -> 'management' -> 'autoUpgrade' = 'true' then title || ' Node pool auto upgrade enabled.'
        else title || ' Node pool auto upgrade disabled.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_kubernetes_cluster,
      jsonb_array_elements(node_pools) as np;
  EOQ
}

query "kubernetes_cluster_master_authorized_networks_config_enabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when master_authorized_networks_config -> 'enabled' = 'true' then 'ok'
        else 'alarm'
      end as status,
      case
        when master_authorized_networks_config -> 'enabled' = 'true' then title || ' master authorized networks is enabled.'
        else title || ' master authorized networks is disabled.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_kubernetes_cluster;
  EOQ
}

query "kubernetes_cluster_node_config_image_cos_containerd" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when node_config ->> 'imageType' = 'COS_CONTAINERD' then 'ok'
        else 'alarm'
      end as status,
      case
        when node_config ->> 'imageType' = 'COS_CONTAINERD' then title || ' Container-Optimized OS(COS) is used.'
        else title || ' Container-Optimized OS(COS) not used.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_kubernetes_cluster;
  EOQ
}

query "kubernetes_cluster_network_policy_installed" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when network_policy ->> 'enabled' = 'true' then 'ok'
        else 'alarm'
      end as status,
      case
        when network_policy ->> 'enabled' = 'true' then title || ' Network policy is enabled.'
        else title || ' Network policy is not enabled.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_kubernetes_cluster;
  EOQ
}
