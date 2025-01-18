terraform {
  backend "s3" {
    bucket         = "your-prod-terraform-state-bucket" # Replace with your S3 bucket name
    key            = "terraform/state/prod/terraform.tfstate"
    region         = "us-east-1" # Replace with your AWS region
    encrypt        = true
    dynamodb_table = "your-prod-terraform-lock-table" # Replace with your DynamoDB table name for locking
  }
}
