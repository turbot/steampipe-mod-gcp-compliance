locals {
  cis_v130_1_common_tags = merge(local.cis_v130_common_tags, {
    cis_section_id = "1"
  })
}

benchmark "cis_v130_1" {
  title         = "1 Identity and Access Management"
  documentation = file("./cis_v130/docs/cis_v130_1.md")
  children = [
    control.cis_v130_1_1,
    control.cis_v130_1_2,
    control.cis_v130_1_3,
    control.cis_v130_1_4,
    control.cis_v130_1_5,
    control.cis_v130_1_6,
    control.cis_v130_1_7,
    control.cis_v130_1_8,
    control.cis_v130_1_9,
    control.cis_v130_1_10,
    control.cis_v130_1_11,
    control.cis_v130_1_12,
    control.cis_v130_1_13,
    control.cis_v130_1_14,
    control.cis_v130_1_15,
    control.cis_v130_1_16,
    control.cis_v130_1_17,
    control.cis_v130_1_18
  ]

  tags = merge(local.cis_v130_1_common_tags, {
    type = "Benchmark"
  })
}

control "cis_v130_1_1" {
  title         = "1.1 Ensure that corporate login credentials are used"
  description   = "Use corporate login credentials instead of personal accounts, such as Gmail accounts."
  query         = query.iam_user_uses_corporate_login_credentials.sql
  documentation = file("./cis_v130/docs/cis_v130_1_1.md")

  tags = merge(local.cis_v130_1_common_tags, {
    cis_item_id = "1.1"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/IAM"
  })
}

control "cis_v130_1_2" {
  title         = "1.2 Ensure that multi-factor authentication is enabled for all non-service accounts"
  description   = "Setup multi-factor authentication for Google Cloud Platform accounts."
  query         = query.manual_control.sql
  documentation = file("./cis_v130/docs/cis_v130_1_2.md")

  tags = merge(local.cis_v130_1_common_tags, {
    cis_item_id = "1.2"
    cis_level   = "1"
    cis_type    = "manual"
    service     = "GCP/IAM"
  })
}

control "cis_v130_1_3" {
  title         = "1.3 Ensure that Security Key Enforcement is enabled for all admin accounts"
  description   = "Setup Security Key Enforcement for Google Cloud Platform admin accounts."
  query         = query.manual_control.sql
  documentation = file("./cis_v130/docs/cis_v130_1_3.md")

  tags = merge(local.cis_v130_1_common_tags, {
    cis_item_id = "1.3"
    cis_level   = "2"
    cis_type    = "manual"
    service     = "GCP/IAM"
  })
}

control "cis_v130_1_4" {
  title         = "1.4 Ensure that there are only GCP-managed service account keys for each service account"
  description   = "User managed service accounts should not have user-managed keys."
  query         = query.iam_service_account_gcp_managed_key.sql
  documentation = file("./cis_v130/docs/cis_v130_1_4.md")

  tags = merge(local.cis_v130_1_common_tags, {
    cis_item_id = "1.4"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/IAM"
  })
}

control "cis_v130_1_5" {
  title         = "1.5 Ensure that Service Account has no Admin privileges"
  description   = "A service account is a special Google account that belongs to an application or a VM, instead of to an individual end-user. The application uses the service account to call the service's Google API so that users aren't directly involved. It's recommended not to use admin access for ServiceAccount."
  query         = query.iam_service_account_without_admin_privilege.sql
  documentation = file("./cis_v130/docs/cis_v130_1_5.md")

  tags = merge(local.cis_v130_1_common_tags, {
    cis_item_id = "1.5"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/IAM"
  })
}

