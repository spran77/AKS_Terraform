provider "azurerm" {
  features {}
}

provider "azuread" {}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                       = var.keyvault_name
  location                   = var.location
  resource_group_name        = azurerm_resource_group.rg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  enable_rbac_authorization  = true
}

data "azuread_client_config" "current" {}

resource "azuread_application" "app" {
  display_name = var.service_principal_name
  owners       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal" "sp" {
  application_id               = azuread_application.app.application_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]
}

resource "random_password" "sp_password" {
  length  = 16
  special = true
}

resource "azuread_service_principal_password" "sp_password" {
  service_principal_id = azuread_service_principal.sp.object_id
  value                = random_password.sp_password.result
  end_date             = "2099-12-31T23:59:59Z"
}

resource "azurerm_key_vault_secret" "client_secret" {
  name         = "client-secret"
  value        = azuread_service_principal_password.sp_password.value
  key_vault_id = azurerm_key_vault.kv.id

  depends_on = [
    azurerm_key_vault.kv
  ]
}
