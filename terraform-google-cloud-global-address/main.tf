resource "google_compute_global_address" "default" {
  project       = var.project_id
  name          = var.name
  address_type  = var.address_type 
  purpose       = var.purpose
  prefix_length = var.prefix_length
  network       = var.network
  address       = var.address
}