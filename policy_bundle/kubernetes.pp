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
    pci_dss_v321     = "true"
    severity         = "high"
  })
}

control "disable_gke_dashboard" {
  title = "Ensure Kubernetes web UI/Dashboard is disabled"
  query = query.kubernetes_cluster_dashboard_disabled

  tags = merge(local.policy_bundle_kubernetes_common_tags, {
    cft_scorecard_v1 = "true"
    pci_dss_v321     = "true"
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
    pci_dss_v321     = "true"
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
    pci_dss_v321     = "true"
    severity         = "high"
  })
}

control "enable_auto_repair" {
  title = "Ensure automatic node repair is enabled on all node pools in a GKE cluster"
  query = query.kubernetes_cluster_auto_repair_enabled

  tags = merge(local.policy_bundle_kubernetes_common_tags, {
    cft_scorecard_v1 = "true"
    pci_dss_v321     = "true"
    severity         = "high"
  })
}

control "enable_auto_upgrade" {
  title = "Ensure Automatic node upgrades is enabled on Kubernetes Engine Clusters nodes"
  query = query.kubernetes_cluster_auto_upgrade_enabled

  tags = merge(local.policy_bundle_kubernetes_common_tags, {
    cft_scorecard_v1 = "true"
    nist_csf_v2      = "true"
    pci_dss_v321     = "true"
    severity         = "high"
  })
}

control "enable_gke_master_authorized_networks" {
  title = "Ensure Master authorized networks is set to Enabled on Kubernetes Engine Clusters"
  query = query.kubernetes_cluster_master_authorized_networks_config_enabled

  tags = merge(local.policy_bundle_kubernetes_common_tags, {
    cft_scorecard_v1 = "true"
    nist_csf_v2      = "true"
    pci_dss_v321     = "true"
    severity         = "high"
  })
}

