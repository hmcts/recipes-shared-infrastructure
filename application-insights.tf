module "application_insights" {
  source = "git@github.com:hmcts/terraform-module-application-insights?ref=4.x"

  env     = var.env
  product = var.product
  name    = "${var.product}-${local.platform}"

  resource_group_name = azurerm_resource_group.shared_resource_group.name

  common_tags = var.common_tags

  daily_data_cap_in_gb = var.daily_data_cap_in_gb
  alert_limit_reached  = true
}

resource "azurerm_key_vault_secret" "appInsights-InstrumentationKey" {
  name         = "appInsights-InstrumentationKey"
  value        = module.application_insights.instrumentation_key
  key_vault_id = module.vault.key_vault_id
}
