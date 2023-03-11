/******************************************
  Google Cloud Project IAM Policy
 *****************************************/

resource "google_folder_iam_member" "folder" {
  count   = length(var.members)
  folder  = var.folder 
  role    = var.role
  member  = var.members[count.index]
}