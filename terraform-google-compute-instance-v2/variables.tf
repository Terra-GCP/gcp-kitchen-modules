variable "source_image" {
  description = "Source disk image. If neither source_image nor source_image_family is specified, defaults to the latest public CentOS image."
  type        = string
  default     = ""
}

variable "source_image_project" {
  description = "Project where the source image comes from. The default project contains CentOS images."
  type        = string
  default     = ""
}

variable "name" {
  type = any
  description = "A unique name for the resource, required by GCE. Changing this forces a new resource to be created"

/* <CloudProvider- (1-2)><Region- (3-4)><APPID- (5-13)><ROLE- (14-16)><ENV- (17-20)><OS - 21><COUNT -(22-23)> */
/* Eg-GEUAPPID001WEBNPRDL01 */
  default = "geuappid001"
  validation {
    condition     = can(regex("^g", var.name))
    error_message = "The name value must start with 'g'."
  }
}

variable "machine_type" {
  type = string
  description = "The machine type to create."
  default = "e2-medium"
}

variable "zone" {
  type = string
  description = "The zone that the machine should be created in. If it is not provided, the provider zone is used."
  default = "europe-north1-a"
}

variable "tags" {
  type = list(string)
  description = "A list of network tags to attach to the instance."
  default = []
}

variable "boot_disk" {
  description = "The boot disk for the instance."
  type = list(object(
    {
        auto_delete                      = bool
        device_name                      = string
        mode                             = string
        disk_encryption_key_raw          = string
        kms_key_self_link                = string
        source                           = string

        initialize_params                = list(object(
            {
                size                     = number
                type                     = string
                image                    = string

                labels                   = object(
                    {
                        app_id           = string 
                        env              = string
                        role             = string
                        cost_center      = string 
                        business_unit    = string
                        project_id       = string
                        service_request1 = string
                        app_type         = string
                    }
                    )
            }
            )
        )
    }
    )
    )
    
    default = [
        {
            auto_delete                  = true
            device_name                  = "disk-1"
            mode                         = "READ_WRITE"
            disk_encryption_key_raw      = null
            kms_key_self_link            = null
            source                       = null
            
            initialize_params            = [
                {
                    size                 = 20
                    type                 = "pd-ssd"
                    image                = "ubuntu-os-cloud/ubuntu-2204-lts"
                    labels               = {
                        app_id           = "1234", 
                        env              = "prod",
                        role             = "webserver",
                        cost_center      = "001",
                        business_unit    ="devops",
                        project_id       = "prj-xxxxx-id",
                        service_request1 = "ritmxxxx",
                        app_type         = "dmz"
                    }
                }
            ]
        }
    ]

    validation {
    condition = length([
      for type in var.boot_disk[*].auto_delete : true if contains([
        true,
        false
      ], type)
    ]) == length(var.boot_disk)
    error_message = "Boot Disk auto delete must be either 'true' or 'false'."
    }

  validation {
    condition = length([
      for type in var.boot_disk[*].mode : true if contains([
        "READ_WRITE",
        "READ_ONLY"
      ], type)
    ]) == length(var.boot_disk)
    error_message = "Boot Disk Mode must be one of 'READ_WRITE' or 'READ_ONLY'."
    }

    validation {
    condition = length([
      for type in var.boot_disk[0].initialize_params[*].type : true if contains([
        "pd-standard",
        "pd-balanced",
        "pd-ssd"
      ], type)
    ]) == length(var.boot_disk)
    error_message = "The Disk type can only be set to 'pd-standard' or 'pd-balanced' or 'pd-ssd'."
    }
}

variable "labels" {
  type = map(any)
  description = "A set of key/value label pairs assigned to the disk. This field is only applicable for persistent disks."
  default = {
    app_id = "1234", 
    env = "prod", 
    os = "rhel-n", 
    role = "webserver", 
    cost_center = "001", 
    business_unit ="devops", 
    project_id = "prj-xxxxx-id", 
    service_request1 = "ritmxxxx", 
    app_type = "dmz"
    }
}

