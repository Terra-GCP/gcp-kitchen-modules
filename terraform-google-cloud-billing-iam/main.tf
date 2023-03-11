/******************************************
  Google Cloud Billing IAM Policy
 *****************************************/
resource "google_billing_account_iam_binding" "billing" {
  billing_account_id = var.billing_id 
  role               = var.role 
  members            = var.members
}