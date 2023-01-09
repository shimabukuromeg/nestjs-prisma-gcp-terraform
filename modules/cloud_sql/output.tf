output "db_connection_name" {
  value       = google_sql_database_instance.instance.connection_name
  description = "Cloud SQLの接続名"
}

output "db-id" {
  value       = google_sql_database_instance.instance.id
  description = "Cloud SQLのインスタンスID"
}

output "db-private-ip" {
  value       = google_sql_database_instance.instance.private_ip_address
  description = "Cloud SQLのPrivate IPアドレス"
}

output "db-user" {
  value = {
    "username" : google_sql_user.users.name,
    "password" : google_sql_user.users.password,
  }

  description = "Cloud SQLのユーザー名とパスワード"
}

