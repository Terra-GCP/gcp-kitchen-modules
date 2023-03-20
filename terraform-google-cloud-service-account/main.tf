resource "google_service_account" "service_account" {
  account_id   = var.account_id
  display_name = var.display_name
  project = var.project
}

resource "google_service_account_key" "service_acccount_key" {
  count              = var.create_sa_key ? 1 : 0
  service_account_id = var.service_account_id
  public_key_type    = var.public_key_type
}