output "network_details" {
  value       = google_compute_network.vpc
  description = "The VPC resource being created"
}
output "shared_vpc_details" {
  value       = google_compute_shared_vpc_host_project.shared_vpc_host
  description = "The VPC resource being created"
}

/* output "network" {
  value       = google_compute_network.vpc
  description = "The VPC resource being created"
}
output "network_name" {
  value       = google_compute_network.vpc.name
  description = "The name of the VPC being created"
}
output "network_id" {
  value       = google_compute_network.vpc.id
  description = "The ID of the VPC being created"
}
output "network_self_link" {
  value       = google_compute_network.vpc.self_link
  description = "The URI of the VPC being created"
}
output "project_id" {
  value       = var.shared_vpc_host && length(google_compute_shared_vpc_host_project.shared_vpc_host) > 0 ? google_compute_shared_vpc_host_project.shared_vpc_host.*.project[0] : google_compute_network.vpc.project
  description = "VPC project id"
} */