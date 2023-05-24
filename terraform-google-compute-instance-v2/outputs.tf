/* output "instances" {
  sensitive   = false
  description = "Google Cloud Instances"
  value       = [for name, instance in google_compute_instance.instance : instance]
}

output "instances_internal_ips" {
  sensitive   = false
  description = "Instances internal ips"
  value       = [for name, instance in google_compute_instance.instance : instance.network_interface.o.network_ip]
}

output "instances_names" {
  sensitive   = false
  description = "Instances names"
  value       = [for name, instance in google_compute_instance.instance : instance.name]
}

output "instances_self_links" {
  sensitive   = false
  description = "Instances self_links"
  value       = [for name, instance in google_compute_instance.instance : instance.self_link]
} */