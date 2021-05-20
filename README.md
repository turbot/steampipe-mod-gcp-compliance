![image](https://hub.steampipe.io/images/mods/turbot/gcp-compliance-social-graphic.png)

# GCP Compliance Mod for Steampipe

Run individual configuration, compliance and security controls 
or full compliance benchmarks for CIS and PCI across all your AWS accounts. 

Can you write SQL and HCL? [Fork this repo](#developing) as the basis for your own custom compliance checks!

* **[Get started →](https://hub.steampipe.io/mods/turbot/gcp-compliance)**
* Documentation: [Controls](https://hub.steampipe.io/mods/turbot/gcp-compliance/controls)
* Community: [Slack Channel](https://join.slack.com/t/steampipe/shared_invite/zt-oij778tv-lYyRTWOTMQYBVAbtPSWs3g)
* Get involved: [Issues](https://github.com/turbot/steampipe-mod-gcp-compliance/issues)

## Quick start

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

Run a benchmark:
```shell
steampipe check benchmark.cis_v120
```

Run a specific control:
```shell
steampipe check control.cis_v120_2_2
```

## Developing

Have an idea but aren't sure how to get started? 
**[Join our Slack community →](https://join.slack.com/t/steampipe/shared_invite/zt-oij778tv-lYyRTWOTMQYBVAbtPSWs3g)**
**[Mod developer guide →](https://steampipe.io/docs/steampipe-mods/writing-mods.md)**

Prerequisites:
- [Steampipe installed](https://steampipe.io/downloads)
- Steampipe GCP plugin installed (see above)

**Fork**:
Click on the GitHub Fork Widget. (Don't forget to :star: the repo!)

**Clone**:

1. Change the current working directory to the location where you want to put the cloned directory on your local filesystem.
2. Type the clone command below inserting your GitHub username instead of `YOUR-USERNAME`:

```sh
git clone git@github.com:YOUR-USERNAME/steampipe-mod-gcp-compliance
cd steampipe-mod-gcp-compliance
```

**View controls and benchmarks**:
```
steampipe query "select resource_name from steampipe_control;"
```

```sql
steampipe query
> select 
    resource_name 
  from 
    steampipe_benchmark 
  order by 
    resource_name;
```

## Contributing

Thanks for getting involved! We would love to have you [join our Slack community](https://join.slack.com/t/steampipe/shared_invite/zt-oij778tv-lYyRTWOTMQYBVAbtPSWs3g) and hang out with other Mod developers.

Please see the [contribution guidelines](https://github.com/turbot/steampipe/blob/main/CONTRIBUTING.md) and our [code of conduct](https://github.com/turbot/steampipe/blob/main/CODE_OF_CONDUCT.md). All contributions are subject to the [MPL-2.0 open source license](https://github.com/turbot/steampipe-mod-gcp-compliance/blob/main/LICENSE).

`help wanted` issues:
- [Steampipe](https://github.com/turbot/steampipe/labels/help%20wanted)
- [GCP Compliance Mod](https://github.com/turbot/steampipe-mod-gcp-compliance/labels/help%20wanted)
