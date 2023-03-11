#.................................... Pubsub Subscription .................................#

resource "google_cloud_scheduler_job" "job" {
  name             = var.job_name
  project          = var.project_id
  region           = var.region
  description      = var.job_description
  schedule         = var.schedule
  time_zone        = var.time_zone
  attempt_deadline = var.attempt_deadline 

  retry_config {
    min_backoff_duration = "1s"
    max_retry_duration = "10s"
    max_doublings = 2
    retry_count = 3
  }

  pubsub_target {
    # topic.id is the topic's full resource name.

    topic_name     = var.topic_name
    data           = base64encode("This scheduler will be used to invoke any pubsub topic and subscription")
  }
}