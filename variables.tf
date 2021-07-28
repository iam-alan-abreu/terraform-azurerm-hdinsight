variable "create_resource_group" {
  description = "Whether to create resource group and use it for all networking resources"
  default     = false
}

variable "resource_group_name" {
  description = "A container that holds related resources for an Azure solution"
  default     = ""
}

variable "location" {
  description = "The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
  default     = ""
}

variable "storage_account_name" {
  description = "The name of the storage account"
  default     = null
}

variable "storage_container_name" {
  description = "The name of the storage container"
  default     = null
}

variable "storage_account" {
  type = object({
    account_kind              = string
    account_tier              = string
    account_replication_type  = string
    enable_https_traffic_only = bool
    min_tls_version           = string
    container_access_type     = string
  })
  description = "Manages an Azure Storage Account"
  default = {
    account_kind              = "StorageV2"
    account_tier              = "Standard"
    account_replication_type  = "GRS"
    enable_https_traffic_only = true
    min_tls_version           = "TLS1_2"
    container_access_type     = "private"
  }
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
