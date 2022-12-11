output "vpc_id" {
  value       = google_compute_network.peering_network.id
  description = "VPCネットワークID"
}

output "subnet_id" {
  value       = google_compute_subnetwork.custom_test.id
  description = "サブネットID"
}

output "vpc_access_connector_id" {
  value       = google_vpc_access_connector.connector.id
  description = "VPCアクセスコネクターの接続ID"
}
