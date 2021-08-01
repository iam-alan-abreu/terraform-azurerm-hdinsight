# Azurerm Provider configuration
provider "azurerm" {
  features {
  }
}

module "hdinsight" {
  //  source  = "kumarvna/hdinsight/azurerm"
  //  version = "1.0.0"
  source = "../../"

  # By default, this module will not create a resource group. Location will be same as existing RG.
  # proivde a name to use an existing resource group, specify the existing resource group name, 
  # set the argument to `create_resource_group = true` to create new resrouce group.
  resource_group_name = "rg-shared-westeurope-01"
  location            = "westeurope"

  # The type of hdinsight cluster to create 
  # Valid values are `hadoop`, `hbase`, `interactive-query`, `kafka`, `spark`.
  hdinsight_cluster_type = "hadoop"

  # Hdinsight hadoop cluster configuration
  # gateway credentials must be different from the one used for the `head_node`, `worker_node` and `zookeeper_node` roles.
  hadoop_cluster = {
    name             = "hadoopdemocluster1"
    cluster_version  = "3.6"
    gateway_username = "acctestusrgw"
    gateway_password = "TerrAform123!"
    hadoop_version   = "2.7"
    tier             = "Standard"
  }

  # Node configuration
  # Either a password or one or more ssh_keys must be specified - but not both.
  # Password must be at least 10 characters in length and must contain digits,uppercase, lower case letters and non-alphanumeric characters 
  hadoop_roles = {
    vm_username = "acctestusrvm"
    vm_password = "AccTestvdSC4daf986!"
    head_node = {
      vm_size = "Standard_D3_V2"
    }
    worker_node = {
      vm_size               = "Standard_D4_V2"
      target_instance_count = 3
      autoscale = {
        capacity = {
          max_instance_count = 4
          min_instance_count = 3
        }
      }
    }
    zookeeper_node = {
      vm_size = "Standard_D3_V2"
    }
  }

  # Use Azure Monitor logs to monitor HDInsight clusters
  # Recommended to place both the HDInsight cluster and the Log Analytics workspace in the same region for better performance
  enable_hadoop_monitoring     = true
  log_analytics_workspace_name = "loganalytics-we-sharedtest2"
}
