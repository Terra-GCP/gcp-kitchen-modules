variable "project_id" {
  description = "The name of the project id on which iam role to be set"
  type        = string
}

variable "roles" {
  description = "The iam role to be set on the project"
  type        = list(string)
}

variable "members" {
  description = "The member for whom iam role to be set on the project"
  type        = list(string)
}
