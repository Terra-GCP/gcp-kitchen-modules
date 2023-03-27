variable "project_id" {
  type        = string
}
variable "labels" {
  type = map
}
variable "auto_replication" {
  type = bool
}
variable "secret_data" {
  type = any
}

