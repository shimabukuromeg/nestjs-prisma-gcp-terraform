output "service_account_name" {
  value       = google_service_account.cloud_run_sa.email
  description = "実行用 Service Account 名"
}
