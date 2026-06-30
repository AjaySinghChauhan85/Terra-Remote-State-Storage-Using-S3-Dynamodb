variable "env" {
  description = "This is Environment for my infra"
  type        = string
}

variable "bucket_name" {
  description = "This is the bucket name for my infra"
  type        = string
}

variable "instance_count" {
  description = "This is a number of ec2 instance"
  type        = number
}

variable "instance_type" {
  description = "This is ec2 instance type"
  type        = string
}

variable "ec2_ami_id" {
  description = "This is ec2 instance ami id"
}

variable "ec2_default_root_storage" {
  description = "The root stroage volume for ec2 instance"
  type        = number
}

variable "hash_key" {
  description = "The hash id for dynamodb "
  type        = string

}

variable "terra_dynamodb_table" {
  description = "This is the  dynamodb name "
  type        = string
}
