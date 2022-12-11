# Variables

variable "project_id" {
  description = "プロジェクトID"
  type        = string
}

variable "region" {
  description = "リージョン"
  default     = "asia-northeast1"
  type        = string
}

variable "db-version" {
  default     = "POSTGRES_14"
  description = "Cloud SQL for PostgreSQLのバージョン"
}

variable "db-network-id" {
  type        = string
  description = "Cloud SQL for PostgreSQLのインスタンスに許可する`google_compute_network.id`"
}
