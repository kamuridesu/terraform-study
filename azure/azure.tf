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