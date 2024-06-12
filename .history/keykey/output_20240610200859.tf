output "keyvault_id" {
  value = azurerm_key_vault.kv.id
}

output "client_id" {
  value = azuread_application.app.application_id
}

output "client_secret" {
  value = azurerm_key_vault_secret.client_secret.value
}


