aws_region         = "us-east-1"
vpc_name           = "prod-ci-cd-vpc"
vpc_cidr           = "10.2.0.0/16"
azs                = ["us-east-1a", "us-east-1b", "us-east-1c"]
private_subnets    = ["10.2.1.0/24", "10.2.2.0/24", "10.2.3.0/24"]
public_subnets     = ["10.2.4.0/24", "10.2.5.0/24", "10.2.6.0/24"]
enable_nat_gateway = true
eks_cluster_name   = "prod-eks-cluster"
eks_cluster_version = "1.27"

node_groups = {
  prod-ci-cd-nodes = {
    desired_capacity = 3
    max_capacity     = 5
    min_capacity     = 2
    instance_type    = "t3.medium"
  }
}

jenkins_ami             = "ami-0a313d6098716f372"
jenkins_instance_type   = "t3.medium"
key_name                = "your-prod-key-pair"

iam_roles = {
  eks_worker = {
    assume_role_policy = <<EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "Service": "ec2.amazonaws.com"
          },
          "Action": "sts:AssumeRole"
        }
      ]
    }
    EOF
    policies = ["arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"]
  }
}

artifact_bucket_name = "prod-ci-cd-pipeline-artifacts"

tags = {
  Environment = "production"
  Project     = "ci-cd"
}
