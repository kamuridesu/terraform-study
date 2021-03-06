terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.79.1"
    }
  }
  required_version = "~>1.0.8"
}

provider "azurerm" {
  features {
  }
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "resource_group" {
  name     = "example-resources"
  location = "West Europe"
}

module "azure_network" {
  source         = "./modules/azure_network_settings"
  prefix_name    = "azure_network"
  resource_group = azurerm_resource_group.resource_group
}

module "azure_computer" {
  count                       = var.number_of_instances
  source                      = "./modules/azure_computer_instance"
  prefix_name                 = "${count.index}-azurevm"
  username                    = var.username
  subscription_id             = var.subscription_id
  resource_group              = azurerm_resource_group.resource_group
  public_ip_allocation_method = "Static"
  subnet_id                   = module.azure_network.subnet_id
  depends_on = [
    module.azure_network
  ]

  check_api_content = true
}

