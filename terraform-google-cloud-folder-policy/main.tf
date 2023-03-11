/******************************************
  Folder policy, allow values (list constraint)
 *****************************************/
resource "google_folder_organization_policy" "folder_policy_list_allow_values" {
  
  count   = var.policy == "allow" ? 1 : 0
  folder     = var.folder_id
  constraint = var.constraint

  list_policy {
    allow {
      values = var.allow
    }
  }
}

/******************************************
  Organization policy, deny all (list constraint)
 *****************************************/

resource "google_folder_organization_policy" "folder_policy_list_deny_all" {

  count   = var.policy == "deny" ? 1 : 0
  folder     = var.folder_id
  constraint = var.constraint

  list_policy {
    deny {
      all = true
    }
  }
}

/******************************************
  Exclude folders from policy (list constraint)
 *****************************************/
resource "google_folder_organization_policy" "folder_policy_list_exclude_folders" {

  count   = var.policy == "exclude" ? 1 : 0
  folder     = var.folder_id
  constraint = var.constraint

  restore_policy {
    default = false
  }
}

