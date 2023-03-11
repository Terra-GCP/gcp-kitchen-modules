variable "command" {
  description = "The command of the repo to be created"
  type        = any
}
variable "working_dir" {
  description = "The project under which rope to be created"
  type        = string
}
variable "interpreter" {
  description = "The project under which rope to be created"
  type        = list(any)
}