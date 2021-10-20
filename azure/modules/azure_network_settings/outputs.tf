output "network_interface_id" {
  description = "outputs the network interface ID to be used by the VM"
  value       = azurerm_network_interface.network_interface.id
}

output "public_ip_addresses" {
  description = "Outputs the publix ID Addresses"
  value       = azurerm_public_ip.public_ip.ip_address
}