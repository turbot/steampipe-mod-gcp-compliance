locals {
  all_controls_iam_common_tags = merge(local.all_controls_common_tags, {
    service = "GCP/IAM"
  })
}

benchmark "all_controls_iam" {
  title       = "IAM"
  description = "This section contains recommendations for configuring IAM resources."
  children = [
    control.denylist_public_users,
    control.iam_api_key_age_90,
    control.iam_api_key_restricts_apis,
    control.iam_api_key_restricts_websites_hosts_apps,
    control.iam_restrict_service_account_key_age_one_hundred_days,
    control.iam_service_account_gcp_managed_key,
    control.iam_service_account_key_age_90,
    control.iam_service_account_without_admin_privilege,
    control.iam_user_not_assigned_service_account_user_role_project_level,
    control.iam_user_separation_of_duty_enforced,
    control.only_my_domain
  ]

  tags = merge(local.all_controls_iam_common_tags, {
    type = "Benchmark"
  })
}
