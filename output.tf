output "vpc-serverless-connector" {
  value       = module.vpc.vpc_access_connector_id
  description = "VPCアクセスコネクターの接続名"
}

output "cloudsql-conn-name" {
  value       = module.cloud_sql.db-connection-name
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