control "gke_container_optimized_os" {
  title = "Ensure Container-Optimized OS (cos) is used for Kubernetes engine clusters"
  query = query.kubernetes_cluster_node_config_image_cos_containerd

  tags = merge(local.policy_bundle_kubernetes_common_tags, {
    cft_scorecard_v1 = "true"
    pci_dss_v321     = "true"
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
  title       = "GKE clusters kubernetes alpha should be enabled"
  description = "This control ensures that GKE clusters kubernetes alpha is enabled."
  query       = query.kubernetes_cluster_kubernetes_alpha_enabled

  tags = local.policy_bundle_kubernetes_common_tags
}

control "kubernetes_cluster_logging_enabled" {
  title       = "GKE clusters logging should be enabled"
  description = "This control ensures that GKE clusters logging is enabled."
  query       = query.kubernetes_cluster_logging_enabled

  tags = merge(local.policy_bundle_kubernetes_common_tags, {
    nist_csf_v2  = "true"
    pci_dss_v321 = "true"
  })
}

control "kubernetes_cluster_monitoring_enabled" {
  title       = "GKE clusters monitoring should be enabled"
  description = "This control ensures that GKE clusters monitoring is enabled."
  query       = query.kubernetes_cluster_monitoring_enabled

  tags = merge(local.policy_bundle_kubernetes_common_tags, {
    nist_csf_v2  = "true"
  })
}

control "kubernetes_cluster_no_default_network" {
  title       = "GKE clusters should not use default network"
  description = "This control ensures that GKE clusters does not use default network."
  query       = query.kubernetes_cluster_no_default_network

  tags = merge(local.policy_bundle_kubernetes_common_tags, {
    nist_csf_v2  = "true"
  })
}

control "kubernetes_cluster_with_resource_labels" {
  title       = "GKE clusters should have resource labels"
  description = "This control ensures that GKE clusters have resource labels."
  query       = query.kubernetes_cluster_with_resource_labels

  tags = local.policy_bundle_kubernetes_common_tags
}

control "kubernetes_cluster_database_encryption_enabled" {
  title       = "GKE clusters should have database encryption enabled"
  description = "This control ensures that GKE clusters have database encryption enabled."
  query       = query.kubernetes_cluster_database_encryption_enabled

  tags = local.policy_bundle_kubernetes_common_tags
}

control "kubernetes_cluster_shielded_nodes_enabled" {
  title       = "GKE clusters should have shielded nodes enabled"
  description = "This control ensures that GKE clusters have shielded nodes enabled."
  query       = query.kubernetes_cluster_shielded_nodes_enabled

  tags = merge(local.policy_bundle_kubernetes_common_tags, {
    nist_csf_v2  = "true"
  })
}

control "kubernetes_cluster_shielded_instance_integrity_monitoring_enabled" {
  title       = "GKE clusters shielded nodes integrity monitoring should be enabled"
  description = "This control ensures that GKE clusters shielded nodes integrity monitoring is enabled."
  query       = query.kubernetes_cluster_shielded_instance_integrity_monitoring_enabled

  tags = merge(local.policy_bundle_kubernetes_common_tags, {
    nist_csf_v2  = "true"
  })
}

control "kubernetes_cluster_binary_authorization_enabled" {
  title       = "GKE clusters binary authorization should be enabled"
  description = "This control ensures that GKE clusters binary authorization is enabled."
  query       = query.kubernetes_cluster_binary_authorization_enabled

  tags = merge(local.policy_bundle_kubernetes_common_tags, {
    nist_csf_v2  = "true"
  })
}

control "kubernetes_cluster_release_channel_configured" {
  title       = "GKE clusters release channel should be configured"
  description = "This control ensures that GKE clusters uses release channel for version management."
  query       = query.kubernetes_cluster_release_channel_configured

  tags = local.policy_bundle_kubernetes_common_tags
}

control "kubernetes_cluster_zone_redundant" {
  title       = "GKE clusters release should be zone redundant"
  description = "This control ensures that GKE clusters is located in at least three zones."
  query       = query.kubernetes_cluster_zone_redundant

  tags = local.policy_bundle_kubernetes_common_tags
}

control "kubernetes_cluster_private_nodes_configured" {
  title       = "GKE clusters private nodes should be configured"
  description = "This control ensures that GKE clusters private nodes are configured."
  query       = query.kubernetes_cluster_private_nodes_configured

  tags = merge(local.policy_bundle_kubernetes_common_tags, {
    nist_csf_v2  = "true"
  })
}

control "kubernetes_cluster_network_policy_enabled" {
  title       = "GKE clusters network policy should be enabled"
  description = "This control ensures that GKE clusters network policy is enabled."
  query       = query.kubernetes_cluster_network_policy_enabled

  tags = merge(local.policy_bundle_kubernetes_common_tags, {
    nist_csf_v2  = "true"
    pci_dss_v321 = "true"
  })
}

control "kubernetes_cluster_client_certificate_authentication_enabled" {
  title       = "GKE clusters client certificate authentication should be enabled"
  description = "This control ensures that GKE clusters client certificate authentication is enabled."
  query       = query.kubernetes_cluster_client_certificate_authentication_enabled

  tags = merge(local.policy_bundle_kubernetes_common_tags, {
    nist_csf_v2  = "true"
  })
}

control "kubernetes_cluster_node_no_default_service_account" {
  title       = "GKE clusters nodes should not use default service account"
  description = "This control ensures that GKE clusters nodes does not uses default service account. It is recommended to create and use a least privileged service account to run your GKE cluster instead of using the default service account."
  query       = query.kubernetes_cluster_node_no_default_service_account

  tags = merge(local.policy_bundle_kubernetes_common_tags, {
    pci_dss_v321 = "true"
  })
}

control "kubernetes_cluster_with_less_than_three_node_auto_upgrade_enabled" {
  title       = "GKE clusters with less than three nodes should have auto upgrade enabled"
  description = "This control ensures that clusters with less than three nodes should have auto upgrade enabled."
  query       = query.kubernetes_cluster_with_less_than_three_node_auto_upgrade_enabled

  tags = merge(local.policy_bundle_kubernetes_common_tags, {
    nist_csf_v2  = "true"
  })
}

control "kubernetes_cluster_incoming_traffic_open_to_all" {
  title       = "GKE clusters should not allow incoming traffic from all sources across the internet"
  description = "This control ensures that GKE clusters do not allow incoming traffic from all sources across the internet."
  query       = query.kubernetes_cluster_incoming_traffic_open_to_all

  tags = local.policy_bundle_kubernetes_common_tags
}

control "kubernetes_cluster_http_load_balancing_enabled" {
  title       = "GKE clusters HTTP load balancing should be enabled"
  description = "This control ensures that GKE clusters HTTP load balancing is enabled. This control is non-complaint if HTTP load balancing is disabled."
  query       = query.kubernetes_cluster_http_load_balancing_enabled

  tags = local.policy_bundle_kubernetes_common_tags
}

control "kubernetes_cluster_intra_node_visibility_enabled" {
  title       = "GKE clusters intra node visibility should be enabled"
  description = "This control ensures that GKE clusters intra node visibility is enabled. This control is non-complaint if intra node visibility is disabled."
  query       = query.kubernetes_cluster_intra_node_visibility_enabled

  tags = local.policy_bundle_kubernetes_common_tags
}

control "kubernetes_cluster_shielded_node_secure_boot_enabled" {
  title       = "GKE clusters shielded node secure boot should be enabled"
  description = "This control ensures that GKE clusters shielded node secure boot is enabled. This control is non-complaint if ishielded node secure boot is disabled."
  query       = query.kubernetes_cluster_shielded_node_secure_boot_enabled

  tags = merge(local.policy_bundle_kubernetes_common_tags, {
    nist_csf_v2  = "true"
  })
}

control "kubernetes_cluster_subnetwork_private_ip_google_access_enabled" {
  title       = "Ensure Private Google Access is enabled for all subnetworks in kubernetes cluster"
  description = "This control ensures that GKE clusters subnetworks have private google access enabled."
  query       = query.kubernetes_cluster_subnetwork_private_ip_google_access_enabled

  tags = merge(local.policy_bundle_kubernetes_common_tags, {
    nist_csf_v2  = "true"
    pci_dss_v321 = "true"
  })
}

query "kubernetes_cluster_private_cluster_config_enabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when (private_cluster_config -> 'enablePrivateEndpoint')::bool then 'ok'
        else 'alarm'
      end as status,
      case
        when (private_cluster_config -> 'enablePrivateEndpoint')::bool then title || ' is not publicly accessible.'
        else title || ' is publicly accessible.'
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
      when addons_config -> 'KubernetesDashboard' ->> 'disabled' = 'true' then 'ok'
      else 'alarm'
    end as status,
    case
      when addons_config -> 'KubernetesDashboard' ->> 'disabled' = 'true' then title || ' dashboard disabled.'
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
      when node_config ->> 'ServiceAccount' = 'default' then 'alarm'
      else 'ok'
    end as status,
    case
      when node_config ->> 'ServiceAccount' = 'default' then title || ' default service account is used for project access.'
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
      when node_config -> 'Metadata' ->> 'disable-legacy-endpoints' = 'true' then 'ok'
      else 'alarm'
    end as status,
    case
      when node_config -> 'Metadata' ->> 'disable-legacy-endpoints' = 'true' then title || ' legacy endpoints disabled.'
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
        when node_config ->> 'ImageType' = 'COS_CONTAINERD' then 'ok'
        else 'alarm'
      end as status,
      case
        when node_config ->> 'ImageType' = 'COS_CONTAINERD' then title || ' Container-Optimized OS(COS) is used.'
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
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
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
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
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
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
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
       when resource_labels is null then title || ' does not have resource labels.'
        else title || ' have resource labels.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
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
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
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
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_kubernetes_cluster;
  EOQ
}

query "kubernetes_cluster_shielded_instance_integrity_monitoring_enabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when (node_config -> 'ShieldedInstanceConfig' ->> 'EnableIntegrityMonitoring')::bool then 'ok'
        else 'alarm'
      end as status,
      case
       when (node_config -> 'ShieldedInstanceConfig' ->> 'EnableIntegrityMonitoring')::bool then title || ' shielded instance integrity monitoring enabled.'
        else title || ' shielded instance integrity monitoring disabled.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_kubernetes_cluster;
  EOQ
}

