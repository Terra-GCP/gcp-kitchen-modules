variable "name" {
  type = string
  description = "A unique name for the resource, required by GCE. Changing this forces a new resource to be created"

/* <CloudProvider- (1-2)><Region- (3-4)><APPID- (5-13)><ROLE- (14-16)><ENV- (17-20)><OS - 21><COUNT -(22-23)> */
/* Eg-GEUAPPID001WEBNPRDL01 */

  default = "vm1"
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

variable "auto_delete_boot_disk" {
  type = bool
  description = "Whether the disk will be auto-deleted when the instance is deleted. Defaults to true."
  default = true
}

variable "device_name_boot_disk" {
  type = string
  description = "Name with which attached disk will be accessible. On the instance, this device will be /dev/disk/by-id/google-{{device_name}}"
  default = ""
}

variable "mode_boot_disk" {
  type = string
  description = "The mode in which to attach this disk, either READ_WRITE or READ_ONLY. If not specified, the default is to attach the disk in READ_WRITE mode."
  default = "READ_WRITE"
}

variable "disk_encryption_key_raw_boot_disk" {
  type = string
  description = "A 256-bit [customer-supplied encryption key] (https://cloud.google.com/compute/docs/disks/customer-supplied-encryption), encoded in RFC 4648 base64 to encrypt this disk. Only one of kms_key_self_link and disk_encryption_key_raw may be set."
  default = null
}

variable "kms_key_self_link_boot_disk" {
  type = string
  description = "The self_link of the encryption key that is stored in Google Cloud KMS to encrypt this disk. Only one of kms_key_self_link and disk_encryption_key_raw may be set."
  default = null
}

variable "source_boot_disk" {
  type = string
  description = "The name or self_link of the existing disk (such as those managed by google_compute_disk) or disk image."
  default = ""
}

variable "size_boot_disk" {
  type = number
  description = "The size of the image in gigabytes. If not specified, it will inherit the size of its base image."
  default = 50
}

variable "type_boot_disk" {
  type = string
  description = "The GCE disk type. Such as pd-standard, pd-balanced or pd-ssd."
  default = "pd-ssd"
}

variable "image_boot_disk" {
  type = string
  description = "The image from which to initialize this disk"
  default = "ubuntu-os-cloud/ubuntu-2204-lts"
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

variable "network" {
  type = string
  description = "The name or self_link of the network to attach this interface to. Either network or subnetwork must be provided. If network isn't provided it will be inferred from the subnetwork."
  default = "default"
  # vpc name or self_link of the vpc #
}

variable "subnetwork" {
  type = string
  description = "The name or self_link of the subnetwork to attach this interface to. Either network or subnetwork must be provided."
  default = ""
  # subnetwork name or self_link of the vpc #
}

variable "subnetwork_project" {
  type = string
  description = "The project in which the subnetwork belongs."
  default = ""
}

variable "network_ip" {
  type = string
  description = "The private IP address to assign to the instance. If empty, the address will be automatically assigned."
  default = ""
  # 10.x.x.x/32 #
}

variable "access_config" {
  type = bool
  description = "Enable/Disable Access Config Block"
  default = false
}

variable "nat_ip" {
  type = string
  description = "The IP address that will be 1:1 mapped to the instance's network ip. If not given, one will be generated."
  default = ""
  # 34.x.x.x/32 #
}

variable "public_ptr_domain_name" {
  type = string
  description = "The DNS domain name for the public PTR record. To set this field on an instance, you must be verified as the owner of the domain."
  default = ""
}

variable "network_tier" {
  type = string
  description = "The networking tier used for configuring this instance. This field can take the following values: PREMIUM, FIXED_STANDARD or STANDARD."
  default = "STANDARD"
}

variable "alias_ip_range" {
  type = bool
  description = "Enable/Disable Alias IP Range Block"
  default = false
}

variable "ip_cidr_range" {
  type = string
  description = "The IP CIDR range represented by this alias IP range. This IP CIDR range must belong to the specified subnetwork and cannot contain IP addresses reserved by system or used by other network interfaces. This range may be a single IP address (e.g. 10.2.3.4), a netmask (e.g. /24) or a CIDR format string (e.g. 10.1.2.0/24)."
  default = "10.0.0.0/0"
}

variable "subnetwork_range_name" {
  type = string
  description = "The subnetwork secondary range name specifying the secondary range from which to allocate the IP CIDR range for this alias IP range. If left unspecified, the primary range of the subnetwork will be used."
  default = ""
}

variable "nic_type" {
  type = string
  description = "The type of vNIC to be used on this interface. Possible values: GVNIC, VIRTIO_NET."
  default = "GVNIC"
}

variable "stack_type" {
  type = string
  description = "The stack type for this network interface to identify whether the IPv6 feature is enabled or not. Values are IPV4_IPV6 or IPV4_ONLY. If not specified, IPV4_ONLY will be used."
  default = ""
}

variable "ipv6_access_config" {
  type = bool
  description = "Enable/Disable IPV6 Access Config Block"
  default = false
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
}

variable "attached_disk" {
  type = bool
  description = "Enable/Disable Attach Disk Block"
  default = false
}

variable "source_data_disk" {
    type = string
    description = "The name or self_link of the disk to attach to this instance."
    default = ""
}

variable "device_name_data_disk" {
    type = string
    description = "Name with which the attached disk will be accessible under /dev/disk/by-id/google-*"
    default = ""
}

variable "mode_data_disk" {
  type = string
  description = "The mode in which to attach this disk, either READ_WRITE or READ_ONLY. If not specified, the default is to attach the disk in READ_WRITE mode."
  default = "READ_WRITE"
}

variable "disk_encryption_key_raw_data_disk" {
  type = string
  description = "A 256-bit [customer-supplied encryption key] (https://cloud.google.com/compute/docs/disks/customer-supplied-encryption), encoded in RFC 4648 base64 to encrypt this disk. Only one of kms_key_self_link and disk_encryption_key_raw may be set."
  default = ""
}

variable "kms_key_self_link_data_disk" {
  type = string
  description = "The self_link of the encryption key that is stored in Google Cloud KMS to encrypt this disk. Only one of kms_key_self_link and disk_encryption_key_raw may be set."
  default = ""
}

variable "can_ip_forward" {
    type = bool
    default = false
    description = "Whether to allow sending and receiving of packets with non-matching source or destination IPs. This defaults to false."
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
}

variable "deletion_protection" {
    type = bool
    default = true
    description = "Enable deletion protection on this instance. Defaults to false. Note: you must disable deletion protection before removing the resource"
}

variable "hostname" {
    type = string
    default = "vm1.example.com"
    description = "A custom hostname for the instance. Must be a fully qualified DNS name and RFC-1035-valid."

    /* <CloudProvider- (1-2)><Region- (3-4)><APPID- (5-13)><ROLE- (14-16)><ENV- (17-20)><OS - 21><COUNT -(22-23)> */
    /* Eg-GEUAPPID001WEBNPRDL01 */
}

variable "guest_accelerator" {
  type = bool
  description = "Enable/Disable guest accelerator Block"
  default = false
}

variable "type_gpu" {
    type = string
    default = "null"
    description = "The accelerator type resource to expose to this instance. E.g. nvidia-tesla-k80."
}

variable "count_gpu" {
    type = number
    default = null
    description = "The number of the guest accelerator cards exposed to this instance."
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
}

variable "scheduling" {
  type = bool
  description = "Enable/Disable Scheduling Block"
  default = false
}

variable "preemptible" {
    type = bool
    default = false
    description = "Specifies if the instance is preemptible. If this field is set to true, then automatic_restart must be set to false. Defaults to false."
}

variable "automatic_restart" {
    type = bool
    default = false
    description = "Specifies if the instance should be restarted if it was terminated by Compute Engine (not a user). Defaults to true."
}

variable "on_host_maintenance" {
    type = string
    default = "MIGRATE"
    description = "Describes maintenance behavior for the instance. Can be MIGRATE or TERMINATE"
}

variable "key_node_affinities" {
    type = string
    default = ""
    description = "The key for the node affinity label."
}

variable "operator_node_affinities" {
    type = string
    default = ""
    description = "The operator. Can be IN for node-affinities or NOT_IN for anti-affinities."
}

variable "values_node_affinities" {
    type = list(string)
    default = [""]
    description = "The values for the node affinity label."
}

variable "min_node_cpus" {
    type = number
    default = null
    description = "The minimum number of virtual CPUs this instance will consume when running on a sole-tenant node."
}

variable "provisioning_model" {
    type = string
    default = ""
    description = "Describe the type of preemptible VM. This field accepts the value STANDARD or SPOT. If the value is STANDARD, there will be no discount. If this is set to SPOT, preemptible should be true and auto_restart should be false"
}

variable "instance_termination_action" {
    type = string
    default = ""
    description = "Describe the type of termination action for VM. Can be STOP or DELETE."
}

variable "nanos" {
    type = number
    default = null
    description = "Span of time that's a fraction of a second at nanosecond resolution. Durations less than one second are represented with a 0 seconds field and a positive nanos field. Must be from 0 to 999,999,999 inclusive."
}

variable "seconds" {
    type = number
    default = null
    description = "Span of time at a resolution of a second. Must be from 0 to 315,576,000,000 inclusive. Note: these bounds are computed from: 60 sec/min * 60 min/hr * 24 hr/day * 365.25 days/year * 10000 years."
}

variable "maintenance_interval" {
    type = string
    default = ""
    description = "Specifies the frequency of planned maintenance events. The accepted values are: PERIODIC."
}

variable "scratch_disk" {
  type = bool
  description = "Enable/Disable Scratch Disk Block"
  default = false
}

variable "interface" {
    type = string
    default = ""
    description = "The disk interface to use for attaching this disk; either SCSI or NVME."
}

variable "email" {
    type = string
    default = ""
    description = "The service account e-mail address. If not given, the default Google Compute Engine service account is used. "
}

variable "scopes" {
    type = list(string)
    default = ["compute-rw", "storage-rw"]
    description = "A list of service scopes. Both OAuth2 URLs and gcloud short names are supported. To allow full access to all Cloud APIs, use the cloud-platform scope."
}

variable "shielded_instance_config" {
  type = bool
  description = "Enable/Disable Shielded Instance Config Block"
  default = false
}

variable "enable_secure_boot" {
    type = bool
    default = false
    description = "Verify the digital signature of all boot components, and halt the boot process if signature verification fails. Defaults to false."
}

variable "enable_vtpm" {
    type = bool
    default = false
    description = "Use a virtualized trusted platform module, which is a specialized computer chip you can use to encrypt objects like keys and certificates. Defaults to true."
}

variable "enable_integrity_monitoring" {
    type = bool
    default = false
    description = "ompare the most recent boot measurements to the integrity policy baseline and return a pair of pass/fail results depending on whether they match or not. Defaults to true."
}

variable "enable_display" {
    type = bool
    default = false
    description = "Enable Virtual Displays on this instance. Note: allow_stopping_for_update must be set to true or your instance must have a desired_status of TERMINATED in order to update this field."
}

variable "resource_policies" {
    type = list(string)
    default = [""]
    description = "A list of self_links of resource policies to attach to the instance. Modifying this list will cause the instance to recreate. Currently a max of 1 resource policy is supported."
}

variable "reservation_affinity" {
  type = bool
  description = "Enable/Disable Reservation Affinity Block"
  default = false
}

variable "type_reservation_affinity" {
    type = string
    default = ""
    description = "The type of reservation from which this instance can consume resources."
}

variable "key_specific_reservation" {
    type = string
    default = ""
    description = "Corresponds to the label key of a reservation resource. To target a SPECIFIC_RESERVATION by name, specify compute.googleapis.com/reservation-name as the key and specify the name of your reservation as the only value."
}

variable "values_specific_reservation" {
    type = list(string)
    default = [""]
    description = "Corresponds to the label values of a reservation resource."
}

variable "enable_confidential_compute" {
    type = bool
    default = false
    description = "Defines whether the instance should have confidential compute enabled. on_host_maintenance has to be set to TERMINATE or this will fail to create the VM."
}

variable "advanced_machine_features" {
  type = bool
  description = "Enable/Disable Advanced Machine Features Block"
  default = false
}

variable "enable_nested_virtualization" {
    type = bool
    default = false
    description = "Defines whether the instance should have nested virtualization enabled. Defaults to false."
}

variable "threads_per_core" {
    type = number
    default = null
    description = "The number of threads per physical core. To disable simultaneous multithreading (SMT) set this to 1."
}

variable "visible_core_count" {
    type = number
    default = null
    description = "The number of physical cores to expose to an instance. visible cores info (VC)."
}

variable "network_performance_config" {
  type = bool
  description = "Enable/Disable Network Performance Config Block"
  default = false
}

variable "total_egress_bandwidth_tier" {
    type = string
    default = ""
    description = "The egress bandwidth tier to enable. Possible values: TIER_1, DEFAULT"
}
