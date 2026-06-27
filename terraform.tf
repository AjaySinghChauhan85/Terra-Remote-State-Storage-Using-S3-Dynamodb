# Terraform settings block — defines version constraints and required providers
terraform {
  required_providers {
    aws = {                          # Declaring AWS as a required provider
      source  = "hashicorp/aws"      # Official HashiCorp AWS provider from the Terraform registry
      version = "~> 6.0"             # Use any version >= 6.0 and < 7.0 (compatible with 6.x)
    }
  }
}