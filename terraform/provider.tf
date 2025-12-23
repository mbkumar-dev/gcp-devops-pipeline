terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.45"
    }
  }
}

# provider.tf
provider "google" {
  project = "regal-stone-481911-e6"
  region  = "us-central1"
}