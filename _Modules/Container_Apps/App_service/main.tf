data "azurerm_resource_group" "resource-group" {
  name = var.rg_name
}

#Creates the app_service
resource "azurerm_app_service" "appservice" {
  name                = var.app_service_name
  location            = data.azurerm_resource_group.resource-group.location
  resource_group_name = data.azurerm_resource_group.resource-group.name
  app_service_plan_id = var.app_service_plan_id

}