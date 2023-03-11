resource "google_storage_bucket" "bucket" {
  name                      = var.bucket_name
  project                   = var.project_id
  location                  = var.gcs_location
  force_destroy             = var.force_destroy
  storage_class             = var.storage_class
  labels                    = var.labels
  public_access_prevention  = var.public_access_prevention
  versioning {
    enabled = var.enable_versioning
  }
}
