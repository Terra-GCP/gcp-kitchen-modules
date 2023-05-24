/* variable "title" {
  type = string
  description = "A title for the expression, i.e. a short string describing its purpose."
  default = "expires_after_2023_12_31"
}
variable "description" {
  type = string
  description = "An optional description of the expression. This is a longer text which describes the expression, e.g. when hovered over it in a UI."
  default = "Expiring at midnight of 2023-12-31"
}
variable "expression" {
  type = string
  description = "Textual representation of an expression in Common Expression Language syntax."
  default = "request.time < timestamp(\"2023-12-12T00:00:00Z\")"
} */

variable "instance_name" {
  type = string
  description = "Used to find the parent resource to bind the IAM policy to"
  default = "vm1"
}
variable "zone" {
  type = string
  description = "A reference to the zone where the machine resides. Used to find the parent resource to bind the IAM policy to. "
  default = "europe-north1-a"
}
variable "project_id" {
  type = string
  description = "The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
  default = "prj-o-tf-sa"
}
variable "members" {
  type = list(string)
  description = "The role that should be applied. Only one google_compute_instance_iam_binding can be used per role. Note that custom roles must be of the format [projects|organizations]/{parent-name}/roles/{role-name}."
  default = ["user:ayush.shukla@hcl.com"]
}
variable "roles" {
  type = list(string)
  description = "The role that should be applied. Only one google_compute_instance_iam_binding can be used per role. Note that custom roles must be of the format [projects|organizations]/{parent-name}/roles/{role-name}."
  default = ["roles/compute.osLogin"]
}
variable "condition" {
  description = "An IAM Condition for a given binding."
  type = list(object(
    {
        title                            = string
        description                      = string    
        expression                       = string
    }
    )
    )

  default = [
    /* {
        title                            = "expires_after_2019_12_31"
        description                      = "Expiring at midnight of 2023-01-01"   
        expression                       = "request.time < timestamp(\"2023-01-01T00:00:00Z\")"   
    } */
    ]
}
