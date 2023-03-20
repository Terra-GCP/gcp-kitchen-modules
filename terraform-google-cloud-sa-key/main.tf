resource "google_service_account_key" "service_acccount_key" {
  service_account_id = var.service_account_id
  public_key_type    = var.public_key_type
}