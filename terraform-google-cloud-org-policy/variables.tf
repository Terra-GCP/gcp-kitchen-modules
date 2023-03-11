variable "organization_id" {
  description = "The organization id for putting the policy"
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

variable "policy" {
  description = "Allow/Deny policy"
  type        = string
  default     = null
}