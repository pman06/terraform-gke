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

resource "google_compute_router" "router" {
  name = "${var.vpc_name}-router"
  network = google_compute_network.this.self_link
  region = var.region
}

resource "google_compute_router_nat" "nat" {
  name  = "${var.vpc_name}-nat"
  router = google_compute_router.router.name
  nat_ip_allocate_option = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name = google_compute_subnetwork.this.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}