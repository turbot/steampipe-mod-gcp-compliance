# GCP Compliance Mod for Steampipe

80+ checks covering industry defined security best practices for Google Cloud services.

**Includes full support for v1.2.0 CIS, v1.3.0 CIS, CFT Scorecard and Forseti Security benchmarks**.

Run checks in a dashboard:
![image](https://raw.githubusercontent.com/turbot/steampipe-mod-gcp-compliance/main/docs/gcp_compliance_cis_v120_dashboard.png)

Or in a terminal:
![image](https://raw.githubusercontent.com/turbot/steampipe-mod-gcp-compliance/main/docs/gcp_cis_v120_console.png)

Includes support for:
1. [Identity and Access Management](https://hub.steampipe.io/mods/turbot/gcp_compliance/controls/benchmark.cis_v130_1)
2. [Logging and Monitoring](https://hub.steampipe.io/mods/turbot/gcp_compliance/controls/benchmark.cis_v130_2)
3. [Networking](https://hub.steampipe.io/mods/turbot/gcp_compliance/controls/benchmark.cis_v130_3)
4. [Virtual Machines](https://hub.steampipe.io/mods/turbot/gcp_compliance/controls/benchmark.cis_v130_4)
5. [Storage](https://hub.steampipe.io/mods/turbot/gcp_compliance/controls/benchmark.cis_v130_5)
6. [Cloud SQL Database Services](https://hub.steampipe.io/mods/turbot/gcp_compliance/controls/benchmark.cis_v130_6)
7. [BigQuery](https://hub.steampipe.io/mods/turbot/gcp_compliance/controls/benchmark.cis_v130_7)

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

## Contributing

If you have an idea for additional compliance controls, or just want to help maintain and extend this mod ([or others](https://github.com/topics/steampipe-mod)) we would love you to join the community and start contributing. (Even if you just want to help with the docs.)

- **[Join our Slack community →](https://steampipe.io/community/join)** and hang out with other Mod developers.

Please see the [contribution guidelines](https://github.com/turbot/steampipe/blob/main/CONTRIBUTING.md) and our [code of conduct](https://github.com/turbot/steampipe/blob/main/CODE_OF_CONDUCT.md). All contributions are subject to the [Apache 2.0 open source license](https://github.com/turbot/steampipe-mod-gcp-compliance/blob/main/LICENSE).

Want to help but not sure where to start? Pick up one of the `help wanted` issues:

- [Steampipe](https://github.com/turbot/steampipe/labels/help%20wanted)
- [GCP Compliance Mod](https://github.com/turbot/steampipe-mod-gcp-compliance/labels/help%20wanted)
