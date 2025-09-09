output "storage_account_id" {
  description = "Storage account ID"
  value       = azurerm_storage_account.datalake.id
}

output "synapse_workspace_id" {
  description = "Synapse workspace ID"
  value       = azurerm_synapse_workspace.main.id
}

output "eventhub_namespace_name" {
  description = "Event Hub namespace name"
  value       = azurerm_eventhub_namespace.main.name
}