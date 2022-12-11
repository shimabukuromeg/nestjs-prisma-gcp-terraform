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
