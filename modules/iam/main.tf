resource "aws_iam_role" "this" {
  for_each = var.iam_roles
  name = each.key
  assume_role_policy = each.value.assume_role_policy
  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = var.iam_roles

  role       = aws_iam_role.this[each.key].name
  policy_arn = each.value.policies[0]  # Access the first policy in the list
}

# IAM Role specifically for EKS cluster
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



