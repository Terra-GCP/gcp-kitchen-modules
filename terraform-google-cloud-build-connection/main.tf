#.................................. Cloud Build Trigger ...................................#

resource "google_cloudbuildv2_connection" "build_connection" {
  provider              = google-beta
  location              = var.location 
  name                  = var.connection_name
  project               = var.project_id

  github_config {
    app_installation_id = var.app_id
    authorizer_credential {
      oauth_token_secret_version = var.oauth_token
    }
  }
}

resource "google_cloudbuildv2_repository" "repository_connection" {
  provider              = google-beta
  location              = var.location 
  name                  = var.repo_name
  parent_connection     = google_cloudbuildv2_connection.build_connection.name
  remote_uri            = var.remote_uri
}