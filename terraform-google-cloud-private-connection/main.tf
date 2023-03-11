resource "google_service_networking_connection" "default" {
  network                 = var.network
  service                 = var.service 
  reserved_peering_ranges = var.ranges
}
