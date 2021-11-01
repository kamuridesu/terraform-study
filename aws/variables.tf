variable "vm_connetion_ports" {
    type = list(number)
    default = [22, 5000]
}

variable "username" {
    type = string
}

variable "ssh_private_key" {
  type = string
}

variable "ssh_public_key" {
  type = string
  default = "~/.ssh/aws.pub"
}

variable "num_of_instances" {
  type = number
  default = 1
}