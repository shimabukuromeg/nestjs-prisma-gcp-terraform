# Variables

variable "project_id" {
  description = "プロジェクトID"
  type        = string
}

variable "location" {
  description = "ロケーション"
  default     = "asia-northeast1"
  type        = string
}

variable "repository_id" {
  description = "リポジトリID"
  type        = string
}
