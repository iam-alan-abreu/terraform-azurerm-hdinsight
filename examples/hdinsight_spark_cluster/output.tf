output "spark_cluster_id" {
  description = "The ID of the HDInsight Spark Cluster"
  value       = module.hdinsight.spark_cluster_id
}

output "spark_cluster_https_endpoint" {
  description = "The HTTPS Connectivity Endpoint for this HDInsight Spark Cluster"
  value       = module.hdinsight.spark_cluster_https_endpoint
}

output "spark_cluster_ssh_endpoint" {
  description = "The SSH Connectivity Endpoint for this HDInsight Spark Cluster"
  value       = module.hdinsight.spark_cluster_ssh_endpoint
}