variable "network_interface" {
  description = "Networks to attach to the instance. This can be specified multiple times. "
  type = list(object(
    {
        network                          = string
        subnetwork                       = string    
        subnetwork_project               = string
        network_ip                       = string
        access_config                    = list(object(
            {
                nat_ip                   = string
                public_ptr_domain_name   = string
                network_tier             = string
            }
        )
        )
        alias_ip_range                   = list(object(
            {
                ip_cidr_range            = string
                subnetwork_range_name    = string
            }
        )
        )
        ipv6_access_config               = list(object(
            {
                public_ptr_domain_name   = string
                network_tier             = string
            }
        )
        )
    }
    )
    )

  default = [
    {
        network                          = "default"
        subnetwork                       = ""    
        subnetwork_project               = ""
        network_ip                       = "" 
        access_config                    = [
            /* {
            nat_ip                       = ""
            public_ptr_domain_name       = ""
            network_tier                 = ""
            } */
        ]
        alias_ip_range                   = [
            /* {
            ip_cidr_range                = "10.0.0.0/0"
            subnetwork_range_name        = ""
            } */
        ]
        ipv6_access_config               = [
            /* {
            public_ptr_domain_name       = ""
            network_tier                 = ""
            } */
        ]          
    }
    ]
}

variable "nic_type" {
  type = string
  description = "The type of vNIC to be used on this interface. Possible values: GVNIC, VIRTIO_NET."
  default = "GVNIC"
  validation {
    condition     = can(regex("^(GVNIC|VIRTIO_NET|null)$", var.nic_type))
    error_message = "The nic type can only be set to [GVNIC|VIRTIO_NET]."
  }
}

variable "stack_type" {
  type = string
  description = "The stack type for this network interface to identify whether the IPv6 feature is enabled or not. Values are IPV4_IPV6 or IPV4_ONLY. If not specified, IPV4_ONLY will be used."
  default = "IPV4_ONLY"
  validation {
    condition     = can(regex("^(IPV4_ONLY|IPV4_IPV6|null)$", var.stack_type))
    error_message = "The stack type can only be set to [IPV4_ONLY|IPV4_IPV6]."
  }
}

variable "queue_count" {
  type = number
  description = "The networking queue count that's specified by users for the network interface. Both Rx and Tx queues will be set to this number. It will be empty if not specified."
  default = null
}

variable "allow_stopping_for_update" {
    type = bool
    description = "If true, allows Terraform to stop the instance to update its properties. If you try to update a property that requires stopping the instance without setting this field, the update will fail."
    default = true

    validation {
    condition     = contains([true, false], var.allow_stopping_for_update)
    error_message = "Valid values for var: allow_stopping_for_update are (true, false)."
    } 
}

variable "attached_disk" {
  description = "Additional disks to attach to the instance. Can be repeated multiple times for multiple disks."
  type = list(object({
    source                               = string
    device_name                          = string
    mode                                 = string
    disk_encryption_key_raw              = string
    kms_key_self_link                    = string 
  }))

  default = [
    /* {
        source                           = null
        device_name                      = "disk-1"
        mode                             = "READ_WRITE"
        disk_encryption_key_raw          = null
        kms_key_self_link                = null      
    } */
  ]

  validation {
    condition = length([
      for type in var.attached_disk[*].mode : true if contains([
        "READ_WRITE",
        "READ_ONLY",
            null
      ], type)
    ]) == length(var.attached_disk)
    error_message = "Disk Mode must be one of 'READ_WRITE' or 'READ_ONLY'."
    }
}

variable "can_ip_forward" {
    type = bool
    default = false
    description = "Whether to allow sending and receiving of packets with non-matching source or destination IPs. This defaults to false."

    validation {
    condition     = contains([true, false], var.can_ip_forward)
    error_message = "Valid values for var: can_ip_forward are (true, false)."
    } 
}

variable "description" {
    type = string
    default = ""
    description = "A brief description of this resource."
}

variable "desired_status" {
    type = string
    default = "RUNNING"
    description = "Desired status of the instance. Either RUNNING or TERMINATED."
    
    validation {
    condition     = contains(["RUNNING", "TERMINATED", null], var.desired_status)
    error_message = "Valid values for var: desired_status are (RUNNING, TERMINATED)."
    } 
}

