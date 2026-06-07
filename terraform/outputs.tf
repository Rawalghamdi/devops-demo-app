# outputs — terraform prints these after a successful apply
# useful for knowing what was created

output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "acr_login_server" {
  description = "Use this as your registry URL when pushing Docker images"
  value       = azurerm_container_registry.main.login_server
}

output "aks_name" {
  value = azurerm_kubernetes_cluster.main.name
}

output "kube_config_command" {
  description = "Run this command to configure kubectl to connect to the cluster"
  value       = "az aks get-credentials --resource-group ${azurerm_resource_group.main.name} --name ${azurerm_kubernetes_cluster.main.name}"
}
