# サーバーレス VPC アクセス
# https://cloud.google.com/vpc/docs/serverless-vpc-access?hl=ja
resource "google_vpc_access_connector" "connector" {
  provider = google-beta
  project  = var.project_id
  region   = var.region
  name     = "vpc-con"
  subnet {
    name = google_compute_subnetwork.custom_test.name
  }
  machine_type = "e2-micro"

  depends_on = [
    google_compute_subnetwork.custom_test,
  ]
}

# サブネット
resource "google_compute_subnetwork" "custom_test" {
  name          = "vpc-con"
  ip_cidr_range = "10.2.0.0/28"
  region        = var.region
  network       = google_compute_network.peering_network.id

  depends_on = [
    google_compute_network.peering_network,
  ]
}

# VPC
resource "google_compute_network" "peering_network" {
  name                    = "vpc-con"
  auto_create_subnetworks = false
}

# Create an IP address
resource "google_compute_global_address" "private_ip_alloc" {
  provider = google-beta
  project  = var.project_id

  name          = "private-ip-alloc"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.peering_network.id

  depends_on = [
    google_compute_network.peering_network,
  ]
}

# Create a private connection
resource "google_service_networking_connection" "default" {
  network                 = google_compute_network.peering_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_alloc.name]

  depends_on = [
    google_compute_network.peering_network,
  ]
}
