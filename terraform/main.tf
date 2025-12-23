resource "google_artifact_registry_repository" "repo" {
  project       = "regal-stone-481911-e6"
  location      = "us-central1"
  repository_id = "docker-repo"             # <-- REQUIRED
  format        = "DOCKER"
  description   = "Docker repo for Cloud Run"  # optional
}

resource "google_cloud_run_v2_service" "app" {
  name     = "devops-app"
  location = var.region

  template {
    containers {
      image = "us-central1-docker.pkg.dev/${var.project_id}/docker-repo/app:latest"
    }
  }
}

resource "google_cloud_run_v2_service_iam_member" "public" {
  name     = google_cloud_run_v2_service.app.name
  location = var.region
  role     = "roles/run.invoker"
  member   = "allUsers"
}