---
repository: "https://github.com/turbot/steampipe-mod-gcp-compliance"
---

# GCP Compliance Mod

Run individual configuration, compliance and security controls or full compliance benchmarks for `CIS` for all your GCP projects. 

## References
[GCP](https://cloud.google.com) provides on-demand cloud computing platforms and APIs to authenticated customers on a metered pay-as-you-go basis.

[CIS GCP Benchmarks](https://www.cisecurity.org/benchmark/google_cloud_computing_platform/) provide a predefined set of compliance and security best-practice checks for GCP projects.

[Steampipe](https://steampipe.io) is an open source CLI to instantly query cloud APIs using SQL.

[Steampipe Mods](https://steampipe.io/docs/reference/mod-resources#mod) are collections of `named queries`, and codified `controls` that can be used to test current configuration of your cloud resources against a desired configuration.

## Documentation

- **[Benchmarks and controls →](https://hub.steampipe.io/mods/turbot/gcp_compliance/controls)**
- **[Named queries →](https://hub.steampipe.io/mods/turbot/gcp_compliance/queries)**

## Get started

Install the GCP plugin with [Steampipe](https://steampipe.io):
```shell
steampipe plugin install gcp
```

Clone:
```sh
git clone git@github.com:turbot/steampipe-mod-gcp-compliance
cd steampipe-mod-gcp-compliance
```

Run all benchmarks:
```shell
steampipe check all
```

Run a single benchmark:
```shell
steampipe check benchmark.cis_v120
```

Run a specific control:
```shell
steampipe check control.cis_v120_2_1
```

### Credentials

This mod uses the credentials configured in the [Steampipe GCP plugin](https://hub.steampipe.io/plugins/turbot/gcp).

### Configuration

No extra configuration is required.

## Get involved

* Contribute: [GitHub Repo](https://github.com/turbot/steampipe-mod-gcp-compliance)
* Community: [Slack Channel](https://join.slack.com/t/steampipe/shared_invite/zt-oij778tv-lYyRTWOTMQYBVAbtPSWs3g)
