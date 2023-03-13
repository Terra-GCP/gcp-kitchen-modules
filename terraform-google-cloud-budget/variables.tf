variable "billing_account_id" {
  description = "The billing account id setting the budget"
  type        = string
}

variable "budget_name" {
  description = "The name of the budget quota to be allowed"
  type        = string
}

variable "project_id" {
  description = "The name of the project id on which quota to be set"
  type        = list(string)
}

variable "budget_amount" {
  description = "The amount of the budget on which quota to be set"
  type        = number
}

variable "budget_notify_name" {
  description = "The name of the budget notification for email"
  type        = string
}

variable "email_address" {
  description = "The email addresses to whom budget notification to be sent"
  type        = string
}