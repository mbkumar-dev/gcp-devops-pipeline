resource "google_artifact_registry_repository" "repo" {
  project       = "regal-stone-481911-e6"
  location      = "us-central1"
  repository_id = "docker-repo"
  description   = "Docker repo for Cloud Run"
  format        = "DOCKER"
  mode          = "STANDARD_REPOSITORY"
}

resource "google_cloud_run_v2_service" "app" {
  name     = "devops-app"
  location = "us-central1"
  project  = "regal-stone-481911-e6"

  template {
    containers {
      image = "us-central1-docker.pkg.dev/regal-stone-481911-e6/docker-repo/app:latest"
    }
  }
}

resource "google_cloud_run_v2_service_iam_member" "public" {
  name     = "projects/regal-stone-481911-e6/locations/us-central1/services/devops-app"
  role     = "roles/run.invoker"
  member   = "allUsers"
}