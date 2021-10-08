terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.87.0"
    }
  }
}

provider "google" {
  project = "terraform-328013"
  region  = "us-central-1"
  zone    = "us-central1-c"
}

resource "google_compute_instance" "vm_instance" {
  name         = "tf-instance"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }
}