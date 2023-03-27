#.................................. Cloud Build Trigger ...................................#

resource "google_cloudbuildv2_connection" "my-connection" {
  provider              = google-beta
  location              = var.location "us-west1"
  name                  = var.connection_name "my-connection"
  project               = var.project

  github_config {
    app_installation_id = 123123
    authorizer_credential {
      oauth_token_secret_version = google_secret_manager_secret_version.github-token-secret-version.id
    }
  }
}