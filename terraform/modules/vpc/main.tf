data "google_compute_zones" "this" {
  region  = var.region
  project = var.project
}

locals {
  zones = slice(data.google_compute_zones.this.names, 0, 1)
}


resource "google_compute_network" "this" {
  name                                        = "${var.vpc_name}-vpc"
  delete_default_routes_on_create = false
  auto_create_subnetworks           = false
  routing_mode                            = "GLOBAL"
}

resource "google_compute_subnetwork" "this" {

name= var.subnet_name
ip_cidr_range= var.cidrBlock
region=var.region
network=google_compute_network.this.id
}

resource "google_compute_firewall" "rules" {
  project     = var.project
  name        = "${var.firewall_name}-firewall"
  network     = google_compute_network.this.id
  description = "Creates firewall rule targeting tagged instances"

  allow {
    protocol  = "tcp"
    ports     = ["80", "22"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["web"]
}
