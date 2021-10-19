# locals {
#   healthcare_baseline_common_tags = {
#     healthcare_baseline_v1  = "true"
#     plugin                  = "gcp"
#   }
# }

# benchmark "healthcare_baseline_v1" {
#   title         = "Healthcare Baseline v1"
#   description   = "Forseti Security Benchmark covers foundational security elements of Google Cloud Platform."
#   documentation = file("./healthcare_baseline_v1/docs/healthcare_baseline_overview.md")
#   tags          = local.forseti_security_common_tags
#   children = [
#     control.allow_appengine_applications_in_australia_and_south_america,	
#     control.allow_basic_set_of_apis,
#     control.allow_dataproc_clusters_in_asia,
#     control.allow_some_sql_location,
#     control.allow_some_storage_location,
#     control.allow_spanner_clusters_in_asia_and_europe,
#     control.audit_log_all,
#     control.bq_dataset_allowed_locations,
#     control.denylist_public_users,
#     control.enable_gke_stackdriver_logging,
#     control.enable_network_flow_logs,
#     control.enable_network_firewall_logs,
#     control.gke_cluster_allowed_locations,
#     control.only_my_domain,
#     control.prevent_public_ip_cloudsql,
#     control.require_bq_table_iam,
#     control.require_bucket_policy_only,
#     control.sql_world_readable
#   ]
# }