control "cis_v130_1_6" {
  title         = "1.6 Ensure that IAM users are not assigned the Service Account User or Service Account Token Creator roles at project level"
  description   = "It is recommended to assign the Service Account User (iam.serviceAccountUser) and Service Account Token Creator (iam.serviceAccountTokenCreator) roles to a user for a specific service account rather than assigning the role to a user at project level."
  query         = query.iam_user_not_assigned_service_account_user_role_project_level.sql
  documentation = file("./cis_v130/docs/cis_v130_1_6.md")

  tags = merge(local.cis_v130_1_common_tags, {
    cis_item_id = "1.6"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/IAM"
  })
}

control "cis_v130_1_7" {
  title         = "1.7 Ensure user-managed/external keys for service accounts are rotated every 90 days or less"
  description   = "Service Account keys consist of a key ID (Private_key_Id) and Private key, which are used to sign programmatic requests users make to Google cloud services accessible to that particular service account. It is recommended that all Service Account keys are regularly rotated."
  query         = query.iam_service_account_key_age_90.sql
  documentation = file("./cis_v130/docs/cis_v130_1_7.md")

  tags = merge(local.cis_v130_1_common_tags, {
    cis_item_id = "1.7"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/IAM"
  })
}

control "cis_v130_1_8" {
  title         = "1.8 Ensure that Separation of duties is enforced while assigning service account related roles to users"
  description   = "It is recommended that the principle of 'Separation of Duties' is enforced while assigning service-account related roles to users."
  query         = query.iam_user_separation_of_duty_enforced.sql
  documentation = file("./cis_v130/docs/cis_v130_1_8.md")

  tags = merge(local.cis_v130_1_common_tags, {
    cis_item_id = "1.8"
    cis_level   = "2"
    cis_type    = "manual"
    service     = "GCP/IAM"
  })
}

control "cis_v130_1_9" {
  title         = "1.9 Ensure that Cloud KMS cryptokeys are not anonymously or publicly accessible"
  description   = "It is recommended that the IAM policy on Cloud KMS cryptokeys should restrict anonymous and/or public access."
  query         = query.kms_key_not_publicly_accessible.sql
  documentation = file("./cis_v130/docs/cis_v130_1_9.md")

  tags = merge(local.cis_v130_1_common_tags, {
    cis_item_id = "1.9"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/KMS"
  })
}

control "cis_v130_1_10" {
  title         = "1.10 Ensure KMS encryption keys are rotated within a period of 90 days"
  description   = "Google Cloud Key Management Service stores cryptographic keys in a hierarchical structure designed for useful and elegant access control management. The format for the rotation schedule depends on the client library that is used. For the gcloud command-line tool, the next rotation time must be in ISO or RFC3339 format, and the rotation period must be in the form INTEGER[UNIT], where units can be one of seconds (s), minutes (m), hours (h) or days (d)."
  query         = query.kms_key_rotated_within_90_day.sql
  documentation = file("./cis_v130/docs/cis_v130_1_10.md")

  tags = merge(local.cis_v130_1_common_tags, {
    cis_item_id = "1.10"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/KMS"
  })
}

control "cis_v130_1_11" {
  title         = "1.11 Ensure that Separation of duties is enforced while assigning KMS related roles to users"
  description   = "It is recommended that the principle of 'Separation of Duties' is enforced while assigning KMS related roles to users."
  query         = query.kms_key_separation_of_duties_enforced.sql
  documentation = file("./cis_v130/docs/cis_v130_1_11.md")

  tags = merge(local.cis_v130_1_common_tags, {
    cis_item_id = "1.11"
    cis_level   = "2"
    cis_type    = "automated"
    service     = "GCP/KMS"
  })
}

control "cis_v130_1_12" {
  title         = "1.12 Ensure API keys are not created for a project"
  description   = "Keys are insecure because they can be viewed publicly, such as from within a browser, or they can be accessed on a device where the key resides. It is recommended to use standard authentication flow instead."
  query         = query.manual_control.sql
  documentation = file("./cis_v130/docs/cis_v130_1_12.md")

  tags = merge(local.cis_v130_1_common_tags, {
    cis_item_id = "1.12"
    cis_level   = "2"
    cis_type    = "manual"
    service     = "GCP/IAM"
  })
}

