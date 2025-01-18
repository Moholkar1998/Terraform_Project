variable "ami" {
  description = "AMI for Jenkins EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type for Jenkins EC2"
  type        = string
}

variable "security_groups" {
  description = "Security groups for the Jenkins EC2 instance"
  type        = list(string)
}

variable "key_name" {
  description = "Key pair name for EC2 instance"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID where the Jenkins EC2 instance will be launched"
  type        = string
}

variable "tags" {
  description = "Tags for Jenkins EC2 instance"
  type        = map(string)
  default     = {}
}
