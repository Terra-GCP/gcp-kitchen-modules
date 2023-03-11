#.................................... Pubsub Topic .................................#

output "pubsub_topic_details" {
    value = google_pubsub_topic.pubsub_topic
}

/* output "pubsub_topic_name" {
    value = google_pubsub_topic.pubsub_topic.name
}
output "pubsub_topic_id" {
    value = google_pubsub_topic.pubsub_topic.id
}
output "pubsub_topic_labels" {
    value = google_pubsub_topic.pubsub_topic.labels
}
output "pubsub_message_retention_duration" {
    value = google_pubsub_topic.pubsub_topic.message_retention_duration
} */

#................................. Pubsub Subscription ..............................#

output "pubsub_subsciption_details" {
    value = google_pubsub_subscription.subscription
}

/* output "pubsub_subsciption_name" {
    value = google_pubsub_subscription.subscription.name
} */