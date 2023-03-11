variable "project_id" {
  description = "The name of the project id on which iam role to be set"
  type        = string
}

variable "role" {
  description = "The iam role to be set on the project"
  #type        = string
}

variable "members" {
  description = "The member for whom iam role to be set on the project"
  #type        = string
}