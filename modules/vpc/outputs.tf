output "vpc_id" {
  description = "The VPC ID"
  value       = aws_vpc.this.id
}

output "private_subnets" {
  description = "List of private subnet IDs"
  value       = aws_subnet.private[*].id
}

output "public_subnets" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "default_security_group" {
  description = "The default security group for the VPC"
  value       = aws_vpc.this.default_security_group_id
}