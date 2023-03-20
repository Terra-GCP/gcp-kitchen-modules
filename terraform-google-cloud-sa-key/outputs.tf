output "service_account_key_details" {
    value = google_service_account_key.service_acccount_key
    sensitive = true
}