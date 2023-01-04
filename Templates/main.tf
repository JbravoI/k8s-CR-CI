# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.96.0" # Establishes a forced version
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.18.0"
    }
  }

  # backend "azurerm" {
  # }
  # required_version = ">= 0.14.11"
}

provider "azurerm" {
  features {}
  #   subscription_id = "!__subscription_id__!"
  #   client_id       = "!__client_id__!"
  #   client_secret   = "!__client_secret__!"
  #   tenant_id       = "!__tenant_id__!"
}

provider "azuread" {
  #   tenant_id = "!__tenant_id__!"
}

######################################
# Data Imports of Existing Resources #
######################################
data "azurerm_client_config" "current" {
}
data "azuread_client_config" "current" {}


##################
# Resource Group #
##################
resource "azurerm_resource_group" "resource_group" { #Creation of new Resource Group would be actual code snippet
  name     = "${var.customer_prefix}-platform"
  location = var.location
}

###################
# Virtual Network #
###################
module "vnet" {
  source             = "../_Modules/networking"
  rg_name            = azurerm_resource_group.resource_group.name
  vnet_name          = "${var.customer_prefix}-platform-vnet"
  vnet_address_space = ["10.0.0.0/16"]
  k8s_subnet_name    = "${var.customer_prefix}k8snet"
  ci_subnet_name     = "${var.customer_prefix}cinet"

  tags = {
    Environment : var.environment
  }
  depends_on = [azurerm_resource_group.resource_group]
}


###########################
# Azure Kubernetes Service #
###########################
module "aks" {
  source                            = "../_Modules/kubernetes"
  rg_name                           = azurerm_resource_group.resource_group.name
  kubernetes_name                   = "${var.customer_prefix}-cluster"
  kubernetes_default_node_pool_name = "${var.customer_prefix}nodepool"
  kubernetes_version                = "1.25.2"
  # public_network_access             = "true"
  dns_prefix          = "${var.customer_prefix}-prefix-name"
  subnet_id           = module.vnet.k8s_subnet_id
  subnet_name         = module.vnet.k8s_subnet_name
  load_balancer_sku   = "Basic"
  outbound_type       = "loadBalancer"
  enable_auto_scaling = "true"
  max_count           = "2"
  min_count           = "1"
  vm_size             = "Standard_B2s"
  identity_type       = "SystemAssigned"

  tags = {
    Environment : var.environment
  }
  depends_on = [azurerm_resource_group.resource_group, module.vnet]
}


######################
# Container Registry #
#####################
module "container-registry" {
  source                        = "../_Modules/Container_registry"
  Container_Registry_name       = "${var.customer_prefix}cr234"
  rg_name                       = azurerm_resource_group.resource_group.name
  sku                           = "basic"
  public_network_access_enabled = "true"

  tags = {
    Environment : var.environment
  }
  depends_on = [azurerm_resource_group.resource_group, module.vnet]
}


######################
# Container Instance #
######################
module "aci" {
  source                  = "../_Modules/Container_instance"
  Container_instance_name = "${var.customer_prefix}-ci"
  rg_name                 = azurerm_resource_group.resource_group.name
  dns_name_label          = "cont01-example"
  os_type                 = "linux"
  container_name          = "hello-world"
  container_image         = "mcr.microsoft.com/azure-cognitive-services/textanalytics/keyphrase"
  container_cpu           = "0.5"
  container_memory        = "1.5"
  container_port          = 443
  container_protocol      = "TCP"
  subnet_id               = module.vnet.ci_subnet_id
  ip_address_type         = "public"

  tags = {
    Environment : var.environment
  }
  depends_on = [azurerm_resource_group.resource_group, module.vnet]
}



#####################
# app service plan #
#####################
module "service_plan" {
  source               = "../_Modules/Container_Apps"
  app_serviceplan_name = "${var.customer_prefix}-apspl"
  rg_name                 = azurerm_resource_group.resource_group.name
  os_type              = "Windows"
  sku_name             = "P1v2"
  sku_tier             = "Standard"
  sku_size             = "F1"

  tags = {
    Environment : var.environment
  }
  depends_on = [azurerm_resource_group.resource_group, module.vnet]
}

###############
# app service  #
###############
module "app_service" {
  source              = "../_Modules/Container_Apps/App_service"
  app_service_name    = "${var.customer_prefix}-aps2311"
  rg_name                 = azurerm_resource_group.resource_group.name
  app_service_plan_id = module.service_plan.app_service_plan_id

  tags = {
    Environment : var.environment
  }
  depends_on = [azurerm_resource_group.resource_group, module.vnet]
}