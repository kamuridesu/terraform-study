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

resource "aws_key_pair" "ssh_key" {
  key_name   = "ssh_key"
  public_key = file(var.ssh_public_key)
}

resource "aws_security_group" "ec2_security_ports" {
  name = "ec2_security_ports"

  dynamic "ingress" {
    for_each = var.vm_connetion_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "ec2_security_ports" }
}

module "ec2_instance" {
  count          = var.num_of_instances
  source         = "./modules/ec2_instance"
  username       = var.username
  counter        = count.index
  ssh_key_name   = aws_key_pair.ssh_key.key_name
  sec_group_name = aws_security_group.ec2_security_ports.name
  private_key    = file(var.ssh_private_key)
}
