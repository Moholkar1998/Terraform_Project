# Terraform Project: CI/CD Pipeline

This project demonstrates the use of Terraform to provision infrastructure for a CI/CD pipeline on AWS. The infrastructure includes resources like VPC, EKS, EC2, and S3, modularized for reusability and scalability.

## Project Structure

The repository is organized as follows:

```
terraform/
├── modules/
│ ├── vpc/
│ │ ├── main.tf
│ │ ├── variables.tf
│ │ ├── outputs.tf
│ ├── eks/
│ │ ├── main.tf
│ │ ├── variables.tf
│ │ ├── outputs.tf
│ ├── ec2/
│ │ ├── main.tf
│ │ ├── variables.tf
│ │ ├── outputs.tf
│ └── s3/
│ ├── main.tf
│ ├── variables.tf
│ ├── outputs.tf
├── environments/
│ ├── dev.tfvars
│ └── prod.tfvars
├── backend/
│ ├── dev-backend.tf
│ └── prod-backend.tf
├── main.tf
├── variables.tf
├── providers.tf
└── outputs.tf
```

## Prerequisites

Before starting, ensure you have the following installed:

- Terraform (>= 1.0)
- AWS CLI
- AWS credentials configured

### Set AWS Credentials

Run the following command to configure AWS credentials:

Provide the following information when prompted:

- AWS Access Key ID
- AWS Secret Access Key
- Default region name (e.g., `us-east-1`)
- Default output format (optional, e.g., `json`)

To verify credentials:
aws sts get-caller-identity

Terraform: Install Terraform from Terraform's official website.

## Getting Started

### Step 1: Initialize Terraform Backend

Create S3 Buckets for State Storage:

- Create an S3 bucket for each environment (e.g., your-dev-terraform-state-bucket and your-prod-terraform-state-bucket).
- Enable versioning on the buckets.

Create DynamoDB Tables for State Locking:

- Create a DynamoDB table for each environment (e.g., your-dev-terraform-lock-table and your-prod-terraform-lock-table).
- Use LockID as the primary key for the table.

Initialize Terraform:
Navigate to the backend configuration directory and initialize Terraform with environment-specific backend files.

For development:

- cd terraform/backend
- terraform init -backend-config=dev-backend.tf

For production:

- cd terraform/backend
- terraform init -backend-config=prod-backend.tf

### Step 2: Plan and Apply the Configuration

#### For Development Environment:

Run the following commands:

terraform -chdir="E:\DevOps\Projects\Terraform" plan -var-file="./environments/dev.tfvars"

#### For Production Environment:

Run the following commands:
terraform -chdir="E:\DevOps\Projects\Terraform" plan -var-file="./environments/prod.tfvars"

## Modules Overview

### Files:

- main.tf: Contains resource definitions.
- variables.tf: Defines input variables for the module.
- outputs.tf: Outputs the created resources.

### VPC Module

The VPC module provisions the following resources:

- VPC
- Public and private subnets
- NAT gateway (if enabled)
- Internet gateway

### EKS Module

This module provisions an EKS cluster and its node groups.

### EC2 Module

This module provisions EC2 instances for Jenkins.

### S3 Module

This module provisions an S3 bucket for storing artifacts.

## Inputs and Outputs

### Global Variables

- Defined in the root variables.tf file. Examples include:
- aws_region: The AWS region to deploy resources.
- key_name: Name of the key pair for EC2 instances.
- artifact_bucket_name: Name of the S3 bucket for artifacts.

### Environment-Specific Variables

- Defined in environments/dev.tfvars and environments/prod.tfvars. Examples include:
- vpc_name: Name of the VPC.
- eks_cluster_name: Name of the EKS cluster.

### Outputs

- Defined in the root outputs.tf file and module-specific outputs.tf files. Examples include:
- eks_cluster_name: Name of the created EKS cluster.
- jenkins_url: URL of the Jenkins server.

## License

This project is licensed under the MIT License.

## Contributing

Contributions are welcome! Please follow the standard GitHub Flow when submitting changes.

## Support

For any questions or issues, please open an issue in this repository.
