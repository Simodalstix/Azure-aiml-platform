# Data Lake Storage Gen2
resource "azurerm_storage_account" "datalake" {
  name                     = "stadatalake${random_string.suffix.result}"
  resource_group_name      = var.resource_group_name
  location                = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled          = true
  tags                    = var.tags
}

# Synapse Workspace
resource "azurerm_synapse_workspace" "main" {
  name                                 = "synapse-${random_string.suffix.result}"
  resource_group_name                  = var.resource_group_name
  location                            = var.location
  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.main.id
  sql_administrator_login             = "sqladmin"
  sql_administrator_login_password    = random_password.synapse_password.result
  tags                               = var.tags

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_storage_data_lake_gen2_filesystem" "main" {
  name               = "synapse"
  storage_account_id = azurerm_storage_account.datalake.id
}

# Event Hub for streaming data
resource "azurerm_eventhub_namespace" "main" {
  name                = "evhns-${random_string.suffix.result}"
  location           = var.location
  resource_group_name = var.resource_group_name
  sku                = "Standard"
  capacity           = 1
  tags               = var.tags
}

resource "azurerm_eventhub" "ml_events" {
  name                = "ml-events"
  namespace_name      = azurerm_eventhub_namespace.main.name
  resource_group_name = var.resource_group_name
  partition_count     = 2
  message_retention   = 1
}

resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

resource "random_password" "synapse_password" {
  length  = 16
  special = true
}