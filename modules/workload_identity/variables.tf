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
  type = string
}

variable "provider_id" {
  default = "github"
}
