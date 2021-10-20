variable "subscription_id" {
  description = "My personal subscription ID"
  type        = string
}

variable "username" {
  description = "vm username"
  type        = string
}

variable "resource_group" {
  description = "Azure resource group"
}
variable "prefix_name" {
  description = "Prefix to be added to the resource name"
  type        = string
}

variable "public_ip_allocation_method" {
  description = "Allocation method fot the public IP address"
  type        = string
}

variable "subnet_id" {
  description = "Subnet id"
}
