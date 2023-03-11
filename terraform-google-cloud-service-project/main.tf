resource "google_compute_shared_vpc_service_project" "shared_vpc" {
  provider        = google-beta
  count           = var.enable_shared_vpc_service_project ? 1 : 0
  host_project    = var.host_project
  service_project = var.service_project
}
