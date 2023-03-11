resource "google_compute_router" "router" {
  count   = var.create_router ? 1 : 0
  name    = var.router_name
  project = var.project_id
  region  = var.region
  network = var.network
  bgp {
    asn                = var.router_asn
    keepalive_interval = var.router_keepalive_interval
  }
}
