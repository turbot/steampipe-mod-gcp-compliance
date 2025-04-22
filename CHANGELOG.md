## v1.0.3 [2025-04-22]

_Bug fixes_

- Fixed control titles to correctly use `0.0.0.0/0` instead of `0.0.00/0`. ([#191](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/191)) (Thanks [@akumar-99](https://github.com/akumar-99) for the contribution!)
- Fixed a syntax issue by adding a missing semicolon at the end of the `logging_metric_alert_network_changes` query. ([#190](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/190)) (Thanks [@tolgaOzen](https://github.com/tolgaOzen) for the contribution!)

## v1.0.2 [2025-04-14]

_Bug fixes_

- Added the missing `GCP/IAM` and `GCP/SQL` service tags to relevant controls. ([#188](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/188))

## v1.0.1 [2024-10-24]

_Bug fixes_

- Renamed `steampipe.spvars.example` files to `powerpipe.ppvars.example` and updated documentation. ([#186](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/186))

## v1.0.0 [2024-10-22]

This mod now requires [Powerpipe](https://powerpipe.io). [Steampipe](https://steampipe.io) users should check the [migration guide](https://powerpipe.io/blog/migrating-from-steampipe).

## v0.34 [2024-08-23]

_What's new?_

- Added SOC2 2017 benchmark (`powerpipe benchmark run gcp_compliance.benchmark.soc_2_2017`). ([#181](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/181))

## v0.33 [2024-08-02]

_Enhancements_

- Added the following controls to the `All Controls` benchmark: ([#176](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/176))
  - `alloydb_instance_log_error_verbosity_database_flag_default_or_stricter`
  - `alloydb_instance_log_min_error_statement_database_flag_configured`
  - `alloydb_instance_log_min_messages_database_flag_error`

## v0.32 [2024-06-07]

_What's new?_

- Added NIST Cybersecurity Framework (CSF) v1.0 benchmark (`powerpipe benchmark run gcp_compliance.benchmark.nist_csf_v10`). ([#168](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/168))
- Added NIST 800-53 Revision 5 benchmark (`powerpipe benchmark run gcp_compliance.benchmark.nist_800_53_rev_5`). ([#168](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/168))

_Bug fixes_

- Fixed the `kms_key_users_limited_to_3` query to correctly return data by removing the hardcoded GCP connection name. ([#170](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/170))
- Fixed the `logging_bucket_retention_policy_enabled` query to correctly return data by adding the missing `project` column to the query. ([#173](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/173))

## v0.31 [2024-05-31]

_What's new?_

- Added HIPAA benchmark (`powerpipe benchmark run gcp_compliance.benchmark.hipaa`). ([#165](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/165))
- Added PCI DSS v3.2.1 benchmark (`powerpipe benchmark run gcp_compliance.benchmark.pci_dss_v321`). ([#163](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/163))

_Enhancements_

- Optimized several queries to minimize API usage, achieving faster performance. ([#162](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/162))

## v0.30 [2024-04-16]

_What's new?_

- Added CIS v3.0.0 benchmark (`powerpipe benchmark run gcp_compliance.benchmark.cis_v300`). ([#158](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/158))

## v0.29 [2024-03-20]

_Bug fixes_

- Fixed the CIS controls from `cis_v200_2_4` to `cis_v200_2_11` to correctly evaluate results when using the aggregator connection of the GCP plugin. ([#154](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/154))

## v0.28 [2024-03-06]

_Powerpipe_

[Powerpipe](https://powerpipe.io) is now the preferred way to run this mod!  [Migrating from Steampipe →](https://powerpipe.io/blog/migrating-from-steampipe)

All v0.x versions of this mod will work in both Steampipe and Powerpipe, but v1.0.0 onwards will be in Powerpipe format only.

_Enhancements_

- Focus documentation on Powerpipe commands.
- Show how to combine Powerpipe mods with Steampipe plugins.

## v0.27 [2024-02-26]

_Bug fixes_

- Fixed the hierarchy in the benchmark list by properly integrating `Cloud Functions` benchmark into `all_controls` benchmark. ([#146](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/146))

## v0.26 [2024-02-22]

_Dependencies_

- GCP plugin `v0.49.0` or higher is now required. ([#143](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/143))

_Enhancements_

- Added 5 new controls to the `All Controls` benchmark across the following services: ([#143](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/143))
  - `App Engine`
  - `Cloud Run`
  - `Kubernetes`

## v0.25 [2024-01-04]

_Enhancements_

- Added 61 new controls to the `All Controls` benchmark across the following services: ([#140](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/140))
  - `CloudFunctions`
  - `Compute`
  - `KMS`
  - `Kubernetes`
  - `Project`
  - `SQL`
  - `Storage`

## v0.24 [2023-11-14]

_Bug fixes_

- Fixed the `compute_firewall_allow_tcp_connections_proxied_by_iap` query to correctly include all the ports and source IP ranges. ([#128](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/128)) (Thanks [@saisirishreddy](https://github.com/saisirishreddy) for the contribution!)

## v0.23 [2023-11-09]

_What's new?_

- Added the new `All Controls` benchmark (steampipe check benchmark.all_controls). This new benchmark includes 109 service-specific controls. ([#127](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/127))

## v0.22 [2023-11-03]

_Breaking changes_

- Updated the plugin dependency section of the mod to use `min_version` instead of `version`. ([#130](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/130))

_Bug fixes_

- Fixed the `kms_key_separation_of_duties_enforced` query to ensure that separation of duties is enforced while assigning KMS-related roles to users. ([#132](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/132))

## v0.21 [2023-08-02]

_Bug fixes_

- Fixed `kms_key_rotated_within_90_day` and `kms_key_rotated_within_100_day` queries to skip KMS keys that are either in `DESTROYED` or `DESTROY_SCHEDULED` or `DISABLED` state since we cannot schedule rotation for such keys. ([#124](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/124))

## v0.20 [2023-07-28]

_Bug fixes_

- Added the missing `iam_api_key_restricts_apis` query for `cis_v120_1_14`, `cis_v130_1_14`, and `cis_v200_1_14` controls. ([#115](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/115)) (Thanks [@saisirishreddy](https://github.com/saisirishreddy) for the contribution!)
- Added the missing `iam_api_key_restricts_websites_hosts_apps` query for `cis_v120_1_13`, `cis_v130_1_13`, and `cis_v200_1_13` controls. ([#115](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/115)) (Thanks [@saisirishreddy](https://github.com/saisirishreddy) for the contribution!)
- Fixed the `kubernetes_cluster_network_policy_installed` query to correctly check if the GKE clusters have a network policy installed. ([#116](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/116)) (Thanks [@saisirishreddy](https://github.com/saisirishreddy) for the contribution!)

## v0.19 [2023-07-21]

_Bug fixes_

- Fixed the `logging_metric_alert_storage_iam_permission_changes` query to correctly check if sinks have been configured for all the log entries across all the projects instead of only the last project in an aggregator connection. ([#111](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/111)) (Thanks [@M0nsieurChat](https://github.com/M0nsieurChat) for the contribution!)

## v0.18 [2023-07-19]

_Bug fixes_

- Added the missing `iam_api_key_age_90` query for `cis_v120_1_15`, `cis_v130_1_15`, and `cis_v200_1_14` controls. ([#107](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/107)) (Thanks [@saisirishreddy](https://github.com/saisirishreddy) for the contribution!)

## v0.17 [2023-07-13]

_Bug fixes_

- Fixed the `iam_user_uses_corporate_login_credentials` query to return `info` status, when plugin authentication mechanism does not include organization viewer permission, instead of false positives. ([#97](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/97))
- Fixed dashboard localhost URLs in README and index doc. ([#104](https://github.com/turbot/steampipe-mod-aws-thrifty/pull/104))

## v0.16 [2023-05-15]

_Bug fixes_

- Fixed `cis_v130_3_10` and `cis_v200_3_10` controls to also include IP `35.235.240.0/20` and port `443` in the list of allowed IPs and ports per CIS documentation. ([#101](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/101))

## v0.15 [2023-04-21]

_Bug fixes_

- Fixed the following queries to use the `project_id` column instead of the `name` column (project name) as the `project` common dimension: ([#96](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/96))
  - `logging_metric_alert_audit_configuration_changes`
  - `logging_metric_alert_custom_role_changes`
  - `logging_metric_alert_firewall_rule_changes`
  - `logging_metric_alert_network_changes`
  - `logging_metric_alert_network_route_changes`
  - `logging_metric_alert_project_ownership_assignment`
  - `logging_metric_alert_sql_instance_configuration_changes`
  - `logging_metric_alert_storage_iam_permission_changes`
  - `logging_sink_configured_for_all_resource`
  - `manual_control`
  - `project_access_approval_settings_enabled`

## v0.14 [2023-03-24]

_What's new?_

- Added `tags` as dimensions to group and filter findings. (see [var.tag_dimensions](https://hub.steampipe.io/mods/turbot/gcp_compliance/variables)) ([#91](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/91))
- Added `connection_name` in the common dimensions to group and filter findings. (see [var.common_dimensions](https://hub.steampipe.io/mods/turbot/gcp_compliance/variables)) ([#91](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/91))

## v0.13 [2023-01-20]

_What's new?_

- Added CIS v2.0.0 benchmark (`steampipe check benchmark.cis_v200`). ([#87](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/87))

## v0.12 [2022-11-03]

_Bug fixes_

- Fixed the `kms_key_separation_of_duties_enforced` query to correctly check if the principle of 'Separation of Duties' is enforced while assigning KMS related roles to users. ([#80](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/80))

## v0.11 [2022-08-18]

_What's new?_

- Added CIS v1.3.0 benchmark (`steampipe check benchmark.cis_v130`). ([#76](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/76))

## v0.10 [2022-05-09]

_Enhancements_

- Updated docs/index.md and README with new dashboard screenshots and latest format. ([#68](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/68))

## v0.9 [2022-05-02]

_Enhancements_

- Added `category`, `service`, and `type` tags to benchmarks and controls. ([#64](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/64))

## v0.8 [2022-03-17]

_Bug fixes_

- Fixed the `kubernetes_cluster_private_cluster_config_enabled` query to correctly evaluate which GKE clusters are private ([#59](https://github.com/turbot/steampipe-mod-gcp-compliance/pull/59))

## v0.7 [2021-11-10]

_Enhancements_

- `docs/index.md` file now includes the console output image

## v0.6 [2021-10-06]

_What's new?_

- Added: CFT Scorecard v1 benchmark (`steampipe check benchmark.cft_scorecard_v1`)
- Added: Forseti Security v2.26.0 benchmark (`steampipe check benchmark.forseti_security_v226`)

## v0.5 [2021-09-23]

_Bug fixes_

- Fixed broken links to the Mod developer guide in README.md
- Removed the unnecessary quotes from `iam_user_separation_of_duty_enforced` query

## v0.4 [2021-07-01]

_What's new?_

- New CIS v1.2.0 controls added:
  - 1.1

## v0.3 [2021-06-03]

_What's new?_

- New CIS v1.2.0 controls added
  - 1.9
  - 1.10
  - 1.11

## v0.2 [2021-05-28]

_Bug fixes_

- Minor fixes in the docs
