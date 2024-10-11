terraform {

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.0.0"
    }
  }
}

provider "google" {
  project     = var.project
  credentials = file("./cool-academy-433713-g7-55ce1845f923.json") #var.gcp_credentials
  region      = var.region
}


module "vpc_with_subnets" {
  source = "./modules/vpc"

  vpc_name    = var.cluster_name
  subnet_name = var.cluster_name

  region = var.region

  cidrBlock = var.cidrBlock
}

module "bastion_host" {
  source      = "./modules/bastion"
  project_id  = var.project
  region      = var.region
  vpc_network = module.vpc_with_subnets.vpc_self_link
  vpc_subnet  = module.vpc_with_subnets.subnet_self_link
  subnet      = module.vpc_with_subnets.subnet_self_link
}
module "gke_with_node_group" {

  source = "./modules/gke"

  cluster_name        = var.cluster_name
  k8s_version         = var.k8s_version
  region              = var.region
  nodepools           = var.nodepools
  network             = module.vpc_with_subnets.vpc_self_link
  subnetwork          = module.vpc_with_subnets.subnet_self_link
  cidrBlock           = module.vpc_with_subnets.subnet_cidrs
  authorized_networks = module.bastion_host.bastion-cidr-range
  depends_on          = [module.vpc_with_subnets, module.bastion_host]
}
