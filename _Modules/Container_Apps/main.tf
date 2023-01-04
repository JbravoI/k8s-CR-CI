data "azurerm_resource_group" "resource-group" {
  name = var.rg_name
}

#Creates the app_service_plan

resource "azurerm_app_service_plan" "appserviceplan" {
  name                = var.app_serviceplan_name
  location            = data.azurerm_resource_group.resource-group.location
  resource_group_name = data.azurerm_resource_group.resource-group.name
#   os_type             = var.os_type
#   sku_name            = var.sku_name

  sku {
    tier = var.sku_tier
    size = var.sku_size
  }
}

