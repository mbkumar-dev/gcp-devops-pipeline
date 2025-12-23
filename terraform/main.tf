resource "google_artifact_registry_repository" "repo" {
  location      = var.region
  repository_id = "docker-repo"
  format        = "DOCKER"
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