# Artifact Registry Docker repository
resource "google_artifact_registry_repository" "repo" {
  repository_id = "docker-repo"
  location      = "us-central1"
  description   = "Docker repo for Cloud Run"
  format        = "DOCKER"
  mode          = "STANDARD_REPOSITORY"
}

# Cloud Run service
resource "google_cloud_run_v2_service" "app" {
  name     = "devops-app"
  location = "us-central1"

  template {
    containers {
      image = "us-central1-docker.pkg.dev/regal-stone-481911-e6/docker-repo/app:latest"
    }
  }
}

# Cloud Run IAM for public access
resource "google_cloud_run_v2_service_iam_member" "public" {
  project  = var.project_id
  location = var.region
  name     = google_cloud_run_v2_service.app.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}