query "kubernetes_cluster_binary_authorization_enabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when binary_authorization is null
        or (binary_authorization ->> 'evaluationMode') ilike 'DISABLED'
        or (binary_authorization ->> 'evaluationMode') ilike 'EVALUATION_MODE_UNSPECIFIED' then 'alarm'
        else 'ok'
      end as status,
      case
       when binary_authorization is null
        or (binary_authorization ->> 'evaluationMode') ilike 'DISABLED'
        or (binary_authorization ->> 'evaluationMode') ilike 'EVALUATION_MODE_UNSPECIFIED' then title || ' binary authorization disabled.'
        else title || ' binary authorization enabled.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_kubernetes_cluster;
  EOQ
}

query "kubernetes_cluster_release_channel_configured" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when (release_channel -> 'channel') is not null then 'ok'
        else 'alarm'
      end as status,
      case
       when (release_channel -> 'channel') is not null then title || ' release channel configured.'
        else title || ' release channel not configured.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_kubernetes_cluster;
  EOQ
}

query "kubernetes_cluster_zone_redundant" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when zone is not null and jsonb_array_length(locations) >= 3 then 'ok'
        else 'alarm'
      end as status,
      case
        when zone is not null and jsonb_array_length(locations) >= 3 then title || ' zone redundant.'
        else title || ' not zone redundant.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_kubernetes_cluster;
  EOQ
}

