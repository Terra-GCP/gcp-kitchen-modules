resource "google_project_service" "gcp_apis" {
  for_each                   = toset(var.gcp_apis_list)
  count                      = length(var.project_id)
  project                    = var.project_id[count.index]
  service                    = each.key
  disable_on_destroy         = var.disable_apis_on_destroy
  disable_dependent_services = var.disable_dependent_apis
}
