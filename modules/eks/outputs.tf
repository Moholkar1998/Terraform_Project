output "eks_cluster_name" {
  description = "The name of the EKS cluster"
  value       = aws_eks_cluster.this.name
}

output "eks_cluster_endpoint" {
  description = "The endpoint of the EKS cluster"
  value       = aws_eks_cluster.this.endpoint
}

output "eks_node_group_names" {
  description = "The node group names"
  value       = [for node_group in aws_eks_node_group.this : node_group.node_group_name]
}
