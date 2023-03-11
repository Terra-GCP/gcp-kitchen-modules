variable "network" {
  type        = string
  description = "The network of the address"
}
variable "service" {
  type        = string
  description = "private service"
}
variable "ranges" {
  type        = list(any)
  description = "private service ip ranges"
}