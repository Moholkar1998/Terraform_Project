# output "eks_cluster_name" {
#   value = module.eks.eks_cluster_name
# }

# output "jenkins_url" {
#   value = module.jenkins.jenkins_url
# }


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
