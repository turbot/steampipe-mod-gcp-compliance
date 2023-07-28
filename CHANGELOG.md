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
