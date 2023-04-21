// Benchmarks and controls for specific services should override the "service" tag
locals {
  gcp_compliance_common_tags = {
    category = "Compliance"
    plugin   = "gcp"
    service  = "GCP"
  }
}

variable "common_dimensions" {
  type        = list(string)
  description = "A list of common dimensions to add to each control."
  # Define which common dimensions should be added to each control.
  # - connection_name (_ctx ->> 'connection_name')
  # - location
  # - project
  default = ["location", "project"]
}

variable "tag_dimensions" {
  type        = list(string)
  description = "A list of tags to add as dimensions to each control."
  # A list of tag names to include as dimensions for resources that support
  # tags (e.g. "owner", "environment"). Default to empty since tag names are
  # a personal choice
  default = []
}

locals {
  # Local internal variable to build the SQL select clause for common
  # dimensions using a table name qualifier if required. Do not edit directly.
  common_dimensions_qualifier_sql = <<-EOQ
  %{~if contains(var.common_dimensions, "connection_name")}, __QUALIFIER___ctx ->> 'connection_name' as connection_name%{endif~}
  %{~if contains(var.common_dimensions, "location")}, __QUALIFIER__location as location%{endif~}
  %{~if contains(var.common_dimensions, "project")}, __QUALIFIER__project as project%{endif~}
  EOQ

  common_dimensions_qualifier_global_sql = <<-EOQ
  %{~if contains(var.common_dimensions, "connection_name")}, __QUALIFIER___ctx ->> 'connection_name' as connection_name%{endif~}
  %{~if contains(var.common_dimensions, "project")}, __QUALIFIER__project as project%{endif~}
  EOQ

  common_dimensions_qualifier_project_sql = <<-EOQ
  %{~if contains(var.common_dimensions, "connection_name")}, __QUALIFIER___ctx ->> 'connection_name' as connection_name%{endif~}
  %{~if contains(var.common_dimensions, "project")}, __QUALIFIER__project_id as project%{endif~}
  EOQ

  # Local internal variable to build the SQL select clause for tag
  # dimensions. Do not edit directly.
  tag_dimensions_qualifier_sql = <<-EOQ
  %{~for dim in var.tag_dimensions},  __QUALIFIER__tags ->> '${dim}' as "${replace(dim, "\"", "\"\"")}"%{endfor~}
  EOQ
}

locals {
  # Local internal variable with the full SQL select clause for common
  # and tag dimensions. Do not edit directly.
  common_dimensions_sql              = replace(local.common_dimensions_qualifier_sql, "__QUALIFIER__", "")
  common_dimensions_global_sql       = replace(local.common_dimensions_qualifier_global_sql, "__QUALIFIER__", "")
  common_dimensions_project_sql      = replace(local.common_dimensions_qualifier_project_sql, "__QUALIFIER__", "")
  tag_dimensions_sql                 = replace(local.tag_dimensions_qualifier_sql, "__QUALIFIER__", "")
}

mod "gcp_compliance" {
  # hub metadata
  title         = "GCP Compliance"
  description   = "Run individual configuration, compliance and security controls or full compliance benchmarks for CIS, Forseti Security and CFT Scorecard across all your GCP projects using Steampipe."
  color         = "#ea4335"
  documentation = file("./docs/index.md")
  icon          = "/images/mods/turbot/gcp-compliance.svg"
  categories    = ["cis", "compliance", "gcp", "public cloud", "security"]

  opengraph {
    title       = "Steampipe Mod for GCP Compliance"
    description = "Run individual configuration, compliance and security controls or full compliance benchmarks for CIS, Forseti Security and CFT Scorecard across all your GCP projects using Steampipe."
    image       = "/images/mods/turbot/gcp-compliance-social-graphic.png"
  }

  require {
    plugin "gcp" {
      version = "0.26.0"
    }
  }
}