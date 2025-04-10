module "postgresql_flexible" {
  providers = {
    azurerm.postgres_network = azurerm.postgres_network
  }

  source              = "git@github.com:hmcts/terraform-module-postgresql-flexible?ref=master"
  env                 = var.env
  product             = var.product
  name                = "${var.product}-${local.platform}-flexible"
  component           = ""
  business_area       = local.platform
  location            = var.location
  subnet_suffix       = "expanded"
  resource_group_name = azurerm_resource_group.shared_resource_group.name

  common_tags          = var.common_tags
  admin_user_object_id = var.jenkins_AAD_objectId
  pgsql_databases = [
    {
      name : "recipes"
    }
  ]

  pgsql_version = "16"
  pgsql_sku     = var.pgsql_sku
}

resource "azurerm_key_vault_secret" "POSTGRES-USER" {
  name         = "recipes-backend-POSTGRES-USER"
  value        = module.postgresql_flexible.username
  key_vault_id = module.vault.key_vault_id
}

resource "azurerm_key_vault_secret" "POSTGRES-PASS" {
  name         = "recipes-backend-POSTGRES-PASS"
  value        = module.postgresql_flexible.password
  key_vault_id = module.vault.key_vault_id
}

resource "azurerm_key_vault_secret" "POSTGRES_HOST" {
  name         = "recipes-backend-POSTGRES-HOST"
  value        = module.postgresql_flexible.fqdn
  key_vault_id = module.vault.key_vault_id
}

resource "azurerm_key_vault_secret" "POSTGRES_PORT" {
  name         = "recipes-backend-POSTGRES-PORT"
  value        = "5432"
  key_vault_id = module.vault.key_vault_id
}

resource "azurerm_key_vault_secret" "POSTGRES_DATABASE" {
  name         = "recipes-backend-POSTGRES-DATABASE"
  value        = "recipes"
  key_vault_id = module.vault.key_vault_id
}
