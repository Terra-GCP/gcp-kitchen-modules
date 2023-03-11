resource "google_compute_instance" "default" {
  project                   = var.project_id
  zone                      = var.zone
  name                      = var.name
  tags                      = var.tags
  labels                    = var.labels
  hostname                  = var.hostname
  metadata                  = var.metadata
  machine_type              = var.machine_type
  enable_display            = var.enable_display
  can_ip_forward            = var.can_ip_forward
  deletion_protection       = var.deletion_protection
  allow_stopping_for_update = var.update_properties
  
  boot_disk {
    initialize_params {
      image = var.image
    }
  }
  network_interface {
    subnetwork = var.subnet
  }

  scheduling {
      preemptible = var.preemptible
      automatic_restart   = var.auto_restart
      on_host_maintenance = var.on_host_maintenance
  }
  shielded_instance_config {
      enable_secure_boot = var.secure_boot
      enable_vtpm = var.vtpm
      enable_integrity_monitoring = var.integrity_monitoring 
  }
  confidential_instance_config {
    enable_confidential_compute = var.confidential__mode
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = var.service_account_email
    scopes = var.service_account_scopes
  }
}
