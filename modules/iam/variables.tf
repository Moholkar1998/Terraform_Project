variable "iam_roles" {
  description = "IAM roles for various services"
  type = map(object({
    assume_role_policy = string
    policies           = list(string)
  }))
}

variable "tags" {
  description = "Tags for IAM roles"
  type        = map(string)
  default     = {}
}
