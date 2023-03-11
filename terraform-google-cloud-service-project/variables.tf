variable "enable_shared_vpc_service_project" {
  description = "If this project should be attached to a shared VPC. If true, you must set shared_vpc variable."
  type        = bool
  default     = false
}

variable "host_project" {
  description = "The ID of the host project which hosts the shared VPC"
  type        = string
}

variable "service_project" {
  description = "The ID of the service project"
  type        = string
}
