resource "google_secret_manager_secret" "secret" {
  provider   = google-beta
  project    = var.project_id
  secret_id  = var.secret_id 
  labels     = var.labels 
  replication {
    user_managed {
      replicas {
        location = var.location
      }
    }
  }
}

resource "google_secret_manager_secret_version" "secret-version" {
  provider    = google-beta
  secret      = google_secret_manager_secret.secret.id
  secret_data = var.secret_data
}
