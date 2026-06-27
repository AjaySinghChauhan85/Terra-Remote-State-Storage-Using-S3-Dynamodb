# Terraform settings block — defines version constraints and required providers
terraform {

  # Declares all providers that this configuration depends on
  required_providers {
    aws = {                          # Declaring AWS as a required provider
      source  = "hashicorp/aws"      # Official HashiCorp AWS provider from the Terraform registry
      version = "~> 6.0"             # Use any version >= 6.0 and < 7.0 (compatible with 6.x)
    }
  }

  # Configures remote state storage — Terraform will store the tfstate file in S3 instead of locally
  backend "s3" {
    bucket       = "ajy-tf-test-bucket" # Name of the S3 bucket where the state file will be stored
    key          = "terraform.tfstate"  # Path/filename of the state file inside the bucket
    region       = "us-east-1"          # AWS region where the S3 bucket is located
    use_lockfile = true                 # Enables native S3 state locking (Terraform v1.10+), prevents concurrent runs
  }
}
