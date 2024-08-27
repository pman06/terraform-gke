output "vpc_self_link" {
  value = module.vpc.vpc_self_link
}

output "subnet_self_link" {
  value = module.vpc.subnet_self_link
}

output "firewall_rules" {
  value = module.vpc.firewall_rules
}

output "vm_id" {
  value = module.vms.vm_id
}

output "vm_type" {
  value = module.vms.vm_type
}