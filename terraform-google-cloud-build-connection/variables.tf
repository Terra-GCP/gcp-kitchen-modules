variable "trigger_name" {
  description = "The name of build trigger to be created"
  type        = string
}
variable "location" {
  description = "The location under which build trigger to be created"
  type        = string
}
variable "description" {
  description = "The descriotion of the build trigger to be created"
  type        = string
}
variable "path" {
  description = "The path of the build trigger template to be used"
  type        = string
}
variable "repo_type" {
  description = "The type of the repo for build trigger to be used"
  type        = string
}
variable "revision" {
  description = "The revision type of the repo for build trigger to be used"
  type        = string
}
variable "subscription" {
  description = "The pubsub subscription to be used"
  type        = string
}
variable "topic" {
  description = "The pubsub topic to be used"
  type        = string
}
variable "project_id" {
  description = "The project under which trigger to be created"
  type        = string
}
variable "repo_name" {
  description = "The repo name to be used"
  type        = string
}
variable "branch_name" {
  description = "The branch name to be used"
  type        = string
}
variable "tags" {
  description = "The tags to be used for trigger"
  type        = list(string)
}
variable "logs_bucket" {
  description = "The bucket to be used for storing logs of trigger"
  type        = string
}