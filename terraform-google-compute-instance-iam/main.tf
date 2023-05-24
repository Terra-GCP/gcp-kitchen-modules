/* locals {
    condition_applied = {
        title                   = var.title 
        description             = var.description 
        expression              = var.expression
    }
} */

resource "google_compute_instance_iam_binding" "binding" {
    count               = length(var.roles)
    instance_name       = var.instance_name
    zone                = var.zone            
    project             = var.project_id
    members             = var.members    
    role                = var.roles[count.index]
    
        
    dynamic "condition" {
            for_each = var.condition[*]
            content {
                title       = condition.value.title
                description = condition.value.description
                expression  = condition.value.expression
        }
    }
}