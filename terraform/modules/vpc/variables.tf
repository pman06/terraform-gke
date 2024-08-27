variable "region" {
  description = "Deployment region"
  type        = string
}

variable "project" {
  description = "Deployment project"
  type        = string
}

variable "vpc_name" {
  type        = string
  description = "vpc name"
}

variable "subnet_name" {
  type        = string
  description = "vpc name"
}

variable "firewall_name" {
  type        = string
  description = "vpc name"
}

variable "cidrBlock" {
  type        = string
  description = "The cidr block for subnet"
  default     = "10.1.0.0/16"
}