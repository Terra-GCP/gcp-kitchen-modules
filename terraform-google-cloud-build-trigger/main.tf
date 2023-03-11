#.................................. Cloud Build Trigger ...................................#

resource "google_cloudbuild_trigger" "build-trigger" {
  name = var.trigger_name
  location = var.location
  description = var.description

git_file_source {
    path      = var.path
    repo_type = var.repo_type
    revision = var.revision
  }
  pubsub_config {
    subscription = var.subscription
    topic = var.topic
  }

  build {
      step {
      name = "hashicorp/terraform:1.0.0"
    }
      source {
          repo_source {
              project_id = var.project_id 
              repo_name = var.repo_name
              branch_name = var.branch_name
              }
            }
            tags = var.tags
            logs_bucket = var.logs_bucket
  }
}