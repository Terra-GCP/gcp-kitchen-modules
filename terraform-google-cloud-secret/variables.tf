variable "project_id" {
  type        = string
}
variable "secret_id" {
  type        = string
}
variable "labels" {
  type = map
}
variable "location" {
  type = string
}
variable "secret_data" {
  type = any
}

