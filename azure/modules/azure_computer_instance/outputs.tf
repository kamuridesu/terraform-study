# output "vm_private_ip" {
#   # value = azurerm_network_interface.network_interface.*.private_ip_addresses
#   value = azurerm_network_interface.network_interface.private_ip_addresses
# }

# output "public_ip" {
#   # value = azurerm_public_ip.public_ip.*.ip_address
#   value = azurerm_public_ip.public_ip.ip_address
# }

output "vm_public_ip" {
  # value = azurerm_linux_virtual_machine.example.*.public_ip_addresses
  value = azurerm_linux_virtual_machine.example.public_ip_addresses
}
