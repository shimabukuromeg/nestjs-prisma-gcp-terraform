# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository
resource "google_artifact_registry_repository" "my-repo" {
  project       = var.project_id
  location      = var.location
  repository_id = "${var.repository_id}-${random_id.repository_id_suffix.hex}"
  description   = "example docker repository"
  format        = "DOCKER"
}

resource "random_id" "repository_id_suffix" {
  byte_length = 4
}
