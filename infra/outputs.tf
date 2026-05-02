output "vm_name" {
  value       = yandex_compute_instance.vm_1.name
  description = "Name of the provisioned VM"
}

output "vm_external_ip" {
  value       = yandex_compute_instance.vm_1.network_interface[0].nat_ip_address
  description = "Public IPv4 address of the VM"
}