control "cis_v130_1_13" {
  title         = "1.13 Ensure API keys are restricted to use by only specified Hosts and Apps"
  description   = "Unrestricted keys are insecure because they can be viewed publicly, such as from within a browser, or they can be accessed on a device where the key resides. It is recommended to restrict API key usage to trusted hosts, HTTP referrers and apps."
  query         = query.manual_control.sql
  documentation = file("./cis_v130/docs/cis_v130_1_13.md")

  tags = merge(local.cis_v130_1_common_tags, {
    cis_item_id = "1.13"
    cis_level   = "1"
    cis_type    = "manual"
    service     = "GCP/IAM"
  })
}

control "cis_v130_1_14" {
  title         = "1.14 Ensure API keys are restricted to only APIs that application needs access"
  description   = "API keys are insecure because they can be viewed publicly, such as from within a browser, or they can be accessed on a device where the key resides. It is recommended to restrict API keys to use (call) only APIs required by an application."
  query         = query.manual_control.sql
  documentation = file("./cis_v130/docs/cis_v130_1_14.md")

  tags = merge(local.cis_v130_1_common_tags, {
    cis_item_id = "1.14"
    cis_level   = "1"
    cis_type    = "manual"
    service     = "GCP/IAM"
  })
}

control "cis_v130_1_15" {
  title         = "1.15 Ensure API keys are rotated every 90 days"
  description   = "It is recommended to rotate API keys every 90 days."
  query         = query.manual_control.sql
  documentation = file("./cis_v130/docs/cis_v130_1_15.md")

  tags = merge(local.cis_v130_1_common_tags, {
    cis_item_id = "1.15"
    cis_level   = "1"
    cis_type    = "manual"
    service     = "GCP/IAM"
  })
}

control "cis_v130_1_16" {
  title         = "1.16 Ensure essential contacts is configured for Organization"
  description   = "It is recommended that Essential Contacts is configured to designate email addresses for Google Cloud services to notify of important technical or security information."
  query         = query.organization_essential_contacts_configured.sql
  documentation = file("./cis_v130/docs/cis_v130_1_16.md")

  tags = merge(local.cis_v130_1_common_tags, {
    cis_item_id = "1.16"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/Organization"
  })
}

control "cis_v130_1_17" {
  title         = "1.17 Ensure that dataproc cluster is encrypted using customer-managed encryption key"
  description   = "When you use Dataproc, cluster and job data is stored on Persistent Disks (PDs) associated with the Compute Engine VMs in your cluster and in a Cloud Storage staging bucket. This PD and bucket data is encrypted using a Google-generated data encryption key (DEK) and key encryption key (KEK). The CMEK feature allows you to create, use, and revoke the key encryption key (KEK). Google still controls the data encryption key (DEK)."
  query         = query.dataproc_cluster_encryption_with_cmek.sql
  documentation = file("./cis_v130/docs/cis_v130_1_17.md")

  tags = merge(local.cis_v130_1_common_tags, {
    cis_item_id = "1.17"
    cis_level   = "2"
    cis_type    = "automated"
    service     = "GCP/Dataproc"
  })
}

control "cis_v130_1_18" {
  title         = "1.18 Ensure Secrets are Not Stored in Cloud Functions Environment Variables by Using Secret Manager"
  description   = "Google Cloud Functions allow you to host serverless code that is executed when an event is triggered, without the requiring the management a host operating system. These functions can also store environment variables to be used by the code that may contain authentication or other information that needs to remain confidential."
  query         = query.manual_control.sql
  documentation = file("./cis_v130/docs/cis_v130_1_18.md")

  tags = merge(local.cis_v130_1_common_tags, {
    cis_item_id = "1.18"
    cis_level   = "1"
    cis_type    = "manual"
    service     = "GCP/Dataproc"
  })
}
