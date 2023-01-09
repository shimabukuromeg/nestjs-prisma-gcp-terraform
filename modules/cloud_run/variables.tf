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

variable "vpc_access_connector_id" {
  type        = string
  description = "VPCコネクター名"
}

variable "db_connection_name" {
  type        = string
  description = "CloudSQLコネクター名"
  default     = null
}

variable "service_account_name" {
  type        = string
  description = "サービスアカウント名"
}
