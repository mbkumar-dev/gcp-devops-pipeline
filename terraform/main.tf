terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = "regal-stone-481911-e6"
  region  = "us-central1"
}

resource "google_cloud_run_v2_service" "app" {
  name     = "devops-app"
  location = "us-central1"

  template {
    containers {
      image = "us-central1-docker.pkg.dev/regal-stone-481911-e6/docker-repo/app:latest"

      ports {
        container_port = 8080
      }
    }
  }

  traffic {
    percent = 100
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
  }
}

resource "google_cloud_run_v2_service_iam_member" "public" {
  name     = google_cloud_run_v2_service.app.name
  location = google_cloud_run_v2_service.app.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}