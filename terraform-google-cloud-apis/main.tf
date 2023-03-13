resource "google_project_service" "gcp_apis" {
  #for_each                   = toset(var.gcp_apis_list)
  for_each = {
    "${var.gcp_apis_list}" = "${var.project_id}"
  }
  project                    = each.value
  service                    = each.key
  disable_on_destroy         = var.disable_apis_on_destroy
  disable_dependent_services = var.disable_dependent_apis
}
