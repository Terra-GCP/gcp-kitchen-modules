variable "private-network" {
  description = ""
  type        = string
}

variable "private-ip-address" {
  description = ""
  type        = string
}

variable "private_instance_name" {
  description = ""
  type        = string
}

variable "db_version" {
  description = ""
  type        = string
}


variable "project_id" {
  description = ""
  type        = string
}

variable "region" {
  description = ""
  type        = string
}

variable "tier" {
  description = ""
  type        = string
}

variable "ipv4_enabled" {
  description = "Optional map of lowercase unprefixed name => boolean, defaults to false."
  type        = bool
  default     = false
  
variable "labels" {
  description = "Labels to be attached to the buckets"
  type        = map(string)
  default     = {}
}

