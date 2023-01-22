// APIの有効化対象をすべて記述する
// https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_service
locals {
  services = toset([
    "run.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "sqladmin.googleapis.com",
    "sql-component.googleapis.com",
    "servicenetworking.googleapis.com",
    "vpcaccess.googleapis.com",
    "iamcredentials.googleapis.com",
    "artifactregistry.googleapis.com",
    "compute.googleapis.com",
    "secretmanager.googleapis.com",
  ])
}

resource "google_project_service" "service" {
  for_each = local.services
  project  = var.project_id
  service  = each.value

  disable_dependent_services = true
}
