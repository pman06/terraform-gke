output "vpc_self_link" {
  value = google_compute_network.this.self_link
}

output "vpc_id" {
  value = google_compute_network.this.id
}

output "subnet_id" {
  value = google_compute_subnetwork.this.id
}

output "subnet_self_link" {
  value = google_compute_subnetwork.this.self_link
}

output "firewall_rules" {
  value = google_compute_firewall.rules.allow
}

