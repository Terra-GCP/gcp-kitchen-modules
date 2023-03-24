/******************************************
  Google Cloud PubSub Topic and Subscription
 *****************************************/
resource "google_pubsub_topic" "pubsub_topic" {
  name = var.topic_name
  project = var.project_id
  labels = var.labels
  message_retention_duration = var.message_retention_duration
}


#.................................... Pubsub Subscription .................................#

resource "google_pubsub_subscription" "subscription" {
  name                       = var.subscription_name
  topic                      = google_pubsub_topic.pubsub_topic.id
  labels                     = var.labels

  # 20 minutes
  message_retention_duration = var.message_retention_duration
  retain_acked_messages      = var.retain_acked_messages 

  ack_deadline_seconds       = var.ack_deadline_seconds

  expiration_policy {
    ttl                      = var.ttl 
  }
  retry_policy {
    minimum_backoff          = var.minimum_backoff 
  }
  enable_message_ordering = var.enable_message_ordering
}