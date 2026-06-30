# Creates an S3 bucket — used as the remote backend to store Terraform state file (.tfstate)
resource "aws_s3_bucket" "remote_s3" {
  bucket = "${var.env}-${var.bucket_name}" # Globally unique bucket name (must be unique across all AWS accounts)

  tags = {
    Name        = "${var.env}-${var.bucket_name}" # Tag to identify this bucket in the AWS console (note: typo from original)
    Environment = var.env
  }
}
