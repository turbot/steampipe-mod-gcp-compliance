mod "gcp_compliance" {
  # hub metadata
  title          = "GCP Compliance"
  description    = "Steampipe Mod for Google Cloud Platform (GCP) Compliance"
  color          = "#ea4335"
  documentation  = file("./docs/index.md")
  icon           = "/images/mods/turbot/gcp-compliance.svg"
  categories     = ["CIS", "Compliance", "GCP", "Public Cloud", "Security"]

  opengraph {
    title         = "Steampipe Mod for GCP Compliance"
    description   = "Compliance and audit reports, queries, and actions for GCP. Open source CLI. No DB required."
  }

  /*
  # dependencies
  requires {
    steampipe ">0.3.0"
    plugin "gcp"
  }
  */
}
