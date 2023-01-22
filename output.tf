output "vpc-serverless-connector" {
  value       = module.vpc.vpc_access_connector_id
  description = "VPCアクセスコネクターの接続名"
}

output "cloudsql-conn-name" {
  value       = module.cloud_sql.db_connection_name
  description = "CloudSQL接続名"
}

output "cloudsql-private-ip" {
  value       = module.cloud_sql.db-private-ip
  description = "CloudSQLのIPアドレス"
}

output "db-user" {
  value       = module.cloud_sql.db-user
  description = "DBユーザー名とパスワード"
  sensitive   = true
}

output "cloud_run_sa_service_account_name" {
  value       = module.iam.cloud_run_sa_service_account_name
  description = "実行用 Service Account 名"
}

output "github_actions_sa_service_account_name" {
  value       = module.iam.github_actions_sa_service_account_name
  description = "GithubActions 連携用 Service Account 名"
}

output "workload_identity_provider_pool" {
  value       = module.workload_identity.workload_identity_provider_pool
  description = "Workload Identity プール"
}

output "workload_identity_provider_github" {
  value       = module.workload_identity.workload_identity_provider_github
  description = "Workload Identity プロバイダー"
}
