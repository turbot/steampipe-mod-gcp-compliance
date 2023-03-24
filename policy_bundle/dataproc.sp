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
