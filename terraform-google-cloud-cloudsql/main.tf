resource "google_compute_network" "private_network" {
  provider = google-beta

  name = var.private-network
}

resource "google_compute_global_address" "private_ip_address" {
  provider = google-beta

  name          = var.private-ip-address
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 24
  network       = google_compute_network.private_network.id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  provider = google-beta

  network                 = google_compute_network.private_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

resource "random_id" "db_name_suffix" {
  byte_length = 4
}


resource "google_sql_database_instance" "postgress_db_instance" {
  provider = google-beta
  name             = var.private_instance_name-${random_id.db_name_suffix.hex}
  database_version = var.db_version
  project          = var.project_id
  region           = var.region
  labels           = var.labels
   /*
  MYSQL_5_6, MYSQL_5_7, MYSQL_8_0, POSTGRES_9_6,POSTGRES_10, POSTGRES_11, POSTGRES_12, POSTGRES_13, POSTGRES_14, SQLSERVER_2017_STANDARD, SQLSERVER_2017_ENTERPRISE, SQLSERVER_2017_EXPRESS, SQLSERVER_2017_WEB. SQLSERVER_2019_STANDARD, SQLSERVER_2019_ENTERPRISE, SQLSERVER_2019_EXPRESS, SQLSERVER_2019_WEB
  */
  deletion_protection=false
  depends_on = [google_service_networking_connection.private_vpc_connection]
  settings {
    tier = var.tier
    ip_configuration {
      ipv4_enabled                                  = var.ipv4_enabled
      private_network                               = google_compute_network.private_network.id
      enable_private_path_for_google_cloud_services = true
    }
}
