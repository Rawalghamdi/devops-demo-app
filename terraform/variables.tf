# input variables so we don't hardcode values in main.tf

variable "resource_group_name" {
  description = "Name for the Azure resource group"
  type        = string
  default     = "devops-demo-rg"
}

variable "location" {
  description = "Azure region to deploy resources"
  type        = string
  default     = "eastus"
}

variable "acr_name" {
  description = "Name for the container registry (must be globally unique, letters and numbers only)"
  type        = string
  default     = "devopsdemoacr123"
}

variable "aks_name" {
  description = "Name for the Kubernetes cluster"
  type        = string
  default     = "devops-demo-aks"
}
