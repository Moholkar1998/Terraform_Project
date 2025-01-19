variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "vpc_name" {
  description = "Name of the VPC"
  default     = "ci-cd-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "Availability zones"
  default     = ["us-east-1a", "us-east-1b"]
}

variable "private_subnets" {
  description = "Private subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnets" {
  description = "Public subnets"
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway"
  default     = true
}

variable "eks_cluster_name" {
  description = "EKS cluster name"
  default     = "ci-cd-cluster"
}

variable "eks_cluster_version" {
  description = "EKS cluster version"
  default     = "1.27"
}

variable "node_groups" {
  description = "EKS node groups"
  type = map(object({
    desired_capacity = number
    max_capacity     = number
    min_capacity     = number
    instance_types   = list(string)
  }))
  
  default = {
    "default-node-group" = {
      desired_capacity = 1
      max_capacity     = 2
      min_capacity     = 1
      instance_types   = ["t3.medium"]
    }
  }
}



variable "jenkins_ami" {
  description = "AMI for Jenkins EC2 instance"
  default     = "ami-0a313d6098716f372" # Amazon Linux 2
}

variable "jenkins_instance_type" {
  description = "Instance type for Jenkins EC2"
  default     = "t2.micro"
}

variable "key_name" {
  description = "Key pair name for EC2 instance"
  default     = "Terraform"
}

variable "eks-worker-policy-arn" {
  type = list(string)
  default = [ "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly", 
             "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
             "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"]
  
}
variable "eks-cluster-policy-arn" {
  type = list(string)
  default = [ "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
        "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"]
  
}

variable "artifact_bucket_name" {
  description = "Name of the S3 bucket for artifacts"
  default     = "ci-cd-pipeline-artifacts"
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default     = {
    Environment = "default"
    Project     = "ci-cd"
  }
}