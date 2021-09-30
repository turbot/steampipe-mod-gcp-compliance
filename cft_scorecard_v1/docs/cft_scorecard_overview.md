## Overview

The [CFT Scorecard](https://github.com/GoogleCloudPlatform/policy-library/blob/master/docs/bundles/forseti-security.md) is integrated into the [CFT CLI](https://github.com/GoogleCloudPlatform/cloud-foundation-toolkit/blob/master/cli/README.md) and provides
an easy integration with [Forseti Config Validator](https://github.com/forseti-security/policy-library/blob/master/docs/user_guide.md).
It can be used to print a scorecard of your GCP environment, for resources and IAM policies in Cloud Asset Inventory (CAI) exports.
The policies tested are based on constraints and constraint templates from the [Config Validator policy library](https://github.com/forseti-security/policy-library).