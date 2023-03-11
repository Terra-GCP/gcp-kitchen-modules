output "project_details" {
  description = "Details of the project"
  value       = google_project.project
}


/* output "project_name" {
  description = "Name of the project"
  value       = google_project.project.name
}

output "project_id" {
  description = "ID of the project"
  value       = google_project.project.project_id
}

output "project_number" {
  description = "Numeric identifier for the project"
  value       = google_project.project.number
}
 */