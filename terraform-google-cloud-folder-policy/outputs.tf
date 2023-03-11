output "allowed_folder_policy_details" {
    value = google_folder_organization_policy.folder_policy_list_allow_values
}

output "denied_folder_policy_details" {
    value = google_folder_organization_policy.folder_policy_list_deny_all
}


output "excluded_folder_policy_details" {
    value = google_folder_organization_policy.folder_policy_list_exclude_folders
}