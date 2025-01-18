aws_region         = "us-east-1"
vpc_name           = "dev-ci-cd-vpc"
vpc_cidr           = "10.1.0.0/16"
azs                = ["us-east-1a", "us-east-1b"]
private_subnets    = ["10.1.1.0/24", "10.1.2.0/24"]
public_subnets     = ["10.1.3.0/24", "10.1.4.0/24"]
enable_nat_gateway = true
eks_cluster_name   = "dev-eks-cluster"
eks_cluster_version = "1.27"

node_groups = {
  dev-ci-cd-nodes = {
    desired_capacity = 1
    max_capacity     = 2
    min_capacity     = 1
    instance_type    = "t3.small"
  }
}

jenkins_ami             = "ami-0a313d6098716f372"
jenkins_instance_type   = "t3.micro"
key_name                = "your-dev-key-pair"

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

artifact_bucket_name = "dev-ci-cd-pipeline-artifacts"

tags = {
  Environment = "dev"
  Project     = "ci-cd"
}
