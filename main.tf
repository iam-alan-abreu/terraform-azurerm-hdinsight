#------------------------------------------------------------
# Local configuration - Default (required). 
#------------------------------------------------------------

locals {
  resource_group_name = element(coalescelist(data.azurerm_resource_group.rgrp.*.name, azurerm_resource_group.rg.*.name, [""]), 0)
  location            = element(coalescelist(data.azurerm_resource_group.rgrp.*.location, azurerm_resource_group.rg.*.location, [""]), 0)
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
  count   = var.storage_account_name == null ? 1 : 0
  length  = 6
  special = false
  upper   = false
  keepers = {
    name = local.resource_group_name
  }
}

resource "azurerm_storage_account" "storeacc" {
  name                      = var.storage_account_name == null ? "hdinsightstorage${random_string.str.0.result}" : substr(var.storage_account_name, 0, 24)
  resource_group_name       = local.resource_group_name
  location                  = local.location
  account_kind              = var.storage_account.account_kind
  account_tier              = var.storage_account.account_tier
  account_replication_type  = var.storage_account.account_replication_type
  enable_https_traffic_only = var.storage_account.enable_https_traffic_only
  min_tls_version           = var.storage_account.min_tls_version
  tags                      = merge({ "Name" = var.storage_account_name == null ? "hdinsightstorage${random_string.str.0.result}" : substr(var.storage_account_name, 0, 24) }, var.tags, )
}

resource "azurerm_storage_container" "storcont" {
  name                  = var.storage_container_name == null ? "hdinsightstore" : var.storage_container_name
  storage_account_name  = azurerm_storage_account.storeacc.name
  container_access_type = var.storage_account.container_access_type
}

resource "azurerm_hdinsight_hadoop_cluster" "main" {
  for_each            = var.hadoop_cluster != null ? { for k, v in var.hadoop_cluster : k => v if v != null } : {}
  name                = each.key
  resource_group_name = local.resource_group_name
  location            = local.location
  cluster_version     = each.value.cluster_version
  tier                = each.value.tier
  tls_min_version     = each.value.tls_min_version

  component_version {
    hadoop = each.value.hadoop_version
  }

  gateway {
    enabled  = true
    username = each.value.gateway_username
    password = each.value.gateway_password
  }

  roles {
    dynamic "head_node" {
      for_each = var.roles != null ? [var.roles] : []
      content {
        username           = var.roles.vm_username
        password           = var.roles.vm_password
        ssh_keys           = file(var.roles.ssh_key_file)
        subnet_id          = var.roles.head_node_subnet_id
        virtual_network_id = var.roles.head_node_vnet_id
      }
    }
    worker_node {

    }

    zookeeper_node {

    }
    edge_node {

    }

  }

}

variable "hadoop_cluster" {
  demohadoopcluster = {
    type = map(object({
      cluster_version  = string
      tier             = string
      tls_min_version  = optional(string)
      hadoop_version   = string
      gateway_username = string
      gateway_password = string
    }))
  }
}

variable "head_node" {
  type = object({

  })

}
