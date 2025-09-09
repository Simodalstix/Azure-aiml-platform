output "resource_group_name" {
  description = "Resource group name"
  value       = module.resource_group.name
}

output "ml_workspace_name" {
  description = "ML workspace name"
  value       = module.ml_platform.workspace_name
}

output "openai_endpoint" {
  description = "Azure OpenAI endpoint"
  value       = module.ai_services.openai_endpoint
  sensitive   = true
}