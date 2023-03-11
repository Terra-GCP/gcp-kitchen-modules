/******************************************
  Google Cloud Project IAM Policy
 *****************************************/

resource "google_project_iam_member" "project_iam_member" {
  project = var.project_id
  count   = length(var.members)
  role    = var.role
  member  = var.members[count.index]
}