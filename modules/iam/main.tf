######################
## デプロイ用SA
######################

# デプロイ用 Service Account を作成する
resource "google_service_account" "github_actions_sa" {
  account_id   = "deploy"
  display_name = "GitHubActions"
  project      = var.project_id
}

# デプロイ用 Service Accountに必要な任意のロールを付与しておく
resource "google_project_iam_member" "github_actions_cloudrun_roles" {
  for_each = {
    // docker push
    "roles/artifactregistry.writer" = var.project_id,
    // gcloud run deploy
    "roles/run.admin"              = var.project_id,
    "roles/iam.serviceAccountUser" = var.project_id,
  }
  project = each.value
  role    = each.key
  member  = "serviceAccount:${google_service_account.github_actions_sa.email}"
}

# Workload Identity プールからデプロイ用サービスアカウントのアクセス権を借用できるようにする
resource "google_service_account_iam_member" "binding" {
  service_account_id = google_service_account.github_actions_sa.id
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${var.pool_id}/attribute.repository/${var.repository}"
}

######################
## 実行用SA
######################

# 実行用 Service Account を作成する
resource "google_service_account" "cloud_run_sa" {
  account_id   = "cloud-run"
  display_name = "cloud run"
  project      = var.project_id
}

# 実行用 Service Accountに必要な任意のロールを付与しておく
resource "google_project_iam_member" "cloud_run_sa_roles" {
  for_each = toset([
    // CloudSQL
    "roles/cloudsql.client",
    // SecretManager
    "roles/secretmanager.secretAccessor"
  ])
  project = var.project_id
  role    = each.key
  member  = "serviceAccount:${google_service_account.cloud_run_sa.email}"
}