variable "deletion_protection" {
    type = bool
    default = false
    description = "Enable deletion protection on this instance. Defaults to false. Note: you must disable deletion protection before removing the resource"
    validation {
        condition     = contains([true, false], var.deletion_protection)
        error_message = "Valid values for var: deletion_protection are (true, false)."
    } 
}

variable "hostname" {
    type = string
    default = "vm1.example.com"
    description = "A custom hostname for the instance. Must be a fully qualified DNS name and RFC-1035-valid."

    /* <CloudProvider- (1-2)><Region- (3-4)><APPID- (5-13)><ROLE- (14-16)><ENV- (17-20)><OS - 21><COUNT -(22-23)> */
    /* Eg-GEUAPPID001WEBNPRDL01 */
}

variable "guest_accelerator" {
  description = "List of the type and count of accelerator cards attached to the instance."
  type = list(object({
    type                                 = string
    count                                = number
  }))

  default = [
    /* {
        type                             = ""
        count                            = null
    } */
    ]
}

variable "metadata" {
  type = map(string)
  description = "Metadata key/value pairs to make available from within the instance. Ssh keys attached in the Cloud Console will be removed. Add them to your config in order to keep them attached to your instance. A list of default metadata values (e.g. ssh-keys)"
  default = {}
}

variable "metadata_startup_script" {
  type = string
  description = "An alternative to using the startup-script metadata key, except this one forces the instance to be recreated (thus re-running the script) if it is changed"
  default = ""
}

variable "min_cpu_platform" {
  type = string
  description = "Specifies a minimum CPU platform for the VM instance. Applicable values are the friendly names of CPU platforms, such as Intel Haswell or Intel Skylake"
  default = ""
}

variable "project_id" {
  type = string
  description = "The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
  default = "prj-o-tf-sa"
  validation {
      condition = length(var.project_id) >= 6 && length(var.project_id) <=32
      error_message = "The Project ID to be used must be 6 to 30 characters in length."
    }
}

variable "scheduling" {
  description = "The scheduling strategy to use."
  type = list(object({
    preemptible                          = bool 
    on_host_maintenance                  = string
    automatic_restart                    = bool

    node_affinities                      = list(object(
        {
            key                          = string
            operator                     = string
            values                       = list(string)
        }
        )
        )

    min_node_cpus                        = number 
    provisioning_model                   = string 
    instance_termination_action          = string

    max_run_duration                     = list(object(
        {
            nanos                        = number
            seconds                      = number
        }
        )
        )
            
    maintenance_interval                 = string
    }
    )
    )

  default = [
    /* {
        preemptible                      = false 
        on_host_maintenance              = "MIGRATE"
        automatic_restart                = false

        node_affinities                  = [
            {
                key                      = ""
                operator                 = ""
                values                   = [""]
            }
        ]

        min_node_cpus                    = null 
        provisioning_model               = "" 
        instance_termination_action      = ""

        max_run_duration                 = [
            {
                nanos                    = null
                seconds                  = null
            }
        ]
            
        maintenance_interval             = ""
    } */
    ]
    
    validation {
    condition = length([
      for type in var.scheduling[*].preemptible : true if contains([
        true,
        false
      ], type)
    ]) == length(var.scheduling)
    error_message = "Preemptible must be set to 'true' or 'false'."
    }
    validation {
    condition = length([
      for type in var.scheduling[*].automatic_restart : true if contains([
        true,
        false
      ], type)
    ]) == length(var.scheduling)
    error_message = "Preemptible must be set to 'true' or 'false'."
    }
    validation {
    condition = length([
      for type in var.scheduling[*].provisioning_model : true if contains([
        "STOP",
        "DELETE",
      ], type)
    ]) == length(var.scheduling)
    error_message = "instance_termination_action must be set to 'STOP' or 'DELETE'."
    }
    validation {
    condition = length([
      for type in var.scheduling[*].instance_termination_action : true if contains([
        "STANDARD",
        "SPOT",
      ], type)
    ]) == length(var.scheduling)
    error_message = "Instance Termination Action must be set to 'STANDARD' or 'SPOT'."
    }
}

