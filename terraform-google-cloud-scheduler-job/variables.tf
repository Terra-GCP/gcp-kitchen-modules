variable "job_name" {
  description = "The name of the job scheduler to be created"
  type        = string
}
variable "project_id" {
  description = "The project under which job scheduler to be created"
  type        = string
}
variable "region" {
  description = "The region in which the job scheduler to be created"
  type        = string
}
variable "job_description" {
  description = "The description to be put on the job scheduler created"
  type        = string
}
variable "schedule" {
  description = "The schedule of the job to be created"
  type        = string
}
variable "time_zone" {
  description = "The time zone of the job to be created"
  type        = string
}
variable "attempt_deadline" {
  description = "Retain acknowledged messages time"
  type        = string
}
variable "topic_name" {
  description = "Pub Sub topic name to be linked with this job scheduler"
  type        = string
}