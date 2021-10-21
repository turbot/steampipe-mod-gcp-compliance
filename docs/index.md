---
repository: "https://github.com/turbot/steampipe-mod-gcp-compliance"
---

# GCP Compliance Mod

Run individual configuration, compliance and security controls or full compliance benchmarks for `CIS`, `Forseti Security` and `CFT Scorecard` for all your GCP projects.

![image](https://github.com/turbot/steampipe-mod-gcp-compliance/blob/main/docs/gcp_cis_v140_console.png)

## References
[GCP](https://cloud.google.com) provides on-demand cloud computing platforms and APIs to authenticated customers on a metered pay-as-you-go basis.

[CFT Scorecard](https://cloud.google.com/foundation-toolkit/) provides a set of security best-practice checks to detect misconfigurations and violations in Google Cloud resources and projects.

[CIS GCP Benchmarks](https://www.cisecurity.org/benchmark/google_cloud_computing_platform/) provide a predefined set of compliance and security best-practice checks for GCP projects.

[Forseti Security Benchmark](https://forsetisecurity.org/docs/latest/concepts/best-practices.html) provides a set of security best practice checks for GCP projects so that you can take action to secure resources and minimize security risks.

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
git clone https://github.com/turbot/steampipe-mod-gcp-compliance.git
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
