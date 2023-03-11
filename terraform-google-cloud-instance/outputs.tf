output "instance_details" {
  value       = google_compute_instance.default
  description = "Google Cloud Instance Details"
}



/* output "instance_name" {
  value       = google_compute_instance.default.name
  description = "Google Cloud Instance name"
}
output "instance_machine_type" {
  value       = google_compute_instance.default.machine_type
  description = "Google Cloud Instance Machine Type"
}
output "project_id" {
  value       = google_compute_instance.default.project
  description = "Google Cloud project ID"
}

output "instance_self_link" {
  value       = google_compute_instance.default.self_link
  description = "The URI of the instance rule  being created"
}

output "network_name_1" {
  value       = google_compute_instance.default.network_interface[0].network
  description = "The name of the VPC network where the VM's first network interface is created"
}

output "instance_internal_ip" {
  value       = google_compute_instance.default.network_interface[0].network_ip
  description = "The Internal IP of the VM being created"
}

output "instance_status" {
  value       = google_compute_instance.default.desired_status
  description = "The desired status of the VM being created"
}
output "instance_hostname" {
  value       = google_compute_instance.default.hostname
  description = "The HostName of the VM being created"
}

output "instance_maintenance" {
  value       = google_compute_instance.default.scheduling.*.on_host_maintenance
  description = "The On-Host-Maintenance status of the VM being created"
}

output "instance_confidential_mode" {
  value       = google_compute_instance.default.confidential_instance_config.*.enable_confidential_compute
  description = "The Confidential Mode status of the VM"
} */