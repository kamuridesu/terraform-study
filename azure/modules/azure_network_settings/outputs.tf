output "network_interface_id" {
    description = "outputs the network interface ID to be used by the VM"
    value = azurerm_network_interface.network_interface.id
}