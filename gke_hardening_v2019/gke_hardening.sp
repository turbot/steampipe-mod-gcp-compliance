locals {
  gke_hardening_common_tags = {
    gke_hardening_v2019  = "true"
    plugin               = "gcp"
  }
}

benchmark "gke_hardening_v2019" {
  title         = "GKE Hardening v2019"
  documentation = file("./gke_hardening_v2019/docs/gke_hardening_overview.md")
  tags          = local.gke_hardening_common_tags
  children = [
    control.disable_gke_dashboard,
    control.disable_gke_legacy_abac,
    control.enable_auto_upgrade,
    control.enable_gke_master_authorized_networks
  ]
}