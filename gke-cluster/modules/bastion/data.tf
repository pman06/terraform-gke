data "google_compute_zones" "available" {
  region = var.region
  status = "UP"
}
data "google_compute_machine_types" "vm_available" {
  filter = "memoryMb = 1024 AND guestCpus = 2"
  zone   = slice(data.google_compute_zones.available.names, 0, 1)[0]
}

# data "template_file" "startup_script"{
#     template = file("./modules/bastion/startup.sh")
#     vars = {
#         project = 
#         cluster = var
#     }
# }