query "kubernetes_cluster_private_nodes_configured" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when private_cluster_config ->> 'enablePrivateNodes' = 'false'
          or private_cluster_config -> 'enablePrivateNodes' is null then 'alarm'
        else 'ok'
      end as status,
      case
        when private_cluster_config ->> 'enablePrivateNodes' = 'false'
          or private_cluster_config -> 'enablePrivateNodes' is null then title || ' private nodes not configured.'
        else title || ' private nodes configured.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_kubernetes_cluster;
  EOQ
}

query "kubernetes_cluster_network_policy_enabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when (addons_config -> 'NetworkPolicyConfig' ->> 'disabled' = 'true'
          or addons_config -> 'NetworkPolicyConfig' -> 'enabled' is null
          or addons_config -> 'NetworkPolicyConfig' ->> 'enabled' = 'false'
          )
          and network_config ->> 'DatapathProvider' <> 'ADVANCED_DATAPATH'
           then 'alarm'
        else 'ok'
      end as status,
      case
        when (addons_config -> 'NetworkPolicyConfig' ->> 'disabled' = 'true'
          or addons_config -> 'NetworkPolicyConfig' -> 'enabled' is null
          or addons_config -> 'NetworkPolicyConfig' ->> 'enabled' = 'false'
          )
          and network_config ->> 'DatapathProvider' <> 'ADVANCED_DATAPATH'
          then title || ' network policy disabled.'
        else title || ' network policy enabled.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_kubernetes_cluster;
  EOQ
}

query "kubernetes_cluster_client_certificate_authentication_enabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when master_auth -> 'clusterCaCertificate' is not null or  master_auth -> 'clientKey' is not null then 'ok'
        else 'alarm'
      end as status,
      case
        when master_auth -> 'clusterCaCertificate' is not null or  master_auth -> 'clientKey' is not null then title || ' client certificate authentication enabled.'
        else title || ' client certificate authentication disabled.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_kubernetes_cluster;
  EOQ
}

