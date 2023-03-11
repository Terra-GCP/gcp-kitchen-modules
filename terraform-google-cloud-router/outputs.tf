output "router_details" {
  value       = google_compute_router.router
  description = "Cloud router details"
}

/* output "router_id" {
  value       = google_compute_router.router.*.id
  description = "Cloud router id"
}

output "router_name" {
  value       = google_compute_router.router.*.name
  description = "Cloud router name"
}

output "router_self_link" {
  value       = google_compute_router.router.*.self_link
  description = "Cloud router selflink"
}
 */