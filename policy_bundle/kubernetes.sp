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

control "kubernetes_cluster_kubernetes_alpha_enabled" {
  title = "GKE clusters kubernetes alpha should be enabled"
  description = "This control ensures that GKE clusters kubernetes alpha is enabled."
  query = query.kubernetes_cluster_kubernetes_alpha_enabled

  tags = local.policy_bundle_kubernetes_common_tags
}

control "kubernetes_cluster_logging_enabled" {
  title = "GKE clusters logging should be enabled"
  description = "This control ensures that GKE clusters logging is enabled."
  query = query.kubernetes_cluster_kubernetes_alpha_enabled

  tags = local.kubernetes_cluster_logging_enabled
}

control "kubernetes_cluster_monitoring_enabled" {
  title = "GKE clusters monitoring should be enabled"
  description = "This control ensures that GKE clusters monitoring is enabled."
  query = query.kubernetes_cluster_kubernetes_alpha_enabled

  tags = local.kubernetes_cluster_monitoring_enabled
}

control "kubernetes_cluster_no_default_network" {
  title = "GKE clusters should not use default network"
  description = "This control ensures that GKE clusters does not use default network."
  query = query.kubernetes_cluster_kubernetes_alpha_enabled

  tags = local.kubernetes_cluster_no_default_network
}

control "kubernetes_cluster_with_resource_labels" {
  title = "GKE clusters should have resource labels"
  description = "This control ensures that GKE clusters have resource labels."
  query = query.kubernetes_cluster_kubernetes_alpha_enabled

  tags = local.kubernetes_cluster_with_resource_labels
}

control "kubernetes_cluster_database_encryption_enabled" {
  title = "GKE clusters should have database encryption enabled"
  description = "This control ensures that GKE clusters have database encryption enabled."
  query = query.kubernetes_cluster_kubernetes_alpha_enabled

  tags = local.kubernetes_cluster_database_encryption_enabled
}

control "kubernetes_cluster_shielded_nodes_enabled" {
  title = "GKE clusters should have shielded nodes enabled"
  description = "This control ensures that GKE clusters have shielded nodes enabled."
  query = query.kubernetes_cluster_kubernetes_alpha_enabled

  tags = local.kubernetes_cluster_shielded_nodes_enabled
}

control "kubernetes_cluster_shielded_instance_integrity_monitoring_enabled" {
  title = "GKE clusters shielded nodes integrity monitoring should be enabled"
  description = "This control ensures that GKE clusters shielded nodes integrity monitoring is enabled."
  query = query.kubernetes_cluster_shielded_instance_integrity_monitoring_enabled

  tags = local.kubernetes_cluster_shielded_nodes_enabled
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

query "kubernetes_cluster_kubernetes_alpha_enabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when enable_kubernetes_alpha then 'ok'
        else 'alarm'
      end as status,
      case
        when enable_kubernetes_alpha then title || ' kubernetes alpha enabled.'
        else title || ' kubernetes alpha disabled.'
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
        when logging_service is null or logging_service = 'none' then 'alarm'
        else 'ok'
      end as status,
      case
       when logging_service is null or logging_service = 'none' then title || ' logging disabled.'
        else title || ' logging enabled.'
      end as reason
      --${local.tag_dimensions_sql}
      --${local.common_dimensions_sql}
    from
      gcp_kubernetes_cluster;
  EOQ
}

query "kubernetes_cluster_monitoring_enabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when monitoring_service is null or monitoring_service = 'none' then 'alarm'
        else 'ok'
      end as status,
      case
       when monitoring_service is null or monitoring_service = 'none' then title || ' monitoring disabled.'
        else title || ' monitoring enabled.'
      end as reason
      --${local.tag_dimensions_sql}
      --${local.common_dimensions_sql}
    from
      gcp_kubernetes_cluster;
  EOQ
}

query "kubernetes_cluster_no_default_network" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when network = 'default' then 'alarm'
        else 'ok'
      end as status,
      case
       when network = 'default' then title || ' using default network.'
        else title || ' not using default network.'
      end as reason
      --${local.tag_dimensions_sql}
      --${local.common_dimensions_sql}
    from
      gcp_kubernetes_cluster;
  EOQ
}

query "kubernetes_cluster_with_resource_labels" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when resource_labels is null then 'alarm'
        else 'ok'
      end as status,
      case
       when resource_labels is null then title || ' not having resource labels.'
        else title || ' have resource labels.'
      end as reason
      --${local.tag_dimensions_sql}
      --${local.common_dimensions_sql}
    from
      gcp_kubernetes_cluster;
  EOQ
}

query "kubernetes_cluster_database_encryption_enabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when database_encryption_state <> 'ENCRYPTED' then 'alarm'
        else 'ok'
      end as status,
      case
       when database_encryption_state <> 'ENCRYPTED' then title || ' database encryption disabled.'
        else title || ' database encryption enabled.'
      end as reason
      --${local.tag_dimensions_sql}
      --${local.common_dimensions_sql}
    from
      gcp_kubernetes_cluster;
  EOQ
}

query "kubernetes_cluster_shielded_nodes_enabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when shielded_nodes_enabled then 'ok'
        else 'alarm'
      end as status,
      case
       when shielded_nodes_enabled then title || ' shielded nodes enabled.'
        else title || ' shielded nodes disabled.'
      end as reason
      --${local.tag_dimensions_sql}
      --${local.common_dimensions_sql}
    from
      gcp_kubernetes_cluster;
  EOQ
}

query "kubernetes_cluster_shielded_instance_integrity_monitoring_enabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when (node_config -> 'shieldedInstanceConfig' ->> 'enableIntegrityMonitoring')::bool then 'ok'
        else 'alarm'
      end as status,
      case
       when (node_config -> 'shieldedInstanceConfig' ->> 'enableIntegrityMonitoring')::bool then title || ' shielded instance integrity monitoring enabled.'
        else title || ' shielded instance integrity monitoring disabled.'
      end as reason
      --${local.tag_dimensions_sql}
      --${local.common_dimensions_sql}
    from
      gcp_kubernetes_cluster;
  EOQ
}

# query "kubernetes_cluster_http_load_balancing_enabled" {
#   sql = <<-EOQ
#     select
#     self_link resource,
#     case
#       when addons_config -> 'httpLoadBalancing' ->> 'disabled' = 'true' then 'ok'
#       else 'alarm'
#     end as status,
#     case
#       when addons_config -> 'httpLoadBalancing' ->> 'disabled' = 'true' then title || ' dashboard disabled.'
#       else title || ' dashboard enabled.'
#     end as reason
#     ${local.tag_dimensions_sql}
#     ${local.common_dimensions_sql}
#   from
#     gcp_kubernetes_cluster;
#   EOQ
# }
