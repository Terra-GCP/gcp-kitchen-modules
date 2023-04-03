#.................................. Cloud Build Trigger ...................................#

resource "google_cloudbuild_trigger" "build-trigger" {
  provider           = google-beta       
  name               = var.trigger_name
  location           = var.location
  disabled           = var.disabled
  project            = var.project_id
  #include_build_logs = var.build_logs
  description        = var.description

  pubsub_config {
    topic            = var.topic
  }

  source_to_build {
    uri       = var.uri 
    ref       = var.revision 
    repo_type = var.repo_type 
  }
  
  git_file_source {
    path             = var.path
    uri              = var.uri
    repo_type        = var.repo_type
    revision         = var.revision
  }

  approval_config {
     approval_required = var.approval_required
  }

}