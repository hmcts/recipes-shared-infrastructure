# REDIS CACHE TESTING
module "recipes-redis-storage" {
  source                          = "git@github.com:hmcts/cnp-module-redis?ref=DTSPO-17012-data-persistency"
  product                         = "${var.product}-${var.component}-session-storage"
  location                        = var.location
  env                             = var.env
  private_endpoint_enabled        = true
  redis_version                   = "6"
  business_area                   = "cft"
  public_network_access_enabled   = false
  common_tags                     = var.common_tags
  sku_name                        = var.sku_name
  family                          = var.family
  capacity                        = var.redis_capacity
  rdb_backup_enabled              = var.rdb_backup_enabled
  rdb_backup_frequency            = var.redis_backup_frequency
  rdb_backup_max_snapshot_count   = var.rdb_backup_max_snapshot_count
  rdb_storage_account_name_prefix = var.product
}
