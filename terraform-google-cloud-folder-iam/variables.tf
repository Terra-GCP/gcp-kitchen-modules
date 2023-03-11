variable "folder" {
  description = "The folder on which iam role to be set"
  type        = string
}

variable "roles" {
  description = "The iam role to be set on the folder"
  type        = list(string)
}

variable "members" {
  description = "The member for whom iam role to be set on the folder"
  type        = list(string)
}