output "vm_private_ip" {
  value = azurerm_network_interface.example.private_ip_addresses
}

output "vm_public_ip" {
  value = azurerm_public_ip.public_ip.ip_address
}