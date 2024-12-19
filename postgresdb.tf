module "postgresql_flexible" {
  providers = {
    azurerm.postgres_network = azurerm.postgres_network
  }

  source        = "git@github.com:hmcts/terraform-module-postgresql-flexible?ref=master"
  env           = var.env
  product       = var.product
  name          = "${var.product}-flexible"
  component     = ""
  business_area = "CFT"
  location      = var.location
  subnet_suffix = "expanded"

  common_tags          = var.common_tags
  admin_user_object_id = var.jenkins_AAD_objectId
  pgsql_databases = [
    {
      name : "plum"
    },
    {
      name : "toffee"
    }
  ]

  pgsql_version = "16"
  pgsql_sku     = var.pgsql_sku
}

resource "azurerm_key_vault_secret" "POSTGRES-USER" {
  name         = "recipe-backend-POSTGRES-USER"
  value        = module.postgresql_flexible.username
  key_vault_id = module.vault.key_vault_id
}

resource "azurerm_key_vault_secret" "POSTGRES-PASS" {
  name         = "recipe-backend-POSTGRES-PASS"
  value        = module.postgresql_flexible.password
  key_vault_id = module.vault.key_vault_id
}

resource "azurerm_key_vault_secret" "POSTGRES_HOST" {
  name         = "recipe-backend-POSTGRES-HOST"
  value        = module.postgresql_flexible.fqdn
  key_vault_id = module.vault.key_vault_id
}

resource "azurerm_key_vault_secret" "POSTGRES_PORT" {
  name         = "recipe-backend-POSTGRES-PORT"
  value        = "5432"
  key_vault_id = module.vault.key_vault_id
}

resource "azurerm_key_vault_secret" "POSTGRES_DATABASE_CFT" {
  name         = "recipe-backend-POSTGRES-DATABASE_CFT"
  value        = "plum"
  key_vault_id = module.vault.key_vault_id
}

resource "azurerm_key_vault_secret" "POSTGRES_DATABASE_SDS" {
  name         = "recipe-backend-POSTGRES-DATABASE_SDS"
  value        = "toffee"
  key_vault_id = module.vault.key_vault_id
}
