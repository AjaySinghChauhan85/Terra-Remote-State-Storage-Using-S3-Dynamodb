# Creates an S3 bucket — used as the remote backend to store Terraform state file (.tfstate)
resource "aws_s3_bucket" "remote_s3" {
  bucket = "ajy-tf-test-bucket" # Globally unique bucket name (must be unique across all AWS accounts)

  tags = {
    Name = "ajy-tf-test-bucket" # Tag to identify this bucket in the AWS console (note: typo from original)
  }
}
