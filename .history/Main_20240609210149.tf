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