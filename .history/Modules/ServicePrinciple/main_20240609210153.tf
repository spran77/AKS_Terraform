data "azuread_client_config" "current" {}

resource "azuread_application" "azuread_service_principal" {
  display_name = var.service_principal_name
  owners       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal" "example" {
  client_id                    = azuread_application.azuread_service_principal.client_id
  app_role_assignment_required = true
  owners                       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal_password" "example" {
  service_principal_id = azuread_service_principal.example.object_id
}