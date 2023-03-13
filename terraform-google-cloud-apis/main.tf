resource "google_project_service" "gcp_apis" {
  for_each                   = toset(var.gcp_apis_list)
  project                    = [for p in var.project_id: p]
  service                    = each.key
  disable_on_destroy         = var.disable_apis_on_destroy
  disable_dependent_services = var.disable_dependent_apis
}
