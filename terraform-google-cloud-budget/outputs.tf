output "billing_budget_details" {
    value = google_billing_budget.budget
}

output "budget_notification_details" {
    value = google_monitoring_notification_channel.budget_notify
}


/* output "budget_name" {
    value = google_billing_budget.budget.display_name
}
output "budget_amount" {
    value = google_billing_budget.budget.amount
}
output "budget_project" {
    value = google_billing_budget.budget.budget_filter[0].projects
}
output "budget_threshold" {
    value = google_billing_budget.budget.threshold_rules
}


output "budget_notification_name" {
    value = google_monitoring_notification_channel.budget_notify.display_name
}
output "budget_notification_email" {
    value = google_monitoring_notification_channel.budget_notify.labels.email_address
} */