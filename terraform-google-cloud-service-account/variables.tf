variable "project" {
  description = "The name of the project id in which service account needs to be created"
  type        = string
}

variable "display_name" {
  description = "The display name to be used for service account"
  #type        = string
}

variable "account_id" {
  description = "The account id to be used for service account"
  #type        = string
}

// Key //

variable "sa_key" {
  description = "The sa key to be created for service account"
  #type        = string
}
variable "service_account_id" {
  description = "The sa account id to be used for creating the key"
  #type        = string
}
variable "public_key_type" {
  description = "The public key type to be used for creating the key"
  #type        = string
}
