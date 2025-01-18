terraform {
  backend "s3" {
    bucket         = "your-dev-terraform-state-bucket" # Replace with your S3 bucket name
    key            = "terraform/state/dev/terraform.tfstate"
    region         = "us-east-1" # Replace with your AWS region
    encrypt        = true
    dynamodb_table = "your-dev-terraform-lock-table" # Replace with your DynamoDB table name for locking
  }
}
