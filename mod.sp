mod "gcp_compliance" {
  # hub metadata
  title         = "GCP Compliance"
  description   = "Run individual configuration, compliance and security controls or full compliance benchmarks for CIS, Forseti Security, CFT Scorecard, Healthcare Baseline and GKE Hardening across all your GCP projects using Steampipe."
  color         = "#ea4335"
  documentation = file("./docs/index.md")
  icon          = "/images/mods/turbot/gcp-compliance.svg"
  categories    = ["cis", "compliance", "gcp", "public cloud", "security"]

  opengraph {
    title        = "Steampipe Mod for GCP Compliance"
    description  = "Run individual configuration, compliance and security controls or full compliance benchmarks for CIS, Forseti Security, CFT Scorecard, Healthcare Baseline and GKE Hardening across all your GCP projects using Steampipe."
    image        = "/images/mods/turbot/gcp-compliance-social-graphic.png"
  }
}
