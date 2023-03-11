/******************************************
  Google Cloud Project IAM Policy
 *****************************************/
resource "google_project_iam_binding" "project_iam" {
  project = var.project_id
  count   = length(var.roles)
  role    = var.roles[count.index]
  members = var.members
}