terraform {
  required_version = ">= 1.10"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.31.0" 
    }
  }
}

provider "google" {
  project = "project5226-495700"
  region  = "us-central1"
}