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
