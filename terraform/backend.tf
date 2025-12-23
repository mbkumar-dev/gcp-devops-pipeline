# backend.tf
terraform {
  backend "gcs" {
    bucket = "regal-stone-481911-terraform-state"
    prefix = "terraform/state"
  }
}