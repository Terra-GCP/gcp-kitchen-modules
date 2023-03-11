# Top-level folder under an organization.

resource "google_folder" "folder" {
  display_name = var.folder_name
  parent       = var.parent
}