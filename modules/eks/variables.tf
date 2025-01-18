variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_role_arn" {
  description = "IAM Role ARN for the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "EKS Cluster version"
  type        = string
  default     = "1.27"  # Example default
}

variable "subnets" {
  description = "List of subnet IDs for EKS"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for the EKS cluster"
  type        = list(string)
}

variable "node_groups" {
  description = "Map of node groups with configurations"
  type = map(object({
    node_role_arn   = string
    instance_types  = list(string)
    desired_capacity = number
    max_capacity     = number
    min_capacity     = number
  }))
}

variable "tags" {
  description = "Tags for EKS resources"
  type        = map(string)
  default     = {}
}
