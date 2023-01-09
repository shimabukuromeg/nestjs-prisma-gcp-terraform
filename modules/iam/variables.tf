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

variable "pool_id" {
  description = "プールID"
  type        = string
}

variable "repository" {
  description = "OIDC による認証を行うことのできるリポジトリ"
  type        = string
}
