terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>5.0.0" # Terraform får installera 5.5 eller senare men inte 6.0 eller högre
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}