output "openai_endpoint" {
  description = "Azure OpenAI endpoint"
  value       = azurerm_cognitive_account.openai.endpoint
  sensitive   = true
}

output "openai_id" {
  description = "Azure OpenAI resource ID"
  value       = azurerm_cognitive_account.openai.id
}

output "cognitive_services_endpoint" {
  description = "Cognitive Services endpoint"
  value       = azurerm_cognitive_account.multi_service.endpoint
  sensitive   = true
}