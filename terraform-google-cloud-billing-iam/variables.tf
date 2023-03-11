variable "billing_id" {
  description = "The billing account on which iam role to be set"
  type        = string
}

variable "role" {
  description = "The iam role to be set on the billing account"
  type        = string
}

variable "members" {
  description = "The member for whom iam role to be set on the billing account"
  #type        = list(string)
}