/// PERMANENT SOLUTION ///

/* data "google_billing_account" "billing" {
  display_name = var.billing_account_name
  open         = true
}
locals {
  project_org_id    = var.folder_id != "" ? null : var.org_id
  project_folder_id = var.folder_id != "" ? var.folder_id : null
}

resource "google_project" "project" {
  name                = var.project_name
  project_id          = var.project_id
  org_id              = local.project_org_id
  folder_id           = local.project_folder_id
  billing_account     = data.google_billing_account.billing.id
  auto_create_network = var.auto_create_network
  labels              = var.labels

  lifecycle {
    ignore_changes = [billing_account]
  }
  depends_on = [data.google_billing_account.billing]

} */


///TEMP SOLUTION////


locals {
  project_org_id    = var.folder_id != "" ? null : var.org_id
  project_folder_id = var.folder_id != "" ? var.folder_id : null
  billing_account_id = var.billing_account_id != "" ? var.billing_account_id : null
}

resource "google_project" "project" {
  name                = var.project_name
  project_id          = var.project_id
  org_id              = local.project_org_id
  folder_id           = local.project_folder_id
  billing_account     = local.billing_account_id
  auto_create_network = var.auto_create_network
  labels              = var.labels

  /* lifecycle {
    ignore_changes = [billing_account]
  } */

}