variable "scratch_disk" {
  description = "Scratch disks to attach to the instance. This can be specified multiple times for multiple scratch disks."
  type = list(object(
    {
    interface                            = string
    }
    )
    )

  default = [
    /* {
        interface                        = null
    } */
  ]
  validation {
    condition = length([
      for type in var.scratch_disk[*].interface : true if contains([
        "SCSI",
        "NVME",
        "null"
      ], type)
    ]) == length(var.scratch_disk)
    error_message = "The scratch disk interface can only be set to SCSI or NVME."
    }
}

variable "service_account" {
  description = "Service account to attach to the instance."
  type = list(object(
    {
        email                            = string
        scopes                           = list(string)
    }
    )
    )

  default = [
    /* {
        email                            = ""
        scopes                           = ["compute-rw", "storage-rw"]
    } */
    ]
}

variable "shielded_instance_config" {
  description = "Enable Shielded VM on this instance. Shielded VM provides verifiable integrity to prevent against malware and rootkits. Defaults to disabled."
  type = list(object(
    {
        enable_secure_boot               = bool
        enable_vtpm                      = bool 
        enable_integrity_monitoring      = bool
    }
    )
    )

  default = [
    /* {
        enable_secure_boot               = false
        enable_vtpm                      = false
        enable_integrity_monitoring      = false
    } */
    ]
    validation {
    condition = length([
      for type in var.shielded_instance_config[*].enable_secure_boot : true if contains([
        true,
        false
      ], type)
    ]) == length(var.shielded_instance_config)
    error_message = "Enable Secure Boot must be set to 'true' or 'false'."
    }
    validation {
    condition = length([
      for type in var.shielded_instance_config[*].enable_vtpm : true if contains([
        true,
        false
      ], type)
    ]) == length(var.shielded_instance_config)
    error_message = "Enable vTPM must be set to 'true' or 'false'."
    }
    validation {
    condition = length([
      for type in var.shielded_instance_config[*].enable_integrity_monitoring : true if contains([
        true,
        false
      ], type)
    ]) == length(var.shielded_instance_config)
    error_message = "Enable Integrity Monitoring must be set to 'true' or 'false'."
    }
}

variable "enable_display" {
    type = bool
    default = false
    description = "Enable Virtual Displays on this instance. Note: allow_stopping_for_update must be set to true or your instance must have a desired_status of TERMINATED in order to update this field."
    validation {
        condition     = contains([true, false], var.enable_display)
        error_message = "Valid values for var: enable_display are (true, false)."
    } 
}


variable "resource_policies" {
    type = list(string)
    default = [""]
    description = "A list of self_links of resource policies to attach to the instance. Modifying this list will cause the instance to recreate. Currently a max of 1 resource policy is supported."
}

variable "reservation_affinity" {
  description = "Specifies the reservations that this instance can consume from."
  type = list(object(
    {
        type                             = string
        specific_reservation             = list(object(
            {
                key                      = string
                values                   = list(string)
            }
            )
            )
    }
    )
    )

  default = [
    /* {
        type                             = ""
        specific_reservation             = [
            {
                key                      = ""
                values                   = [""]
            }
        ]
    } */
    ]
}

variable "confidential_instance_config" {
  description = "Enable Confidential Mode on this VM."
  type = list(object(
    {
        enable_confidential_compute      = bool
    }
    )
    )

  default = [
    /* {
        enable_confidential_compute      = false
    } */
    ]
}

variable "advanced_machine_features" {
  description = "Configure Nested Virtualisation and Simultaneous Hyper Threading on this VM."
  type = list(object(
    {
        enable_nested_virtualization     = bool
        threads_per_core                 = number
        visible_core_count               = number
    }
    )
    )

  default = [
    /* {
        enable_nested_virtualization     = false
        threads_per_core                 = null
        visible_core_count               = null
    } */
    ]
}

variable "network_performance_config" {
  description = "Configures network performance settings for the instance."
  type = list(object(
    {
        total_egress_bandwidth_tier      = string
    }
    )
    )

  default = [
    /* {
        total_egress_bandwidth_tier     = ""
    } */
    ]
    validation {
    condition = length([
      for type in var.network_performance_config[*].total_egress_bandwidth_tier : true if contains([
        "TIER_1", 
        "DEFAULT"
      ], type)
    ]) == length(var.network_performance_config)
    error_message = "Total Egress Bandwidth tier for network performance config must be set to 'TIER_1' or 'DEFAULT'."
    }
}
