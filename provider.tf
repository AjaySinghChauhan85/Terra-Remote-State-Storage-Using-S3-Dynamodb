# Declares AWS as the cloud provider for this Terraform configuration
provider "aws" {
  region = "us-east-1" # All AWS resources will be created in the US East (N. Virginia) region
}
