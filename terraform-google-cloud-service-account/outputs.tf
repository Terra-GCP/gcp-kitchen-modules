output "service_account_details" {
    value = google_service_account.service_account
}

output "service_account_key_details" {
    value = google_service_account_key.service_acccount_key
}