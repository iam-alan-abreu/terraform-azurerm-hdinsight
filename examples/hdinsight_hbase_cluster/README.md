# Azure HDInsight Terraform Module

Terraform module to create managed, full-spectrum, open-source analytics service Azure HDInsight. This module creates Apache Hadoop, Apache Spark, Apache HBase, Interactive Query (Apache Hive LLAP) and Apache Kafka clusters.

This example shows how to create an Apache HBase is an open-source, NoSQL database that is built on Apache Hadoop and modeled after Google BigTable. HBase provides random access and strong consistency for large amounts of data in a schemaless database. HBase is a schemaless database. The columns and data types can be undefined before using them. The open-source code scales linearly to handle petabytes of data on thousands of nodes. It can rely on data redundancy, batch processing, and other features that are provided by distributed applications in the Hadoop environment.

## Module Usage for HDInsight HBase Cluster

```hcl
# Azurerm Provider configuration
provider "azurerm" {
  features {
  }
}

module "hdinsight" {
  source  = "kumarvna/hdinsight/azurerm"
  version = "1.0.0"

  # By default, this module will not create a resource group. Location will be same as existing RG.
  # proivde a name to use an existing resource group, specify the existing resource group name, 
  # set the argument to `create_resource_group = true` to create new resrouce group.
  resource_group_name = "rg-shared-westeurope-01"
  location            = "westeurope"

  # The type of hdinsight cluster to create 
  # Valid values are `hadoop`, `hbase`, `interactive_query`, `kafka`, `spark`.
  hdinsight_cluster_type = "hbase"

  # Hdinsight HBase cluster configuration. Gateway credentials must be different from the one used 
  # for the `head_node`, `worker_node` and `zookeeper_node` roles.
  hbase_cluster = {
    name             = "hbasedemocluster1"
    cluster_version  = "3.6"
    gateway_username = "acctestusrgw"
    gateway_password = "TerrAform123!"
    hbase_version    = "1.1"
    tier             = "Standard"
  }

  # Node configuration
  # Either a password or one or more ssh_keys must be specified - but not both.
  # Password must be at least 10 characters in length and must contain digits,uppercase, 
  # lower case letters and non-alphanumeric characters  
  hbase_roles = {
    vm_username = "acctestusrvm"
    vm_password = "AccTestvdSC4daf986!"
    head_node = {
      vm_size = "Standard_D3_V2"
    }
    worker_node = {
      vm_size               = "Standard_D3_V2"
      target_instance_count = 3
    }
    zookeeper_node = {
      vm_size = "Standard_D3_V2"
    }
  }

  # Use Azure Monitor logs to monitor HDInsight clusters. Recommended to place both the HDInsight 
  # cluster and the Log Analytics workspace in the same region for better performance.
  enable_hbase_monitoring      = true
  log_analytics_workspace_name = "loganalytics-we-sharedtest2"

  # Tags for Azure Resources
  tags = {
    Terraform   = "true"
    Environment = "dev"
    Owner       = "test-user"
  }
}
```

## Terraform Usage

To run this example you need to execute following Terraform commands

```hcl
terraform init
terraform plan
terraform apply
```

Run `terraform destroy` when you don't need these resources.
