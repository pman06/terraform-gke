resource "google_compute_network" "vpc" {
  name        = var.vpc_name
  description = var.vpc_description

  # the network is created in "custom subnet mode"
  # we will explicitly connect subnetwork resources below using google_compute_subnetwork resource
  auto_create_subnetworks = "false"
}

# Subnet - https://registry.terraform.io/providers/hashicorp/google/4.74.0/docs/resources/compute_subnetwork
resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  description   = var.subnet_description
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = var.cidrBlock
  secondary_ip_range {
    range_name    = "pods-subnet"
    ip_cidr_range = var.pods_cidr
  }
  secondary_ip_range {
    range_name    = "services-subnet"
    ip_cidr_range = var.svc_cidr
  }
}

resource "google_compute_router" "router" {
  name    = "${var.vpc_name}-router"
  network = google_compute_network.vpc.self_link
  region  = var.region
}

resource "google_compute_router_nat" "nat" {
  name                               = "${var.vpc_name}-nat"
  router                             = google_compute_router.router.name
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.subnet.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}