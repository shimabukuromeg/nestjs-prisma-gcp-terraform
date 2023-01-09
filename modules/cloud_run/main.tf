# Cloud Runのリソース作成
resource "google_cloud_run_service" "api" {
  name     = "api"
  location = var.region
  project  = var.project_id

  template {
    spec {
      containers {
        image = "gcr.io/cloudrun/hello"
        ports {
          container_port = 3000
          name           = "http1"
        }
      }
      service_account_name = var.service_account_name
    }

    metadata {
      annotations = {
        "run.googleapis.com/vpc-access-connector" = var.vpc_access_connector_id
        "run.googleapis.com/vpc-access-egress"    = "private-ranges-only"
        "run.googleapis.com/cloudsql-instances"   = var.db_connection_name
      }
    }
  }

  autogenerate_revision_name = true

  traffic {
    percent         = 100
    latest_revision = true
  }

  lifecycle {
    // サービスのみ定義
    ignore_changes = [
      template[0].spec[0].containers[0].image,
      template[0].spec[0].containers[0].env,
      traffic,

      template[0].metadata[0].annotations["run.googleapis.com/client-version"],
      template[0].metadata[0].annotations["client.knative.dev/user-image"],
      template[0].metadata[0].annotations["run.googleapis.com/client-name"],
      template[0].metadata[0].annotations["run.googleapis.com/sandbox"],

      template[0].metadata[0].annotations["autoscaling.knative.dev/maxScale"],
      template[0].metadata[0].annotations["autoscaling.knative.dev/minScale"],
      template[0].metadata[0].annotations["run.googleapis.com/cloudsql-instances"],
    ]
  }
}

# Publicからのアクセスを許可
resource "google_cloud_run_service_iam_member" "public_access" {
  provider = google-beta
  service  = google_cloud_run_service.api.name
  location = google_cloud_run_service.api.location
  project  = google_cloud_run_service.api.project
  role     = "roles/run.invoker"
  member   = "allUsers"
}
