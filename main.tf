terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  project = "gcpproject-324922"
  region  = "us-central1"
  zone    = "us-central1-c"
}

# Deploy image to Cloud Run
resource "google_cloud_run_service" "mywebapp1" {
  name     = "mywebapp1"
  location = "us-central1"
  template {
    spec {
      containers {
        image = "gcr.io/cloudrun/hello"
      }
    }
  }
  traffic {
    percent         = 100
    latest_revision = true
  }
}
# Create public access
data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}
# Enable public access on Cloud Run service
resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.mywebapp1.location
  project     = google_cloud_run_service.mywebapp1.project
  service     = google_cloud_run_service.mywebapp1.name
  policy_data = data.google_iam_policy.noauth.policy_data
}
# Return service URL
output "url" {
  value = "${google_cloud_run_service.mywebapp1.status[0].url}"
}
