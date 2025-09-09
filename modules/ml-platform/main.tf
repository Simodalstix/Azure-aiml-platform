# Application Insights for ML monitoring
resource "azurerm_application_insights" "main" {
  name                = "appi-ml-${random_string.suffix.result}"
  location           = var.location
  resource_group_name = var.resource_group_name
  application_type   = "web"
  tags               = var.tags
}

# Key Vault for ML secrets
resource "azurerm_key_vault" "main" {
  name                = "kv-ml-${random_string.suffix.result}"
  location           = var.location
  resource_group_name = var.resource_group_name
  tenant_id          = data.azurerm_client_config.current.tenant_id
  sku_name           = "standard"
  tags               = var.tags

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get", "List", "Set", "Delete", "Purge", "Recover"
    ]
  }
}

# Azure ML Workspace
resource "azurerm_machine_learning_workspace" "main" {
  name                    = "mlw-${random_string.suffix.result}"
  location               = var.location
  resource_group_name    = var.resource_group_name
  application_insights_id = azurerm_application_insights.main.id
  key_vault_id           = azurerm_key_vault.main.id
  storage_account_id     = var.storage_account_id
  tags                   = var.tags

  identity {
    type = "SystemAssigned"
  }

  public_network_access_enabled = true
}

# ML Compute Instance for development
resource "azapi_resource" "ml_compute_instance" {
  count     = var.subnet_id != null ? 1 : 0
  type      = "Microsoft.MachineLearningServices/workspaces/computes@2024-04-01"
  name      = "dev-instance"
  parent_id = azurerm_machine_learning_workspace.main.id

  body = {
    properties = {
      computeType = "ComputeInstance"
      properties = {
        vmSize = "Standard_DS3_v2"
        subnet = {
          id = var.subnet_id
        }
        applicationSharingPolicy = "Personal"
        computeInstanceAuthorizationType = "personal"
      }
    }
  }
}

# Managed Online Endpoint
resource "azapi_resource" "ml_endpoint" {
  type      = "Microsoft.MachineLearningServices/workspaces/onlineEndpoints@2024-04-01"
  name      = "endpoint-${random_string.suffix.result}"
  parent_id = azurerm_machine_learning_workspace.main.id

  body = {
    properties = {
      authMode = "Key"
      publicNetworkAccess = "Enabled"
    }
  }

  tags = var.tags
}

data "azurerm_client_config" "current" {}

resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}