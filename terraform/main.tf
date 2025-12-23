resource "google_artifact_registry_repository" "repo" {
  location      = var.region
  repository_id = "docker-repo"
  format        = "DOCKER"
}

resource "google_cloud_run_service" "app" {
  name     = "devops-app"
  location = var.region

  template {
    spec {
      containers {
        image = "us-central1-docker.pkg.dev/${var.project_id}/docker-repo/app:latest"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service_iam_member" "public" {
  service  = google_cloud_run_service.app.name
  location = var.region
  role     = "roles/run.invoker"
  member   = "allUsers"
}
