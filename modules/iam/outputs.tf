output "iam_role_names" {
  description = "The IAM role names"
  value       = [for role in aws_iam_role.this : role.name]
}

output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
  description = "ARN of the EKS cluster role"
}

output "eks_worker_role_arn" {
  value       = aws_iam_role.eks_worker_role.arn
  description = "ARN of the EKS worker role"
}