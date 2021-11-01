variable "public_key" {
  description = "SSH public key"
  type = string
}

variable "private_key"{
  description = "SSH private key for provisioner"
  type = string
}

variable "vm_connetion_ports" {
  description = "Ports to connect"
  type = list(number)
  default = [ 22, 5000 ]
}

variable "username" {
  description = "username for provisioner ssh connection"
  type = string
}

variable "counter" {
  type = number
}