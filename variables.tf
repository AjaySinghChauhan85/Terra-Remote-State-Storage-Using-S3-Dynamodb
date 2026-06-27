# Variable for EC2 instance type — defines the hardware size of the virtual machine
variable "ec2_instance-type" {
  default = "t2.micro" # Free-tier eligible instance type (1 vCPU, 1 GB RAM)
  type    = string     # Value must be a string
}

# Variable for the root EBS volume size in GB
variable "ec2_default_root_storage" {
  default = 15   # Default root disk size is 15 GB
  type    = number # Value must be a number
}

# Variable for the Amazon Machine Image (AMI) ID — defines the OS for the EC2 instance
variable "ec2_ami_id" {
  default = "ami-0a5c3558529277641" # Amazon Linux 2 AMI in us-east-1
  type    = string                  # Value must be a string
}

variable "env" {
    default = "dev"
    type = string
}