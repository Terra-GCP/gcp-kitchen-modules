locals {
  source_image          = var.source_image != "" ? var.source_image : "ubuntu-2204-lts"
  source_image_project  = var.source_image_project != "" ? var.source_image_project : "ubuntu-os-cloud"
  shielded_instance     = var.allow_stopping_for_update == true || var.desired_status == "TERMINATED"

  hostname              = var.hostname == "" ? "default" : var.hostname
}

resource "google_compute_instance" "instance" {
    provider                                    = google-beta
    name                                        = var.name == null ? local.hostname : var.name
    machine_type                                = var.machine_type
    zone                                        = var.zone
    tags                                        = var.tags
    
    dynamic "boot_disk" {
        for_each = var.boot_disk[*]
        content {
            auto_delete                         = lookup(boot_disk.value, "auto_delete", true)
            device_name                         = lookup(boot_disk.value, "device_name", null)
            mode                                = lookup(boot_disk.value, "mode", "READ_WRITE")
            disk_encryption_key_raw             = boot_disk.value.disk_encryption_key_raw != null ? boot_disk.value.disk_encryption_key_raw : null
            kms_key_self_link                   = boot_disk.value.kms_key_self_link != null ? boot_disk.value.kms_key_self_link : null
            source                              = lookup(boot_disk.value, "source", null)
            
            dynamic "initialize_params" {
                for_each = var.boot_disk[*].source != "" ? [] : lookup(boot_disk.value, "initialize_params", [])
                content {
                    size                        = lookup(initialize_params.value, "size", 20) 
                    type                        = lookup(initialize_params.value, "type", "pd-ssd") #lookup(scratch_disk.value, "size", lookup(scratch_disk.value, "type", null) == "local-ssd" ? "375" : null)
                    image                       = initialize_params.value.image == null ? format("${local.source_image_project}/${local.source_image}") : lookup(initialize_params.value, "image", "ubuntu-os-cloud/ubuntu-2204-lts")
                    labels                      = lookup(initialize_params.value, "labels", null)
                }
            }      
        }
    }

    dynamic "network_interface" {
        for_each = var.network_interface[*]
        content {
            network                             = network_interface.value.subnetwork != "" ? null : lookup(network_interface.value, "network", "default")
            subnetwork                          = network_interface.value.network != "" ? null : lookup(network_interface.value, "subnetwork", "")
            subnetwork_project                  = lookup(network_interface.value, "subnetwork_project", "")
            network_ip                          = lookup(network_interface.value, "network_ip", "")

            dynamic "access_config" {
                for_each = lookup(network_interface.value, "access_config", [])
                content {
                    nat_ip                      = lookup(access_config.value, "nat_ip", null)
                    public_ptr_domain_name      = lookup(access_config.value, "public_ptr_domain_name", null)
                    network_tier                = lookup(access_config.value, "network_tier", null)
                }
            }
            
            dynamic "alias_ip_range" {
                for_each = lookup(network_interface.value, "alias_ip_range", [])
                content {
                    ip_cidr_range               = lookup(alias_ip_range.value, "ip_cidr_range", null)
                    subnetwork_range_name       = lookup(alias_ip_range.value, "subnetwork_range_name", null)
                }
            }
                
            nic_type                            = var.nic_type
            stack_type                          = var.stack_type

            dynamic "ipv6_access_config" {
                for_each = lookup(network_interface.value, "ipv6_access_config", [])
                content {
                    public_ptr_domain_name      = lookup(ipv6_access_config.value, "public_ptr_domain_name", null)
                    network_tier                = lookup(ipv6_access_config.value, "network_tier", null)
                }
            }
    
            queue_count                         = var.queue_count
        }
    }
    
    allow_stopping_for_update                   = var.allow_stopping_for_update

    dynamic "attached_disk" {
        for_each = var.attached_disk[*]
        content {
            source                              = lookup(attached_disk.value, "source", null)
            device_name                         = lookup(attached_disk.value, "device_name", null)
            mode                                = lookup(attached_disk.value, "mode", "READ_WRITE")
            disk_encryption_key_raw             = lookup(attached_disk.value, "disk_encryption_key_raw", null)
            kms_key_self_link                   = lookup(attached_disk.value, "kms_key_self_link", null)
        }
    } 
  

    can_ip_forward                              = var.can_ip_forward
    description                                 = var.description
    desired_status                              = var.desired_status
    deletion_protection                         = var.deletion_protection
    hostname                                    = local.hostname

    dynamic "guest_accelerator" {
        for_each = var.scheduling[*].on_host_maintenance == "TERMINATE" ? [] : var.guest_accelerator[*]
        content {
            type                                = lookup(guest_accelerator.value, "type", "")
            count                               = lookup(guest_accelerator.value, "count", null)
        }
    }
  

    labels                                      = var.labels
    metadata                                    = var.metadata
    metadata_startup_script                     = var.metadata_startup_script
    min_cpu_platform                            = local.shielded_instance ? true : var.min_cpu_platform
    project                                     = var.project_id

    dynamic "scheduling" {
        for_each = var.scheduling[*]
        content {
            # If provisioning_model is set to SPOT, preemptible should be true and auto_restart should be false
            preemptible                         = scheduling.value.provisioning_model == "SPOT" ? true : lookup(scheduling.value, "preemptible", false) 
            on_host_maintenance                 = lookup(scheduling.value, "on_host_maintenance", "MIGRATE")
                            # automatic_restart must be false when preemptible is true
            automatic_restart                   = scheduling.value.preemptible == true ? false : lookup(scheduling.value, "automatic_restart", false)

            dynamic "node_affinities" {
                for_each = lookup(scheduling.value, "node_affinities", [])
                content {
                    key                         = lookup(node_affinities.value, "key", "")
                    operator                    = lookup(node_affinities.value, "operator", "")
                    values                      = lookup(node_affinities.value, "values", [""])
                }
            }

            min_node_cpus                       = lookup(scheduling.value, "min_node_cpus", null)
            provisioning_model                  = lookup(scheduling.value, "provisioning_model", "") 
            instance_termination_action         = lookup(scheduling.value, "instance_termination_action", "")

            dynamic "max_run_duration" {
                for_each = lookup(scheduling.value, "max_run_duration", [])
                content {
                    nanos                       = lookup(max_run_duration.value, "nanos", null)
                    seconds                     = lookup(max_run_duration.value, "seconds", null)
                }
            } 
            
            maintenance_interval                = scheduling.value.maintenance_interval
      }
    }

    dynamic "scratch_disk" {
        for_each = var.scratch_disk[*]
        content {
            interface                           = lookup(scratch_disk.value, "interface", null)
        }
    }

    dynamic "service_account" {
        for_each = var.service_account[*]
        content {
            email                               = lookup(service_account.value, "email", null)
            scopes                              = lookup(service_account.value, "scopes", ["compute-rw", "storage-rw"])
        }
    }

    dynamic "shielded_instance_config" {
        for_each = var.shielded_instance_config[*]
        content {
            # allow_stopping_for_update must be set to true or your instance must have a desired_status of TERMINATED in order to update this field.
            enable_secure_boot                  = local.shielded_instance ? true : lookup(shielded_instance_config.value, "enable_secure_boot", false)
            enable_vtpm                         = local.shielded_instance ? true : lookup(shielded_instance_config.value, "enable_vtpm", false)
            enable_integrity_monitoring         = local.shielded_instance ? true : lookup(shielded_instance_config.value, "enable_integrity_monitoring", false)
        }
    }

    enable_display                              = local.shielded_instance ? true : var.enable_display
    resource_policies                           = var.resource_policies

    dynamic "reservation_affinity" {
        for_each = var.reservation_affinity[*]
        content {
            type                                = lookup(reservation_affinity.value, "type", "")

            dynamic "specific_reservation" {
                for_each = lookup(reservation_affinity.value, "specific_reservation", [])
                content {
                    key                         = lookup(specific_reservation.value, "key", "")
                    values                      = lookup(specific_reservation.value, "values", [""])
                }
            } 
        }
    }

    dynamic "confidential_instance_config" {
        for_each = var.confidential_instance_config[*]
        content {
            # on_host_maintenance has to be set to TERMINATE or this will fail to create the VM.
            enable_confidential_compute         = var.scheduling.on_host_maintenance == "MIGRATE" ? false : lookup(confidential_instance_config.value, "enable_confidential_compute", false)
        }
    }

    dynamic "advanced_machine_features" {
        for_each = var.advanced_machine_features[*]
        content {
            enable_nested_virtualization        = lookup(advanced_machine_features.value, "enable_nested_virtualization", false)
            threads_per_core                    = lookup(advanced_machine_features.value, "threads_per_core", null)
            visible_core_count                  = lookup(advanced_machine_features.value, "visible_core_count", null)
        }
    }

    dynamic "network_performance_config" {
        for_each = var.network_performance_config[*]
        content {
            total_egress_bandwidth_tier         = lookup(network_performance_config.value, "total_egress_bandwidth_tier", "")
        }
    }
}
