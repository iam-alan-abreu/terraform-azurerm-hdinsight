output "hadoop_cluster_id" {
  description = "The ID of the HDInsight Hadoop Cluster"
  value       = module.hdinsight.hadoop_cluster_id
}

output "hadoop_cluster_https_endpoint" {
  description = "The HTTPS Connectivity Endpoint for this HDInsight Hadoop Cluster"
  value       = module.hdinsight.hadoop_cluster_https_endpoint
}

output "hadoop_cluster_ssh_endpoint" {
  description = "The SSH Connectivity Endpoint for this HDInsight Hadoop Cluster"
  value       = module.hdinsight.hadoop_cluster_ssh_endpoint
}
