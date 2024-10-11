variable "region" {
  description = "Bastion host deployment region"
  type        = string
}

variable "bastion_name" {
  description = "Bastion host name"
  type        = string
  default     = "jump-host"
}

# variable "bastion_machine_type" {
#   description = "Basion host machine type"
#   type = string
# }

variable "bastion_image" {
  description = "Image type to deploy for bastion host"
  type        = string
  default     = "debian-cloud/debian-11"
}

variable "firewall_name" {
  description = "Bastion host firewall name"
  type        = string
  default     = "bastion-firewall"
}

variable "firewall_ports" {
  description = "Firewall port for bastion ssh"
  type        = list(string)
  default     = ["22"]
}

variable "firewall_source_ranges" {
  description = "Bastion host allowed source ranges"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "vpc_network" {
  description = "Cluster VPC network self link"
  type        = string
}

variable "vpc_subnet" {
  description = "Cluster VPC subnetwork"
  type        = string
}

variable "private_ip_address" {
  description = "Private IP for Bastion host"
  type        = string
  default     = "10.1.0.2"
}

variable "subnet" {
  type = string
}

variable "project_id" {
  description = "Project ID"
  type        = string
}

# variable "sa_id" {
#   description = "Service account ID"
#   type = string
# }