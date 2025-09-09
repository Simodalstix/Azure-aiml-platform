# Azure OpenAI Service
resource "azurerm_cognitive_account" "openai" {
  name                = "openai-${random_string.suffix.result}"
  location           = var.location
  resource_group_name = var.resource_group_name
  kind               = "OpenAI"
  sku_name           = "S0"
  tags               = var.tags

  public_network_access_enabled = true
}

# GPT-4 Deployment
resource "azurerm_cognitive_deployment" "gpt4" {
  name                 = "gpt-4"
  cognitive_account_id = azurerm_cognitive_account.openai.id

  model {
    format  = "OpenAI"
    name    = "gpt-4"
    version = "turbo-2024-04-09"
  }

  scale {
    type     = "Standard"
    capacity = 10
  }
}

# Text Embedding Deployment
resource "azurerm_cognitive_deployment" "embedding" {
  name                 = "text-embedding-ada-002"
  cognitive_account_id = azurerm_cognitive_account.openai.id

  model {
    format  = "OpenAI"
    name    = "text-embedding-ada-002"
    version = "2"
  }

  scale {
    type     = "Standard"
    capacity = 30
  }
}

# Cognitive Services Multi-Service Account
resource "azurerm_cognitive_account" "multi_service" {
  name                = "cognitive-${random_string.suffix.result}"
  location           = var.location
  resource_group_name = var.resource_group_name
  kind               = "CognitiveServices"
  sku_name           = "S0"
  tags               = var.tags

  public_network_access_enabled = true
}

# Document Intelligence
resource "azurerm_cognitive_account" "document_intelligence" {
  name                = "docint-${random_string.suffix.result}"
  location           = var.location
  resource_group_name = var.resource_group_name
  kind               = "FormRecognizer"
  sku_name           = "S0"
  tags               = var.tags

  public_network_access_enabled = true
}

resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}