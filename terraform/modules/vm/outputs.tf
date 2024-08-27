
output "vm_id" {
  value = google_compute_instance.default.instance_id
}


output "vm_type" {
  value = google_compute_instance.default.machine_type
}