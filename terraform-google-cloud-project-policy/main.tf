/******************************************
  Project policy, allow values (list constraint)
 *****************************************/
resource "google_project_organization_policy" "project_policy_list_allow_values" {

  project    = var.project_id
  constraint = var.constraint

  list_policy {
    allow {
      values = var.allow
    }
  }
}

/******************************************
  Exclude projects from policy (list constraint)
 *****************************************/
resource "google_project_organization_policy" "project_policy_list_exclude_projects" {

  project    = var.exclude_project_id
  constraint = var.exclude_constraint

  restore_policy {
    default = var.default
  }
}