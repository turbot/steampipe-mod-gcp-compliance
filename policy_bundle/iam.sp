locals {
  policy_bundle_iam_common_tags = {
    service = "iam"
  }
}

control "denylist_public_users" {
  title         = "Prevent public users from having access to resources via IAM"
  sql           = query.iam_user_denylist_public.sql

  tags = merge(local.policy_bundle_iam_common_tags, {
    cft_scorecard_v1        = "true"
    forseti_security_v226   = "true"
    severity                = "high"
  })
}

control "only_my_domain" {
  title         = "Only allow members from my domain to be added to IAM roles"
  sql           = query.iam_user_uses_corporate_login_credentials.sql

  tags = merge(local.policy_bundle_iam_common_tags, {
    forseti_security_v226   = "true"
    severity                = "high"
  })
}

control "iam_restrict_service_account_key_age_one_hundred_days" {
  title         = "Check if service account keys are older than 100 days"
  sql           = query.iam_service_account_key_age_100.sql

  tags = merge(local.policy_bundle_iam_common_tags, {
    forseti_security_v226   = "true"
    severity                = "high"
  })
}