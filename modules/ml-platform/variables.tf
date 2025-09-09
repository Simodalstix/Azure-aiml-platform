variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "storage_account_id" {
  description = "Storage account ID for ML workspace"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for compute resources"
  type        = string
  default     = null
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
}