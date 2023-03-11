variable "project_id" {
  type        = string
  description = "The project id to be used"
}
variable "name" {
  type        = string
  description = "The address name"
}
variable "address_type" {
  type        = string
  description = "The address type"
}
variable "purpose" {
  type        = string
  description = "The purpose of the address"
}
variable "prefix_length" {
  type        = number
  description = "The length of the address"
}
variable "network" {
  type        = string
  description = "The network of the address"
}
variable "address" {
  type        = string
  description = "static address"
}