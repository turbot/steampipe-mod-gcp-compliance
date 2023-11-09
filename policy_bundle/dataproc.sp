locals {
  policy_bundle_dataproc_common_tags = merge(local.gcp_compliance_common_tags, {
    service = "GCP/Dataproc"
  })
}

control "dataproc_cluster_encryption_with_cmek" {
  title       = "Ensure that dataproc cluster is encrypted using customer-managed encryption key"
  description = "When you use Dataproc, cluster, and job data is stored on Persistent Disks (PDs) associated with the Compute Engine VMs in your cluster and in a Cloud Storage staging bucket. This PD and bucket data is encrypted using a Google-generated data encryption key (DEK) and key encryption key (KEK). The CMEK feature allows you to create, use, and revoke the key-encryption key (KEK). Google still controls the data encryption key (DEK)."
  query       = query.dataproc_cluster_encryption_with_cmek

  tags = local.policy_bundle_dataproc_common_tags
}

query "dataproc_cluster_encryption_with_cmek" {
  sql = <<-EOQ
    select
      cluster_name resource,
      case
        when config -> 'encryptionConfig' ->> 'gcePdKmsKeyName' is null then 'alarm'
        else 'ok'
      end as status,
      case
        when config -> 'encryptionConfig' ->> 'gcePdKmsKeyName' is null
          then title || ' is not encrypted using customer-managed encryption keys (CMEK).'
        else title || ' is encrypted using customer-managed encryption keys (CMEK).'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      gcp_dataproc_cluster;
  EOQ
}
