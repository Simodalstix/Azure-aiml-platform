terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "~>2.0"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

provider "azapi" {}

# Core Infrastructure
module "resource_group" {
  source   = "./modules/resource-group"
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# Data Platform
module "data_platform" {
  source              = "./modules/data-platform"
  resource_group_name = module.resource_group.name
  location           = var.location
  tags               = var.tags
}

# ML Platform
module "ml_platform" {
  source              = "./modules/ml-platform"
  resource_group_name = module.resource_group.name
  location           = var.location
  storage_account_id  = module.data_platform.storage_account_id
  tags               = var.tags
}

# AI Services
module "ai_services" {
  source              = "./modules/ai-services"
  resource_group_name = module.resource_group.name
  location           = var.location
  tags               = var.tags
}