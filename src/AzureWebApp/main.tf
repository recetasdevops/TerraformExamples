#Configure remote state for terraform cloud
terraform {
  backend "remote" {
    organization = "recetasdevops"

    workspaces {
      name = "azuredevops"
    }
  }
}

#Definimos el resource group a crear
resource "azurerm_resource_group" "resource_group_test" {
  name     = "TFRecetasDevOpsAppServiceRG"
  location = "West Europe"
}

#Definimos el service plan a crear
resource "azurerm_app_service_plan" "app_service_test" {
  name                = "recetasdevopsserviceplan"
  location            = azurerm_resource_group.resource_group_test.location
  resource_group_name = azurerm_resource_group.resource_group_test.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

#Definimos el app service a crear
resource "azurerm_app_service" "test" {
  name                = "recetasdevopsterraform"
  location            = azurerm_resource_group.resource_group_test.location
  resource_group_name = azurerm_resource_group.resource_group_test.name
  app_service_plan_id = azurerm_app_service_plan.app_service_test.id

  app_settings = {
    "ApiUrl" = "www.google.es",
    "Version" = "1.0"
  }
}