query "kubernetes_cluster_node_no_default_service_account" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when np -> 'config' ->> 'serviceAccount' = 'default' then 'alarm'
        else 'ok'
      end as status,
      case
        when np -> 'config' ->> 'serviceAccount' = 'default' then title || ' cluster ' || ( np ->> 'name' ) || ' uses default service account.'
        else title || ' cluster ' || ( np ->> 'name' ) || ' does not uses default service account.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_kubernetes_cluster,
      jsonb_array_elements(node_pools) as np;
  EOQ
}

query "kubernetes_cluster_with_less_than_three_node_auto_upgrade_enabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when np -> 'management' -> 'autoUpgrade' = 'true' and current_node_count < 3 then 'alarm'
        else 'ok'
      end as status,
      title || ' has ' || current_node_count || ' node(s) with auto upgrade enabled.' as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_kubernetes_cluster,
      jsonb_array_elements(node_pools) as np;
  EOQ
}

query "kubernetes_cluster_incoming_traffic_open_to_all" {
  sql = <<-EOQ
    with network_open_to_all as (
      select
        distinct network
      from
        gcp_compute_firewall
      where
        direction = 'INGRESS'
        and action = 'Allow'
        and source_ranges ?& array['0.0.0.0/0']
    )
    select
      distinct self_link resource,
      case
        when a.network is not null then 'alarm'
        else 'ok'
      end as status,
      case
        when a.network is not null then title || ' allows incoming traffic from any source on the internet across all protocols.'
        else title || ' restrict incoming traffic from any source on the internet across all protocols.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_kubernetes_cluster as c
      left join network_open_to_all as a on c.network_config ->> 'network' = concat('projects/' || split_part(a.network, 'projects/', 2));
  EOQ
}

query "kubernetes_cluster_http_load_balancing_enabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when addons_config -> 'HttpLoadBalancing' ->> 'Disabled' = 'false' then 'ok'
        else 'alarm'
      end as status,
      case
        when addons_config -> 'HttpLoadBalancing' ->> 'Disabled' = 'false' then title || ' HTTP load balancing enabled.'
        else title || ' HTTP load balancing disabled.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_kubernetes_cluster;
  EOQ
}

query "kubernetes_cluster_intra_node_visibility_enabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when (network_config -> 'EnableIntraNodeVisibility')::bool then 'ok'
        else 'alarm'
      end as status,
      case
        when (network_config -> 'EnableIntraNodeVisibility')::bool then title || ' intra node visibility enabled.'
        else title || ' intra node visibility disabled.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_kubernetes_cluster;
  EOQ
}

query "kubernetes_cluster_shielded_node_secure_boot_enabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when (node_config -> 'ShieldedInstanceConfig' -> 'EnableSecureBoot')::bool then 'ok'
        else 'alarm'
      end as status,
      case
        when (node_config -> 'ShieldedInstanceConfig' -> 'EnableSecureBoot')::bool then title || ' shielded nodes secure boot enabled.'
        else title || ' shielded nodes secure boot disabled.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_kubernetes_cluster;
  EOQ
}

query "kubernetes_cluster_subnetwork_private_ip_google_access_enabled" {
  sql = <<-EOQ
    select
      c.self_link resource,
      case
        when s.private_ip_google_access then 'ok'
        else 'alarm'
      end as status,
      case
        when s.private_ip_google_access then c.title || ' private Google Access is enabled.'
        else c.title || ' private Google Access is disabled.'
      end as reason
      ${replace(local.tag_dimensions_qualifier_sql, "__QUALIFIER__", "c.")}
      ${replace(local.common_dimensions_qualifier_sql, "__QUALIFIER__", "c.")}
    from
      gcp_kubernetes_cluster as c
      left join gcp_compute_subnetwork as s on concat('projects' , split_part(s.self_link , '/projects' ,2)) = c.network_config ->> 'Subnetwork';
  EOQ
}
