/******************************************
  Google Cloud Organization IAM Policy
 *****************************************/
resource "google_organization_iam_binding" "org_iam" {
  org_id  = var.org_id
  count   = length(var.roles)
  role    = var.roles[count.index]
  members = var.members
}