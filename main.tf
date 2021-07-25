#------------------------------------------------------------
# Local configuration - Default (required). 
#------------------------------------------------------------

locals {
  resource_group_name  = element(coalescelist(data.azurerm_resource_group.rgrp.*.name, azurerm_resource_group.rg.*.name, [""]), 0)
  location             = element(coalescelist(data.azurerm_resource_group.rgrp.*.location, azurerm_resource_group.rg.*.location, [""]), 0)
  storage_account_name = element(coalescelist(azurerm_storage_account.storeacc.name, var.storage_account_name, [""]), 0)
}

#---------------------------------------------------------
# Resource Group Creation or selection - Default is "false"
#----------------------------------------------------------
data "azurerm_resource_group" "rgrp" {
  count = var.create_resource_group == false ? 1 : 0
  name  = var.resource_group_name
}

resource "azurerm_resource_group" "rg" {
  count    = var.create_resource_group ? 1 : 0
  name     = var.resource_group_name
  location = var.location
  tags     = merge({ "Name" = format("%s", var.resource_group_name) }, var.tags, )
}

#---------------------------------------------------------------
# Storage Account to keep logs and backups - Default is "false"
#----------------------------------------------------------------

resource "random_string" "str" {
  count   = var.enable_data_persistence ? 1 : 0
  length  = 6
  special = false
  upper   = false
  keepers = {
    name = local.storage_account_name
  }
}

resource "azurerm_storage_account" "storeacc" {
  #  for_each                  = var.redis_configuration != {} ? { for rdb_backup_enabled, v in var.redis_configuration : rdb_backup_enabled => v if v == true } : null
  count                     = var.enable_data_persistence ? 1 : 0
  name                      = var.storage_account_name == null ? "rediscachebkpstore${random_string.str.0.result}" : substr(var.storage_account_name, 0, 24)
  resource_group_name       = local.resource_group_name
  location                  = local.location
  account_kind              = "StorageV2"
  account_tier              = "Standard"
  account_replication_type  = "GRS"
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"
  tags                      = merge({ "Name" = format("%s", "stsqlauditlogs") }, var.tags, )
}

resource "azurerm_storage_container" "storcont" {
  count                 = var.enable_backup ? 1 : 0
  name                  = var.storage_container_name == null ? "appservice-backup" : var.storage_container_name
  storage_account_name  = data.azurerm_storage_account.storeacc.0.name
  container_access_type = "private"
}
