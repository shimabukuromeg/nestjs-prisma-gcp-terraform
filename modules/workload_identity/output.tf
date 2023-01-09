output "workload_identity_provider_pool" {
  value = {
    id   = google_iam_workload_identity_pool.pool.id,
    name = google_iam_workload_identity_pool.pool.name,
  }
}

output "workload_identity_provider_github" {
  value = {
    id   = google_iam_workload_identity_pool_provider.github.id,
    name = google_iam_workload_identity_pool_provider.github.name,
  }
}
