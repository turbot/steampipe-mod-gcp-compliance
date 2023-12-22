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

control "cloudfunction_function_no_ingress_settings_allow_all" {
  title       = "Cloudfunction functions ingress settings should not be set to allow all"
  description = "It is recommended that Cloudfunction functions ingress settings should not be set to allow all as it allow all inbound requests to the function."
  query       = query.cloudfunction_function_no_ingress_settings_allow_all

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

query "cloudfunction_function_no_ingress_settings_allow_all" {
  sql = <<-EOQ
    select
      self_link resource,
      case
        when ingress_settings  = 'ALLOW_ALL' then 'alarm'
        else 'ok'
      end as status,
      case
        when ingress_settings = 'ALLOW_ALL' then name || ' ingress settings is set to allow all.'
        else name || ' ingress settings is not set to allow all.'
      end as reason
      --${local.tag_dimensions_sql}
      --${local.common_dimensions_sql}
    from
      gcp_cloudfunctions_function;
  EOQ
}