output "project_policy_details" {
    value = google_project_organization_policy.project_policy_list_allow_values
}
output "excluded_project_policy_details" {
    value = google_project_organization_policy.project_policy_list_exclude_projects
}