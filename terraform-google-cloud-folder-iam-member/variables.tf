variable "folder" {
  description = "The folder on which iam role to be set"
  type        = string
}

variable "role" {
  description = "The iam role to be set on the folder"
}

variable "members" {
  description = "The member for whom iam role to be set on the folder"
  type = list(any)
}