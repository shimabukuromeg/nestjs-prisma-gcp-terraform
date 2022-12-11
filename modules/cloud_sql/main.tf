# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance

resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_database_instance" "instance" {
  project          = var.project_id
  name             = "private-instance-${random_id.db_name_suffix.hex}"
  region           = var.region
  database_version = var.db-version

  settings {
    tier = "db-f1-micro"

    ip_configuration {
      ipv4_enabled    = true
      private_network = var.db-network-id
    }
  }
}

resource "google_sql_database" "database" {
  project  = var.project_id
  name     = "my-database"
  instance = google_sql_database_instance.instance.name
}

resource "google_sql_user" "users" {
  project  = var.project_id
  name     = "me"
  instance = google_sql_database_instance.instance.name
  password = random_password.password.result
}

# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password
resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}
