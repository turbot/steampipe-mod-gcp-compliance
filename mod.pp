mod "gcp_compliance" {
  # Hub metadata
  title         = "GCP Compliance"
  description   = "Run individual configuration, compliance and security controls or full compliance benchmarks for CIS, Forseti Security and CFT Scorecard across all your GCP projects using Powerpipe and Steampipe."
  color         = "#ea4335"
  documentation = file("./docs/index.md")
  icon          = "/images/mods/turbot/gcp-compliance.svg"
  categories    = ["cis", "compliance", "gcp", "public cloud", "security"]
  database      = var.database

  opengraph {
    title       = "Powerpipe Mod for GCP Compliance"
    description = "Run individual configuration, compliance and security controls or full compliance benchmarks for CIS, Forseti Security and CFT Scorecard across all your GCP projects using Powerpipe and Steampipe."
    image       = "/images/mods/turbot/gcp-compliance-social-graphic.png"
  }

  require {
    plugin "gcp" {
      min_version = "0.49.0"
    }
  }
}