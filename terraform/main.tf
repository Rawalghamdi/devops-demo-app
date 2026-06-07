# terraform config for Azure
# this creates the infrastructure needed to run the app in the cloud
# it provisions: resource group, container registry, kubernetes cluster

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.3.0"
}

provider "azurerm" {
  features {}
}

# resource group — a logical container for all our Azure resources
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

# container registry — stores our Docker images
resource "azurerm_container_registry" "main" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Basic"
  # admin_enabled lets us push images with username/password (fine for a demo)
  admin_enabled       = true
}

# kubernetes cluster — where our app will run
resource "azurerm_kubernetes_cluster" "main" {
  name                = var.aks_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = var.aks_name

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
  }

  # system-assigned identity is the simplest option for a student project
  identity {
    type = "SystemAssigned"
  }
}

# give AKS permission to pull images from ACR
resource "azurerm_role_assignment" "aks_acr" {
  principal_id                     = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.main.id
  skip_service_principal_aad_check = true
}
