/******************************************
  Google Cloud SA IAM Policy
 *****************************************/
resource "google_service_account_iam_binding" "sa_iam" {
  service_account_id  = var.service_account
  count   = length(var.roles)
  role    = var.roles[count.index]
  members = var.members
}