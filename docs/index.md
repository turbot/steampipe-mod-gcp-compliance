---
repository: "https://github.com/turbot/steampipe-mod-gcp-compliance"
---

# GCP Compliance Mod

Run individual configuration, compliance and security controls or full compliance benchmarks for `CIS v1.2.0`, `CIS v1.3.0`, `Forseti Security` and `CFT Scorecard` for all your GCP projects.

<img src="https://raw.githubusercontent.com/turbot/steampipe-mod-gcp-compliance/main/docs/gcp_compliance_dashboard.png" width="50%" type="thumbnail"/>
<img src="https://raw.githubusercontent.com/turbot/steampipe-mod-gcp-compliance/main/docs/gcp_compliance_cis_v120_dashboard.png" width="50%" type="thumbnail"/>
<img src="https://raw.githubusercontent.com/turbot/steampipe-mod-gcp-compliance/main/docs/gcp_cis_v120_console.png" width="50%" type="thumbnail"/>

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

## Getting started

### Installation

Download and install Steampipe (https://steampipe.io/downloads). Or use Brew:

```sh
brew tap turbot/tap
brew install steampipe
```

Install the GCP plugin with [Steampipe](https://steampipe.io):

```sh
steampipe plugin install gcp
```

Clone:

```sh
git clone https://github.com/turbot/steampipe-mod-gcp-compliance.git
cd steampipe-mod-gcp-compliance
```

### Usage

Start your dashboard server to get started:

```sh
steampipe dashboard
```

By default, the dashboard interface will then be launched in a new browser
window at https://localhost:9194. From here, you can run benchmarks by
selecting one or searching for a specific one.

Instead of running benchmarks in a dashboard, you can also run them within your
terminal with the `steampipe check` command:

Run all benchmarks:

```sh
steampipe check all
```

Run a single benchmark:

```sh
steampipe check benchmark.cis_v130
```

Run a specific control:

```sh
steampipe check control.cis_v130_2_1
```

Different output formats are also available, for more information please see
[Output Formats](https://steampipe.io/docs/reference/cli/check#output-formats).

### Credentials

This mod uses the credentials configured in the [Steampipe GCP plugin](https://hub.steampipe.io/plugins/turbot/gcp).

### Configuration

No extra configuration is required.

### Common and Tag Dimensions

The benchmark queries use common properties (like `connection_name`, `location` and `project`) and tags that are defined in the form of a default list of strings in the `mod.sp` file. These properties can be overwritten in several ways:

- Copy and rename the `steampipe.spvars.example` file to `steampipe.spvars`, and then modify the variable values inside that file
- Pass in a value on the command line:

  ```shell
  steampipe check benchmark.cis_v200 --var 'common_dimensions=["connection_name", "location", "project"]'
  ```

  ```shell
  steampipe check benchmark.cis_v200 --var 'tag_dimensions=["environment", "owner"]'
  ```

- Set an environment variable:

  ```shell
  SP_VAR_common_dimensions='["connection_name", "location", "project"]' steampipe check control.cis_v120_6_2_4
  ```

  ```shell
  SP_VAR_tag_dimensions='["environment", "owner"]' steampipe check control.cis_v120_6_2_4
  ```

## Contributing

If you have an idea for additional controls or just want to help maintain and extend this mod ([or others](https://github.com/topics/steampipe-mod)) we would love you to join the community and start contributing.

- **[Join our Slack community →](https://steampipe.io/community/join)** and hang out with other Mod developers.

Please see the [contribution guidelines](https://github.com/turbot/steampipe/blob/main/CONTRIBUTING.md) and our [code of conduct](https://github.com/turbot/steampipe/blob/main/CODE_OF_CONDUCT.md). All contributions are subject to the [Apache 2.0 open source license](https://github.com/turbot/steampipe-mod-gcp-compliance/blob/main/LICENSE).

Want to help but not sure where to start? Pick up one of the `help wanted` issues:

- [Steampipe](https://github.com/turbot/steampipe/labels/help%20wanted)
- [GCP Compliance Mod](https://github.com/turbot/steampipe-mod-gcp-compliance/labels/help%20wanted)
