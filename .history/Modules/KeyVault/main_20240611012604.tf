data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                        = var.keyvault_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  purge_protection_enabled    = false
  sku_name                    = "premium"
  soft_delete_retention_days  = 7
  enable_rbac_authorization   = true
}

resource "azurerm_key_vault_access_policy" "kv" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id

  # Object ID of the service principal or managed identity
  object_id = azuread_application.main.application_id

  secret_permissions = [
    "get",
    "list",
    "set",
    "delete",
    "backup",
    "restore",
    "recover",
    "purge"
  ]
}
