/******************************************
  Google Cloud Project IAM Policy
 *****************************************/
resource "google_folder_iam_binding" "folder_iam" {
  folder  = var.folder
  count   = length(var.roles)
  role    = var.roles[count.index]
  members = var.members
}