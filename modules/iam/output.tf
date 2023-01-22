output "cloud_run_sa_service_account_name" {
  value       = google_service_account.cloud_run_sa.email
  description = "実行用 Service Account 名"
}

output "github_actions_sa_service_account_name" {
  value       = google_service_account.github_actions_sa.email
  description = "GithubActions 連携用 Service Account 名"
}
