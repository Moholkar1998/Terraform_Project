# # VPC Module
# module "vpc" {
#   source            = "./modules/vpc"
#   vpc_name              = var.vpc_name
#   cidr              = var.vpc_cidr
#   azs               = var.azs
#   private_subnets   = var.private_subnets
#   public_subnets    = var.public_subnets
#   enable_nat_gateway = var.enable_nat_gateway
#   tags               = var.tags
# }

# IAM Module - Pass IAM Role for EKS cluster
module "eks-iam" {
  source = "./modules/eks-iam"
  eks-worker-policy-arn = var.eks-worker-policy-arn
  eks-cluster-policy-arn = var.eks-cluster-policy-arn
}

# # EKS Module
# module "eks" {
#   source          = "./modules/eks"
#   cluster_name    = var.eks_cluster_name
#   cluster_version = var.eks_cluster_version
#   subnets         = module.vpc.private_subnets
#   security_group_ids = [module.vpc.default_security_group]

#   node_groups = {
#     for key, value in var.node_groups : 
#     key => merge(value, {
#       node_role_arn = module.iam.eks_worker_role_arn  # Dynamically assign the node role ARN
#     })
#   }

#   cluster_role_arn  = module.iam.eks_cluster_role_arn
#   tags              = var.tags
# }

# # Jenkins Module
# module "jenkins" {
#   source          = "./modules/jenkins"
#   ami             = var.jenkins_ami
#   instance_type   = var.jenkins_instance_type
#   key_name        = var.key_name
#   vpc_id          = module.vpc.vpc_id
#   subnet_id       = element(module.vpc.public_subnets, 0)
#   tags            = var.tags
# }


# # S3 Bucket for Artifacts
# resource "aws_s3_bucket" "ci_cd_artifacts" {
#   bucket = var.artifact_bucket_name
#   tags   = var.tags
# }