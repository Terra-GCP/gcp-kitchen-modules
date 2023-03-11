variable "project_id" {
  description = "The project id for putting the policy"
  type        = string
  default     = null
}
variable "allow" {
  description = "(Only for list constraints) List of values which should be allowed"
  type        = list(string)
  default     = [""]
}
variable "constraint" {
  description = "The constraint to be applied"
  type        = string
}


variable "exclude_project_id" {
  description = "The project id for excluding the policy"
  type        = string
  default     = null
}
variable "default" {
  description = "Values which should be excluded"
  type        = bool
  default     = false
}
variable "exclude_constraint" {
  description = "The constraint to be excluded"
  type        = string
  default     = null
}