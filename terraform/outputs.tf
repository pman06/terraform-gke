output "vpc_self_link"{
    value = google_compute_network.this.self_link 
}

output "subnet_self_link" {
  value = google_compute_subnetwork.this.se
}

output "firewall_rules" {
  value = google_compute_firewall.rules.allow
}

output "vm_id" {
  value = google_compute_instance.default.instance_id
}