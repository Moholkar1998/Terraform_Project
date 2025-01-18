output "eks_cluster_name" {
  value = module.eks.eks_cluster_name
}

output "jenkins_url" {
  value = module.jenkins.jenkins_url
}

output "iam_role_names" {
  value = module.iam.iam_role_names
}

output "eks_cluster_role_arn" {
  value = module.iam.eks_cluster_role_arn
}

output "eks_worker_role_arn" {
  value = module.iam.eks_worker_role_arn
}
