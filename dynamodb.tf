# Creates a DynamoDB table — used for Terraform state locking to prevent concurrent modifications
resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name         = "${var.env}-${var.terra_dynamodb_table}" # Table name referenced in the backend config of the main project
  billing_mode = "PAY_PER_REQUEST"                        # On-demand billing — charges only for actual read/write requests (no capacity planning)
  hash_key     = var.hash_key                             # Primary key attribute — Terraform writes the lock here during operations

  # Defines the schema for the LockID attribute (must match hash_key above)
  attribute {
    name = var.hash_key # Attribute name — Terraform uses this key to store the state lock identifier
    type = "S"          # "S" = String type (Terraform lock ID is always a string)
  }

  tags = {
    Name        = "${var.env}-${var.terra_dynamodb_table}" # Tag to identify this table in the AWS console
    Environment = var.env
  }
}
