output "vm_ip_address" {
    description = "outputs the vm ip address"
    value = module.azure_computer.*.vm_public_ip
}