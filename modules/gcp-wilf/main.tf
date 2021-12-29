resource "google_iam_workload_identity_pool" "gh_pool_3" {
  project                   = var.project_id
  provider                  = google-beta
  workload_identity_pool_id = var.wilf_id
}

resource "google_iam_workload_identity_pool_provider" "provider" {
  provider                           = google-beta
  project                            = var.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.gh_pool_3.workload_identity_pool_id
  workload_identity_pool_provider_id = var.wilf_provider_id
  attribute_mapping                  = {
    "google.subject" = "assertion.sub",
    "attribute.actor" = "assertion.actor",
    "attribute.repository" = "assertion.repository"
  }
  oidc {
    issuer_uri        = "https://token.actions.githubusercontent.com"
  }
}