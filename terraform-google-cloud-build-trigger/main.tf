#.................................. Cloud Build Trigger ...................................#

resource "google_cloudbuild_trigger" "build-trigger" {
  name               = var.trigger_name
  location           = var.location
  disabled           = var.disabled
  project            = var.project_id
  #include_build_logs = var.build_logs
  description        = var.description

git_file_source {
    path             = var.path
    uri              = var.uri
    repo_type        = var.repo_type
    revision         = var.revision
  }
  pubsub_config {
    topic            = var.topic
  }

  approval_config {
     approval_required = var.approval_required
  }

}