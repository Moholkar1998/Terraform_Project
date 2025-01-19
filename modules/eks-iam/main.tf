
resource "aws_iam_role_policy_attachment" "worker" {
  role       = aws_iam_role.eks_worker_role.name
  count = length(var.eks-worker-policy-arn)
  policy_arn = var.eks-worker-policy-arn[count.index]
}

resource "aws_iam_role_policy_attachment" "cluster" {
  role       = aws_iam_role.eks_cluster_role.name
  count = length(var.eks-cluster-policy-arn)
  policy_arn = var.eks-cluster-policy-arn[count.index]
}


#IAM Role specifically for EKS cluster
resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      }
    ]
  })
  tags = var.tags
}


resource "aws_iam_role" "eks_worker_role" {
  name = "eks-worker-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      }
    ]
  })

  tags = var.tags
}



