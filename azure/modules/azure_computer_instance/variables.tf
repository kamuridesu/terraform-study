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
