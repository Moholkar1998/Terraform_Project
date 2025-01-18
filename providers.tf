# AWS Provider
provider "aws" {
  region = var.aws_region
}

# Optionally add other providers if required
# For example, for Kubernetes or Helm:
# provider "kubernetes" {
#   config_path = "~/.kube/config"
# }

# provider "helm" {
#   kubernetes {
#     config_path = "~/.kube/config"
#   }
# }
