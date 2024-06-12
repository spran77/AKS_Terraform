provider "azurerm" {
  features {

  }
}

resource "azurerm_resource_group" "rg1" {
  name     = var.rgname
  location = var.location

}

module "ServicePrincipal" {
  source                 = "./Modules/ServicePrincipal"
  service_principal_name = var.service_principal_name
  depends_on = [
    azurerm_resource_group.rg1
  ]
}

resource "azurerm_role_assignment" "rolespn" {
  scope                = "/subscriptions/7e30f662-6857-406a-ab23-cdcf0a76b251"
  role_definition_name = "contributor"
  principal_id         = module.ServicePrincipal.service_principal_object_id

  depends_on = [
    module.ServicePrincipal
  ]

}

module "keyvault" {
  source                      = "./Modules/KeyVault"
  keyvault_name               = var.keyvault_name
  location                    = var.location
  resource_group_name         = var.rgname
  service_principal_name      = var.service_principal_name
  service_principal_object_id = module.ServicePrincipal.service_principal_object_id
  service_principal_tenant_id = module.ServicePrincipal.service_principal_tenant_id
}
