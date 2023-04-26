resource "google_compute_instance" "instance" {
  provider                              = google-beta
  name                                  = var.name
  machine_type                          = var.machine_type
  zone                                  = var.zone
  tags                                  = var.tags

  boot_disk {
    auto_delete                         = var.auto_delete_boot_disk
    device_name                         = var.device_name_boot_disk
    mode                                = var.mode_boot_disk
    disk_encryption_key_raw             = var.disk_encryption_key_raw_boot_disk != null ? var.disk_encryption_key_raw_boot_disk : null
    kms_key_self_link                   = var.kms_key_self_link_boot_disk != null ? var.kms_key_self_link_boot_disk : null
    source                              = var.source_boot_disk

    initialize_params {
        size                            = var.size_boot_disk
        type                            = var.type_boot_disk
        image                           = var.image_boot_disk
        labels                          = var.labels
    }
  }
  
  network_interface {
    network                             = var.network
    subnetwork                          = var.subnetwork
    subnetwork_project                  = var.subnetwork_project
    network_ip                          = var.network_ip
    
    dynamic "access_config" {
        for_each = var.access_config == false ? toset([]) : toset([1])
        content {
            nat_ip                      = var.nat_ip
            public_ptr_domain_name      = var.public_ptr_domain_name
            network_tier                = var.network_tier
    }
  } 
    /* access_config {
        nat_ip                          = var.nat_ip
        public_ptr_domain_name          = var.public_ptr_domain_name
        network_tier                    = var.network_tier
    } */

    dynamic "alias_ip_range" {
        for_each = var.alias_ip_range == false ? toset([]) : toset([1])
        content {
            ip_cidr_range               = var.ip_cidr_range
            subnetwork_range_name       = var.subnetwork_range_name
    }
  }
    
    /* alias_ip_range {
        ip_cidr_range                   = var.ip_cidr_range
        subnetwork_range_name           = var.subnetwork_range_name
    } */

    nic_type                            = var.nic_type
    stack_type                          = var.stack_type

    dynamic "ipv6_access_config" {
        for_each = var.ipv6_access_config == false ? toset([]) : toset([1])
        content {
            public_ptr_domain_name      = var.public_ptr_domain_name
            network_tier                = var.network_tier
    }
  }

    /* ipv6_access_config {
        public_ptr_domain_name          = var.public_ptr_domain_name
        network_tier                    = var.network_tier  
    } */
    
    queue_count                         = var.queue_count
  }

  allow_stopping_for_update             = var.allow_stopping_for_update

  dynamic "attached_disk" {
        for_each = var.attached_disk == false ? toset([]) : toset([1])
        content {
            source                      = var.source_data_disk
            device_name                 = var.device_name_data_disk
            mode                        = var.mode_data_disk
            disk_encryption_key_raw     = var.disk_encryption_key_raw_data_disk
            kms_key_self_link           = var.kms_key_self_link_data_disk
    }
  } 
  
  /* attached_disk {
    source                              = var.source_data_disk
    device_name                         = var.device_name_data_disk
    mode                                = var.mode_data_disk
    disk_encryption_key_raw             = var.disk_encryption_key_raw_data_disk
    kms_key_self_link                   = var.kms_key_self_link_data_disk
  } */ 

  can_ip_forward                        = var.can_ip_forward
  description                           = var.description
  desired_status                        = var.desired_status
  deletion_protection                   = var.deletion_protection
  hostname                              = var.hostname

  dynamic "guest_accelerator" {
        for_each = var.guest_accelerator == false ? toset([]) : toset([1])
        content {
            type                        = var.type_gpu
            count                       = var.count_gpu
    }
  }
  
  /* guest_accelerator {
    type                                = var.type_gpu
    count                               = var.count_gpu          
  } */

  labels                                = var.labels
  metadata                              = var.metadata
  metadata_startup_script               = var.metadata_startup_script
  min_cpu_platform                      = var.min_cpu_platform
  project                               = var.project_id

    dynamic "scheduling" {
        for_each = var.scheduling == false ? toset([]) : toset([1])
        content {
            preemptible                 = var.preemptible
            automatic_restart           = var.automatic_restart 
            on_host_maintenance         = var.on_host_maintenance

            node_affinities {
                key                     = var.key_node_affinities
                operator                = var.operator_node_affinities
                values                  = var.values_node_affinities
            }

            min_node_cpus               = var.min_node_cpus 
            provisioning_model          = var.provisioning_model 
            instance_termination_action = var.instance_termination_action
            
            max_run_duration {
                nanos                   = var.nanos
                seconds                 = var.seconds
            }
            
            maintenance_interval        = var.maintenance_interval
      }
    }

    /* scheduling {
      preemptible                       = var.preemptible
      automatic_restart                 = var.automatic_restart 
      on_host_maintenance               = var.on_host_maintenance

      node_affinities {
        key                             = var.key_node_affinities
        operator                        = var.operator_node_affinities
        values                          = var.values_node_affinities
      }

      min_node_cpus                     = var.min_node_cpus 
      provisioning_model                = var.provisioning_model 
      instance_termination_action       = var.instance_termination_action

      max_run_duration {
        nanos                           = var.nanos
        seconds                         = var.seconds 
      }
      
    maintenance_interval                = var.maintenance_interval      
  } */

  dynamic "scratch_disk" {
        for_each = var.scratch_disk == false ? toset([]) : toset([1])
        content {
            interface                   = var.interface
    }
  }

  /* scratch_disk {
    interface                           = var.interface
  } */

  service_account {
    email                               = var.email
    scopes                              = var.scopes
  }

  dynamic "shielded_instance_config" {
        for_each = var.shielded_instance_config == false ? toset([]) : toset([1])
        content {
            enable_secure_boot          = var.enable_secure_boot
            enable_vtpm                 = var.enable_vtpm 
            enable_integrity_monitoring = var.enable_integrity_monitoring
    }
  }

  /* shielded_instance_config {
      enable_secure_boot                = var.enable_secure_boot
      enable_vtpm                       = var.enable_vtpm 
      enable_integrity_monitoring       = var.enable_integrity_monitoring 
  } */

  enable_display                        = var.enable_display
  resource_policies                     = var.resource_policies

  dynamic "reservation_affinity" {
        for_each = var.reservation_affinity == false ? toset([]) : toset([1])
        content {
            type                        = var.type_reservation_affinity
            specific_reservation {
                key                     = var.key_specific_reservation
                values                  = var.values_specific_reservation
    }
    }
  }
  
  /* reservation_affinity {
    type                                = var.type_reservation_affinity
    specific_reservation {
        key                             = var.key_specific_reservation
        values                          = var.values_specific_reservation
    }
  } */

  confidential_instance_config {
    enable_confidential_compute         = var.enable_confidential_compute
  }

  dynamic "advanced_machine_features" {
        for_each = var.advanced_machine_features == false ? toset([]) : toset([1])
        content {
            enable_nested_virtualization = var.enable_nested_virtualization
            threads_per_core             = var.threads_per_core
            visible_core_count           = var.visible_core_count
    }
  }

  /* advanced_machine_features {
    enable_nested_virtualization        = var.enable_nested_virtualization
    threads_per_core                    = var.threads_per_core
    visible_core_count                  = var.visible_core_count
  } */

  dynamic "network_performance_config" {
        for_each = var.network_performance_config == false ? toset([]) : toset([1])
        content {
            total_egress_bandwidth_tier = var.total_egress_bandwidth_tier
            }
        }

  /* network_performance_config {
    total_egress_bandwidth_tier         = var.total_egress_bandwidth_tier 
  } */
  
}


  
  
  
  
