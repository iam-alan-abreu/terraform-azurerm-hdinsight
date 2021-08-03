output "interactive_query_cluster_id" {
  description = "The ID of the HDInsight Interactive Query Cluster"
  value       = module.hdinsight.interactive_query_cluster_id
}

output "interactive_query_cluster_https_endpoint" {
  description = "The HTTPS Connectivity Endpoint for this HDInsight Interactive Query Cluster"
  value       = module.hdinsight.interactive_query_cluster_https_endpoint
}

output "interactive_query_cluster_ssh_endpoint" {
  description = "The SSH Connectivity Endpoint for this HDInsight Interactive Query Cluster"
  value       = module.hdinsight.interactive_query_cluster_ssh_endpoint
}
