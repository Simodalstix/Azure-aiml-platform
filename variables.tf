variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-aiml-platform"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default = {
    Environment = "production"
    Project     = "aiml-platform"
    Owner       = "ml-team"
  }
}