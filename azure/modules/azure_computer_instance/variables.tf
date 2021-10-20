variable "subscription_id" {
  description = "My personal subscription ID"
  type        = string
}

variable "username" {
  description = "vm username"
  type        = string
}

variable "number_of_instances" {
  description = "Number os instances to be created"
  type        = number
  default     = 1
}

variable "resource_group" {
    description = "Azure resource group"
}

variable "network_interface_id" {
  description = "Network interface id to be used"
}

variable "prefix_name" {
    description = "Prefix to be added to the resource name"
    type = string
}