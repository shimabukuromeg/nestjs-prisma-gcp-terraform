provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

# Artifact Registry
module "artifact_registry" {
  source        = "./modules/artifact_registry"
  project_id    = var.project_id
  location      = var.region
  repository_id = "my-repo"
}

module "vpc" {
  source     = "./modules/vpc"
  project_id = var.project_id
  region     = var.region
}

module "cloud_sql" {
  source        = "./modules/cloud_sql"
  project_id    = var.project_id
  region        = var.region
  db-network-id = module.vpc.vpc_id

  depends_on = [
    module.vpc
  ]
}

resource "random_id" "pool_id_suffix" {
  byte_length = 4
}

module "workload_identity" {
  source     = "./modules/workload_identity"
  project_id = var.project_id
  region     = var.region
  pool_id    = "my-pool-${random_id.pool_id_suffix.hex}"
}

module "iam" {
  source     = "./modules/iam"
  project_id = var.project_id
  region     = var.region
  pool_id    = module.workload_identity.workload_identity_provider_pool.name
  repository = var.repository

  depends_on = [
    module.workload_identity
  ]
}

module "cloud_run" {
  source                  = "./modules/cloud_run"
  project_id              = var.project_id
  region                  = var.region
  vpc_access_connector_id = module.vpc.vpc_access_connector_id
  db_connection_name      = module.cloud_sql.db_connection_name
  service_account_name    = module.iam.service_account_name

  depends_on = [
    module.iam
  ]
}
