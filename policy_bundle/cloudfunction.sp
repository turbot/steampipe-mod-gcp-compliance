locals {
  policy_bundle_cloudfunction_common_tags = merge(local.gcp_compliance_common_tags, {
    service = "GCP/CloudFunctions"
  })
}

control "cloudfunction_function_vpc_connector_enabled" {
  title       = "Cloudfunction functions VPC connector should be enabled"
  description = "It is recommended that Cloudfunction functions VPC connector is enabled."
  query       = query.cloudfunction_function_vpc_connector_enabled

  tags = local.policy_bundle_cloudfunction_common_tags
}

query "cloudfunction_function_vpc_connector_enabled" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when vpc_connector is null or vpc_connector = '' then 'alarm'
        else 'ok'
      end as status,
      case
        when vpc_connector is null or vpc_connector = '' then name || ' VPC connector disabled.'
        else name || ' VPC connector enabled.'
      end as reason
      --${local.tag_dimensions_sql}
      --${local.common_dimensions_sql}
    from
      gcp_cloudfunctions_function;
  EOQ
}
