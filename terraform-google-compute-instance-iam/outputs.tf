output "instance_iam_binding_details" {
  value       = google_compute_instance_iam_binding.binding
  sensitive   = false
  description = "Google Cloud Instance IAM Binding Details"
}