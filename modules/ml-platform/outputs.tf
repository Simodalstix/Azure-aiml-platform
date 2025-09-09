output "workspace_id" {
  description = "ML workspace ID"
  value       = azurerm_machine_learning_workspace.main.id
}

output "workspace_name" {
  description = "ML workspace name"
  value       = azurerm_machine_learning_workspace.main.name
}

output "endpoint_id" {
  description = "ML endpoint ID"
  value       = azapi_resource.ml_endpoint.id
}