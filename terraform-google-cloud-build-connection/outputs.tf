output "build_connection_details" {
    value = google_cloudbuildv2_connection.build_connection
}
output "repository_connection_details" {
    value = google_cloudbuildv2_repository.repository_connection
}