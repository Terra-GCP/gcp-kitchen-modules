/******************************************
  Organization policy, allow values (list constraint)
 *****************************************/
resource "google_organization_policy" "org_policy_list_allow_values" {
  count   = var.policy == "allow" ? 1 : 0
  org_id     = var.organization_id
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
resource "google_organization_policy" "org_policy_list_deny_all" {
  count   = var.policy == "deny" ? 1 : 0
  org_id     = var.organization_id
  constraint = var.constraint

  list_policy {
    deny {
      all = true
    }
  }
}