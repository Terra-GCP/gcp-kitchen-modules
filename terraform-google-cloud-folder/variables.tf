variable "parent" {
  type        = string
  description = "The resource name of the parent Folder or Organization. Must be of the form folders/folder_id or organizations/org_id"
}

variable "folder_name" {
  #type        = string
  description = "The folder’s display name. A folder’s display name must be unique amongst its siblings, e.g. no two folders with the same parent can share the same display name."
}