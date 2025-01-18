resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn
  vpc_config {
    subnet_ids = var.subnets
    security_group_ids = var.security_group_ids
  }

  # EKS Cluster version and other settings can be passed from variables
  version = var.cluster_version

  tags = var.tags
}

resource "aws_eks_node_group" "this" {
  for_each = var.node_groups

  cluster_name    = aws_eks_cluster.this.name
  node_group_name = each.key
  node_role_arn   = each.value.node_role_arn
  subnet_ids      = var.subnets
  instance_types  = each.value.instance_types

  scaling_config {
    desired_size = each.value.desired_capacity
    max_size     = each.value.max_capacity
    min_size     = each.value.min_capacity
  }

  tags = merge(var.tags, { Name = "eks-node-group-${each.key}" })
}