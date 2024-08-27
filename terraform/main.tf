terraform {
  backend "gcs" {
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.0.0"
    }
  }
}

provider "google" {
  project     = var.project
  credentials = var.gcp_credentials
  region      = var.region
}

data "google_compute_zones" "this" {
  region  = var.region
  project = var.project
}

locals {
  zones = slice(data.google_compute_zones.this.names, 0, 1)
}

module "vpc" {
  source          = "./modules/vpc"
  vpc_name        = "${var.name}-vpc"
  subnet_name     = "${var.name}-sunet"
  firewall_name   = "${var.name}-firewall"
  region          = var.region
  project         = var.project
}



module "vms" {
  source        = "./modules/vm"
  vm_name       = var.name
  zone          = local.zones[0]
  instance_type = var.instance_type
  sa_name       = var.name    
  network    = module.vpc.vpc_id
  subnetwork = module.vpc.subnet_id
}