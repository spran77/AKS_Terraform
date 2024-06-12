provider "azurerm" {
  features {

  }
}

resource "azurerm_resource_group" "rg1" {
  name     = var.rgname
  location = var.location

}

module "ServicePrincipal" {
  source = "./Modules/ServicePrinciple"
  service_principal_name = var.service_principal_name
  depends_on = [
    azurerm_resource_group.rg1
  ]
}

resource "azurerm_role_assignment" "rolespn" {
 scope         = "/subscriptions/7e30f662-6857-406a-ab23-cdcf0a76b251"
 role_defenition_name = "contributor"
  principal_id = module.ServicePrincipal.service_principal_object_id

  depends_on = [
    module.ServicePrincipal
  ]

}
