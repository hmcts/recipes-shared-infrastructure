module "servicebus_namespace" {
  providers = {
    azurerm.private_endpoint = azurerm.private_endpoint
  }
  source              = "git@github.com:hmcts/terraform-module-servicebus-namespace?ref=4.x"
  name                = "${var.product}-${local.platform}-sb-${var.env}"
  location            = var.location
  sku                 = "Basic"
  resource_group_name = azurerm_resource_group.shared_resource_group.name
  env                 = var.env
  common_tags         = var.common_tags
  project             = local.platform
}

resource "azurerm_servicebus_queue" "recipes_service_bus_queue" {
  name                = "recipes"
  namespace_id        = module.servicebus_namespace.id
  default_message_ttl = "P1D" # 1 day
}

resource "azurerm_servicebus_queue" "plum_service_bus_queue" {
  name                = "plum"
  namespace_id        = module.servicebus_namespace.id
  default_message_ttl = "P1D" # 1 day
}

resource "azurerm_servicebus_queue" "toffee_service_bus_queue" {
  name                = "toffee"
  namespace_id        = module.servicebus_namespace.id
  default_message_ttl = "P1D" # 1 day
}

resource "azurerm_role_assignment" "recipes_servicebus_data_receiver" {
  principal_id         = module.vault.managed_identity_objectid[0]
  scope                = module.servicebus_namespace.id
  role_definition_name = "Azure Service Bus Data Receiver"
}

data "azurerm_user_assigned_identity" "keda" {
  name                = "keda-${var.env}-mi"
  resource_group_name = "managed-identities-${var.env}-rg"
}

resource "azurerm_role_assignment" "keda_servicebus_data_receiver" {
  principal_id         = data.azurerm_user_assigned_identity.keda.principal_id
  scope                = module.servicebus_namespace.id
  role_definition_name = "Azure Service Bus Data Receiver"
}


data "azuread_group" "platops" {
  display_name     = "DTS Platform Operations"
  security_enabled = true
}

resource "azurerm_role_assignment" "platops_servicebus_data_owner" {
  principal_id         = data.azuread_group.platops.object_id
  scope                = module.servicebus_namespace.id
  role_definition_name = "Azure Service Bus Data Owner"
}

