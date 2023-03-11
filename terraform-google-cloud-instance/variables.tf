variable "project_id" {
  type = string
  description = "The project id for putting the VM"
}

variable "zone" {
  type = string
  description = "The zone that the machine should be created in"
  default = ""
}

variable "name" {
  type = string
  description = "Name of the VM"
}

variable "tags" {
  type = list(string)
  description = "A list of network tags to attach to the instance"
  default = []
}

variable "labels" {
  type = map(string)
  description = "A map of key/value label pairs to assign to the instance"
  default = {}
}

variable "hostname" {
    type = string
    description = "A custom hostname for the instance"
}

variable "metadata" {
  type = map(string)
  description = "Metadata key/value pairs to make available from within the instance"
  default = {}
}

variable "machine_type" {
  type = string
  description = "The machine Type of VM"
}

variable "enable_display" {
    type = bool
    default = false
    description = "Enable/Disable Virtual Displays on the instance"
}

variable "can_ip_forward" {
    type = bool
    default = false
    description = "IP Forward option to be used or not"
}

variable "deletion_protection" {
    type = bool
    default = true
    description = "Enable/Disable deletion protection on the instance"
}

variable "update_properties" {
    type = bool
    default = true
    description = " Allow/Deny Terraform to stop the instance to update its properties"
}

variable "image" {
  type = string
  description = "The image from which to initialize this disk"
  default = "debian-cloud/debian-9"
}

variable "subnet" {
  type = string
  description = "The name or self_link of the subnetwork to attach the interface to"
}

// ........... scheduling_block ............ //

variable "preemptible" {
    type = bool
    default = false
    description = "Specifies if the instance is preemptible"
}
variable "auto_restart" {
    type = bool
    default = false
    description = "Auto restart policy during host maintenance"
}
variable "on_host_maintenance" {
    type = string
    default = "MIGRATE"
    description = "During host maintenance it'll migrate the VM on another host"
}

// ........ shielded_instance_block ......... //

variable "secure_boot" {
    type = bool
    default = false
    description = "Verify the digital signature of all boot components, and halt the boot process if signature verification fails"
}
variable "vtpm" {
    type = bool
    default = false
    description = "Use a virtualized trusted platform module, which is a specialized computer chip you can use to encrypt objects like keys and certificates."
}
variable "integrity_monitoring" {
    type = bool
    default = false
    description = "Compare the most recent boot measurements to the integrity policy baseline and return a pair of pass/fail"
}

// ......... confidential_vm_block ......... //

variable "confidential__mode" {
    type = bool
    default = false
    description = "Defines whether the instance should have confidential compute enabled."
}

variable "service_account_email" {
  type = string
  description = "The service account e-mail address"
  default = ""
}

variable "service_account_scopes" {
  type = list
  description = "A list of service scopes. Both OAuth2 URLs and gcloud short names are supported. To allow full access to all Cloud APIs, use the cloud-platform scope"
  default = []
}
