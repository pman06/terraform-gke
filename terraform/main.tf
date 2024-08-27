terraform {
  backend "gcs" {
    }
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.0.0"
    }
  }
}

provider "google" {
  project = var.project
  credentials = var.gcp_credentials
  region  = var.region
}

data "google_compute_zones" "this" {
  region  = var.region
  project = var.project
}

locals {
  zones = slice(data.google_compute_zones.this.names, 0, 1)
}


resource "google_compute_network" "this" {
  name                                        = "${var.cluster_name}-vpc"
  delete_default_routes_on_create = false
  auto_create_subnetworks           = false
  routing_mode                            = "GLOBAL"
}

resource"google_compute_subnetwork""this" {

name= var.zone
ip_cidr_range= var.cidrBlock
region=var.region
network=google_compute_network.this.id
}

resource "google_compute_firewall" "rules" {
  project     = var.project
  name        = "${var.cluster_name}-firewall"
  network     = google_compute_network.this.id
  description = "Creates firewall rule targeting tagged instances"

  allow {
    protocol  = "tcp"
    ports     = ["80", "22"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["web"]
}


resource "google_service_account" "default" {
  account_id   = "${var.cluster_name}-sa"
  display_name = "Custom SA for VM Instance"
}

resource "google_compute_instance" "default" {
  name         = var.cluster_name
  machine_type = var.instance_type
  zone         = local.zones[0]
  tags = ["web"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "NVME"
  }

  network_interface {
    network = google_compute_network.this.id
    subnetwork = google_compute_subnetwork.this.id

    access_config {
      // Ephemeral public IP
    }
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}

