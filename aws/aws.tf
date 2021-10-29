terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

module "ec2_instance" {
  source = "./modules/ec2_instance"
  username = var.username
  vm_connetion_ports = var.vm_connetion_ports
  public_key = file(var.ssh_public_key)
  private_key = file(var.ssh_private_key)
}
