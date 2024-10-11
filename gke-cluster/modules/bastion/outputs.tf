output "bastion-cidr" {
  value = google_compute_instance.bastion.network_interface.0.network_ip
}

output "bastion-cidr-range" {
  value = join("/", [google_compute_instance.bastion.network_interface.0.network_ip, "32"])
}