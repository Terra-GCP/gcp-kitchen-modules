variable "trigger_name" {
  description = "The name of build trigger to be created"
  type        = string
}
variable "location" {
  description = "The location under which build trigger to be created"
  type        = string
}
variable "disabled" {
  type        = string
}
variable "project_id" {
  description = "The project under which trigger to be created"
  type        = string
}
variable "build_logs" {
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
variable "uri" {
  description = "The uri of the build trigger template to be used"
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
variable "approval_required" {
  type        = string
}
