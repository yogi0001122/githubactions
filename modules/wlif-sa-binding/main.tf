locals {
  sa_bindings = merge([
    for sca_id in var.sa_id:
      { for repo in var.gh_repo:
        "${sca_id}-${repo}" => {sca_id = sca_id, repo = repo }
      }
  ]...)
}

resource "google_service_account" "runner_sa" {
  project      = var.project_id
  for_each     = toset(var.sa_id)
  account_id   = each.value
  display_name = "Service Account"
}

data "google_project" "project" {
  project_id = var.project_id
}

# Add bindings for relevant repositories
resource "google_service_account_iam_member" "github_repo_binding" {
  depends_on          = ["google_service_account.runner_sa"]
  for_each = local.sa_bindings
  provider           = google-beta
  service_account_id = "projects/${var.project_id}/serviceAccounts/${each.value.sca_id}@${var.project_id}.iam.gserviceaccount.com"
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/projects/${data.google_project.project.number}/locations/global/workloadIdentityPools/${var.poolid}/attribute.repository/${each.value.repo}"
}

