output "hbase_cluster_id" {
  description = "The ID of the HDInsight HBase Cluster"
  value       = module.hdinsight.hbase_cluster_id
}

output "hbase_cluster_https_endpoint" {
  description = "The HTTPS Connectivity Endpoint for this HDInsight HBase Cluster"
  value       = module.hdinsight.hbase_cluster_https_endpoint
}

output "hbase_cluster_ssh_endpoint" {
  description = "The SSH Connectivity Endpoint for this HDInsight HBase Cluster"
  value       = module.hdinsight.hbase_cluster_ssh_endpoint
}
