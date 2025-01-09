# REDIS CACHE TESTING
module "recipes-redis-storage" {
  source                          = "git@github.com:hmcts/cnp-module-redis?ref=DTSPO-17012-data-persistency-4.x"
  product                         = "${var.product}-${local.platform}-session-storage"
  location                        = var.location
  env                             = var.env
  private_endpoint_enabled        = true
  redis_version                   = "6"
  business_area                   = local.platform
  public_network_access_enabled   = false
  common_tags                     = var.common_tags
  sku_name                        = var.sku_name
  family                          = var.family
  capacity                        = var.redis_capacity
  rdb_backup_enabled              = var.rdb_backup_enabled
  rdb_backup_frequency            = var.redis_backup_frequency
  rdb_backup_max_snapshot_count   = var.rdb_backup_max_snapshot_count
  rdb_storage_account_name_prefix = var.product
  resource_group_name             = azurerm_resource_group.shared_resource_group.name
  maxmemory_reserved              = "125"
  maxfragmentationmemory_reserved = "125"
  maxmemory_delta                 = "125"
}



