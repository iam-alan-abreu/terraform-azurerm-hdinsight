output "hadoop_cluster_id" {
  description = "The ID of the HDInsight Hadoop Cluster"
  value       = var.hdinsight_cluster_type == "hadoop" ? azurerm_hdinsight_hadoop_cluster.main.0.id : null
}

output "hadoop_cluster_https_endpoint" {
  description = "The HTTPS Connectivity Endpoint for this HDInsight Hadoop Cluster"
  value       = var.hdinsight_cluster_type == "hadoop" ? azurerm_hdinsight_hadoop_cluster.main.0.https_endpoint : null
}

output "hadoop_cluster_ssh_endpoint" {
  description = "The SSH Connectivity Endpoint for this HDInsight Hadoop Cluster"
  value       = var.hdinsight_cluster_type == "hadoop" ? azurerm_hdinsight_hadoop_cluster.main.0.ssh_endpoint : null
}

output "hbase_cluster_id" {
  description = "The ID of the HDInsight HBase Cluster"
  value       = var.hdinsight_cluster_type == "hbase" ? azurerm_hdinsight_hbase_cluster.main.0.id : null
}

output "hbase_cluster_https_endpoint" {
  description = "The HTTPS Connectivity Endpoint for this HDInsight HBase Cluster"
  value       = var.hdinsight_cluster_type == "hbase" ? azurerm_hdinsight_hbase_cluster.main.0.https_endpoint : null
}

output "hbase_cluster_ssh_endpoint" {
  description = "The SSH Connectivity Endpoint for this HDInsight HBase Cluster"
  value       = var.hdinsight_cluster_type == "hbase" ? azurerm_hdinsight_hbase_cluster.main.0.ssh_endpoint : null
}

output "kafka_cluster_id" {
  description = "The ID of the HDInsight Kafka Cluster"
  value       = var.hdinsight_cluster_type == "kafka" ? azurerm_hdinsight_kafka_cluster.main.0.id : null
}

output "kafka_cluster_https_endpoint" {
  description = "The HTTPS Connectivity Endpoint for this HDInsight Kafka Cluster"
  value       = var.hdinsight_cluster_type == "kafka" ? azurerm_hdinsight_kafka_cluster.main.0.https_endpoint : null
}

output "kafka_cluster_ssh_endpoint" {
  description = "The SSH Connectivity Endpoint for this HDInsight Kafka Cluster"
  value       = var.hdinsight_cluster_type == "kafka" ? azurerm_hdinsight_kafka_cluster.main.0.ssh_endpoint : null
}

output "spark_cluster_id" {
  description = "The ID of the HDInsight Spark Cluster"
  value       = var.hdinsight_cluster_type == "spark" ? azurerm_hdinsight_spark_cluster.main.0.id : null
}

output "spark_cluster_https_endpoint" {
  description = "The HTTPS Connectivity Endpoint for this HDInsight Spark Cluster"
  value       = var.hdinsight_cluster_type == "spark" ? azurerm_hdinsight_spark_cluster.main.0.https_endpoint : null
}

output "spark_cluster_ssh_endpoint" {
  description = "The SSH Connectivity Endpoint for this HDInsight Spark Cluster"
  value       = var.hdinsight_cluster_type == "spark" ? azurerm_hdinsight_spark_cluster.main.0.ssh_endpoint : null
}
