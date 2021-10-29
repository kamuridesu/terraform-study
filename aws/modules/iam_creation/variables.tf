variable "username" {
  description = "IAM username"
  type = string
}

variable "path" {
  description = "IAM path"
  type = string
  default = "/"
}

variable "public_key" {
  description = "SSH public key"
  type = string
}