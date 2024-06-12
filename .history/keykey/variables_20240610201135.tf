variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location/region where the resources will be created"
  type        = string
}

variable "keyvault_name" {
  description = "The name of the Key Vault"
  type        = string
}

variable "service_principal_name" {
  description = "The name of the Service Principal"
  type        = string
}
