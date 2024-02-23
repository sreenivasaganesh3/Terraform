# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "myrg232" {
  name     = var.name
  location = var.location
}

resource "azurerm_virtual_network" "myvnet" {
  name                = var.virtualnetwork
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.name
}

resource "azurerm_subnet" "mysubnet" {
  
  name                 = "my-subnet-${count.index}"
  address_prefixes     = ["10.0.${count.index}.0/24"]
  virtual_network_name = var.virtualnetwork
  resource_group_name  = var.name
}


resource "azurerm_storage_account" "storage"{
  
  name                      = "saz232"
  resource_group_name       = var.name
  location                  = var.location
  account_tier              =  "Standard"
  account_replication_type  = "GRS"


  tags= {
     environment  = "developement"
    }
}
