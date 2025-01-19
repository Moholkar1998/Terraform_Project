# output "eks_cluster_name" {
#   value = module.eks.eks_cluster_name
# }

# output "jenkins_url" {
#   value = module.jenkins.jenkins_url
# }

output "vpc_id" {
  description = "The VPC ID"
  value       = module.vpc.vpc_id
}

output "private_subnets" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnets
}

output "eks_cluster_role_arn" {
  value = module.eks-iam.eks_cluster_role_arn
}

output "eks_worker_role_arn" {
  value = module.eks-iam.eks_worker_role_arn
}

# output "eks_cluster_endpoint" {
#   value       = module.eks.eks_cluster_endpoint
#   description = "The endpoint of the EKS cluster"
# }
