variable "cluster_name" {
  type        = string
  description = "The name of the cluster, unique within the project and location."
}

variable "region" {
  type        = string
  description = "The location (region or zone) in which the cluster master will be created, as well as the default node location. If you specify a zone (such as us-central1-a), the cluster will be a zonal cluster with a single cluster master. If you specify a region (such as us-west1), the cluster will be a regional cluster with multiple masters spread across zones in the region, and with default node locations in those zones as well"
}

variable "network" {
  type        = string
  description = "The name or self_link of the Google Compute Engine network to which the cluster is connected. For Shared VPC, set this to the self link of the shared network."
}

variable "subnetwork" {
  type        = string
  description = "The name or self_link of the Google Compute Engine subnetwork in which the cluster's instances are launched."
}

variable "k8s_version" {
  type        = string
  description = "kubernetes version"
  default     = "1.27"
}

variable "nodepools" {
  description = "Nodepools for the Kubernetes cluster"
  type = map(object({
    name         = string
    node_count   = number
    node_labels  = map(any)
    machine_type = string
  }))
  default = {
    worker = {
      name         = "worker"
      node_labels  = { "worker-name" = "worker" }
      machine_type = "e2-medium"
      node_count   = 1
    }
  }
}

variable "cidrBlock" {
  type        = string
  description = "The range of internal addresses that are owned by this subnetwork. Provide this property when you create the subnetwork. For example, 10.0.0.0/8 or 192.168.0.0/16. Ranges must be unique and non-overlapping within a network. Only IPv4 is supported."
}

variable "master_ipv4_cidr_block" {
  description = "CIDR block for cluster control plane nodes"
  type        = string
  default     = "172.16.0.16/28"
}

variable "authorized_networks" {
  description = "Authorized networks CIDR"
  type        = string
}