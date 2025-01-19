variable "eks-worker-policy-arn" {
  type = list(string)
}

variable "eks-cluster-policy-arn" {
  type = list(string)
}

variable "tags" {
  description = "Tags for IAM roles"
  type        = map(string)
  default     = {}
}
