# GCP Compliance Scanning Tool

80+ checks covering industry defined security best practices for Google Cloud services. 

**Includes full support for v1.2.0 CIS benchmarks**:

![image](https://raw.githubusercontent.com/turbot/steampipe-mod-gcp-compliance/main/docs/gcp_cis_v140_console.png)

Includes support for:
1. [Identity and Access Management](https://hub.steampipe.io/mods/turbot/gcp_compliance/controls/benchmark.cis_v120_1)
2. [Logging and Monitoring](https://hub.steampipe.io/mods/turbot/gcp_compliance/controls/benchmark.cis_v120_2)
3. [Networking](https://hub.steampipe.io/mods/turbot/gcp_compliance/controls/benchmark.cis_v120_3)
4. [Virtual Machines](https://hub.steampipe.io/mods/turbot/gcp_compliance/controls/benchmark.cis_v120_4)
5. [Storage](https://hub.steampipe.io/mods/turbot/gcp_compliance/controls/benchmark.cis_v120_5)
6. [Cloud SQL Database Services](https://hub.steampipe.io/mods/turbot/gcp_compliance/controls/benchmark.cis_v120_6)
7. [BigQuery](https://hub.steampipe.io/mods/turbot/gcp_compliance/controls/benchmark.cis_v120_7)


## Quick start

1) Download and install Steampipe (https://steampipe.io/downloads). e.g. If you are on an Intel Mac use Brew:

```shell
brew tap turbot/tap
brew install steampipe

steampipe -v 
steampipe version 0.5.1
```

2) Install the GCP plugin with [Steampipe](https://steampipe.io):
```shell
steampipe plugin install gcp
```

3) Clone this repo:
```sh
git clone git@github.com:turbot/steampipe-mod-gcp-compliance
cd steampipe-mod-gcp-compliance
```

4) Run all benchmarks:
```sh
steampipe check all
```

### Other things to checkout

Run a benchmark:
```sh
steampipe check benchmark.cis_v120_1
```

Query a list of the controls:
```sh
steampipe query "select resource_name from steampipe_control;"
```

Run a specific control:
```sh
steampipe check control.cis_v120_2_2
```

## Contributing

If you have an idea for additional compliance controls, or just want to help maintain and extend this mod ([or others](https://github.com/topics/steampipe-mod)) we would love you to join the community and start contributing. (Even if you just want to help with the docs.)

- **[Join our Slack community →](https://join.slack.com/t/steampipe/shared_invite/zt-oij778tv-lYyRTWOTMQYBVAbtPSWs3g)** and hang out with other Mod developers.
- **[Mod developer guide →](https://steampipe.io/docs/using-steampipe/writing-controls)**

Please see the [contribution guidelines](https://github.com/turbot/steampipe/blob/main/CONTRIBUTING.md) and our [code of conduct](https://github.com/turbot/steampipe/blob/main/CODE_OF_CONDUCT.md). All contributions are subject to the [Apache 2.0 open source license](https://github.com/turbot/steampipe-mod-aws-compliance/blob/main/LICENSE).

`help wanted` issues:
- [Steampipe](https://github.com/turbot/steampipe/labels/help%20wanted)
- [GCP Compliance Mod](https://github.com/turbot/steampipe-mod-gcp-compliance/labels/help%20wanted)
