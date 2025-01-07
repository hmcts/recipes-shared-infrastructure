provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

provider "azurerm" {
  features {}
  resource_provider_registrations = "core"
  alias                           = "private_endpoint"
  subscription_id                 = var.aks_subscription_id
}

provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
  alias                           = "postgres_network"
  subscription_id                 = var.aks_subscription_id
}
