variable "location" {
  description = "The location under which cloud build connection to be created"
  type        = string
}
variable "connection_name" {
  description = "The name of the cloud build connection to be created"
  type        = string
}
variable "project_id" {
  description = "The project under which cloud build connection to be created"
  type        = string
}
variable "app_id" {
  type        = string
}
variable "oauth_token" {
  type        = string
}


variable "repo_name" {
  type        = string
}
variable "remote_uri" {
  type        = string
}