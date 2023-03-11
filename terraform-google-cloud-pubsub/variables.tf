variable "topic_name" {
  description = "The name of the pub sub topic"
  type        = string
}
variable "project_id" {
  description = "The project under which pub sub topic to be created"
  type        = string
}
variable "labels" {
  description = "The labels to be set for the pubsub topic"
  type        = map(any)
}
variable "message_retention_duration" {
  description = "The message retention duration to be set for the pubsub topic"
  type        = string
}
variable "subscription_name" {
  description = "The name of the pub sub subscription"
  type        = string
}
variable "retain_acked_messages" {
  description = "Retain acknowledged messages"
  type        = bool
}
variable "ack_deadline_seconds" {
  description = "Retain acknowledged messages time"
  type        = number
}
variable "ttl" {
  description = "Expiration policy to be set for subscription"
  type        = string
}
variable "minimum_backoff" {
  description = "Minimum backoff to be set for subscription"
  type        = string
}
variable "enable_message_ordering" {
  description = "Message Ordering to be enabled/disabled for subscription"
  type        = bool
}