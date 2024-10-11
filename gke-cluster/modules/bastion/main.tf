

locals {

  zone         = slice(data.google_compute_zones.available.names, 0, 1)
  machine_type = data.google_compute_machine_types.vm_available.machine_types[0].name
  tags         = ["web", "test"]
}

resource "google_compute_address" "internal" {
  name         = "my-internal-address"
  subnetwork   = var.subnet
  address_type = "INTERNAL"
  address      = var.private_ip_address
  region       = var.region
}

resource "google_compute_instance" "bastion" {
  name         = var.bastion_name
  machine_type = local.machine_type
  zone         = local.zone[0]
  boot_disk {
    initialize_params {
      image = var.bastion_image
    }
  }
  scheduling {
    preemptible        = true
    automatic_restart  = false
    provisioning_model = "SPOT"
  }
  metadata_startup_script = file("./modules/bastion/startup.sh")
  network_interface {
    network    = var.vpc_network
    subnetwork = var.vpc_subnet
    network_ip = google_compute_address.internal.address
    alias_ip_range {
      ip_cidr_range = "/32" #join("/", [google_compute_address.internal.address, "32"])
    }
  }
  #   metadata_startup_script = var.bastion_startup_script
  tags = local.tags
}

resource "google_compute_firewall" "allow_ssh_bastion" {
  name    = var.firewall_name
  network = var.vpc_network
  allow {
    protocol = "tcp"
    ports    = var.firewall_ports
  }
  source_ranges = var.firewall_source_ranges
  #   target_tags = local.tags
}

resource "google_compute_firewall" "allow_http_https_rdp" {
  name    = "allow-http-https-rdp"
  network = var.vpc_network
  allow {
    protocol = "tcp"
    ports    = ["80", "443", "3389"]
  }
  source_ranges = ["98.97.79.33/32"]
  target_tags   = local.tags
}

## Create IAP SSH permissions for your test instance

# resource "google_project_iam_member" "project" {
#   project = var.project_id
#   role    = "roles/iap.tunnelResourceAccessor"
#   member  = var.sa_id
# }