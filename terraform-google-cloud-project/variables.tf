variable "billing_account_id" {
  description = "The name of the billing account to associate this project with"
  sensitive   = true
  type        = string
}

variable "project_name" {
  description = "The name for the project"
  type        = string
}

variable "project_id" {
  description = "The ID to give the project"
  type        = string
}

########## NOTE ###########
## Only one of org_id or folder_id may be specified.
## If the org_id is specified then the project is created at the top level.
variable "org_id" {
  description = "The organization ID."
  type        = string
  default     = null
}

variable "folder_id" {
  description = "The ID of a folder to host this project"
  type        = string
  default     = ""
}
#

variable "auto_create_network" {
  description = "Create the default network"
  type        = bool
  default     = false
}

variable "labels" {
  description = "Map of labels for project"
  type        = map(string)
  default     = {}
}
