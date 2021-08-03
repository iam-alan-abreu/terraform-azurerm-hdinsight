output "kafka_cluster_id" {
  description = "The ID of the HDInsight Kafka Cluster"
  value       = module.hdinsight.kafka_cluster_id
}

output "kafka_cluster_https_endpoint" {
  description = "The HTTPS Connectivity Endpoint for this HDInsight Kafka Cluster"
  value       = module.hdinsight.kafka_cluster_https_endpoint
}

output "kafka_cluster_ssh_endpoint" {
  description = "The SSH Connectivity Endpoint for this HDInsight Kafka Cluster"
  value       = module.hdinsight.kafka_cluster_ssh_endpoint
}
