# Creates an SSH key pair in AWS using a local public key file
resource "aws_key_pair" "my-key" {
  key_name   = "${var.env}-terra-key-ec2"           # Name of the key pair as it will appear in AWS
  public_key = file("terra-key-ec2.pub") # Reads the public key from the local file
  tags = {
    Environment = var.env
  }
}

# References the existing default VPC in the AWS account (every account has one)
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC" # Tag to identify this VPC in the AWS console
  }
}

# Creates a Security Group — acts as a virtual firewall for the EC2 instances
resource "aws_security_group" "my_security_group" {
  name        = "${var.env}-automatic-sg"                                       # Name of the security group
  description = "Allow TLS inbound traffic and all outbound traffic" # Description shown in AWS console
  vpc_id      = aws_default_vpc.default.id                           # Attaches this SG to the default VPC (interpolation syntax)

  tags = {
    Name = "${var.env}-automatic-sg" # Tag to identify this security group in the AWS console
    Environment = var.env
  }

  # Inbound rule — allows SSH access from anywhere on port 22
  ingress {
    from_port   = 22            # Start of port range (SSH)
    to_port     = 22            # End of port range (SSH)
    protocol    = "tcp"         # TCP protocol required for SSH
    cidr_blocks = ["0.0.0.0/0"] # Allow from any IP address (open to internet)
    description = "SSH port"    # Description of this rule
  }

  # Inbound rule — allows HTTP web traffic from anywhere on port 80
  ingress {
    from_port   = 80            # Start of port range (HTTP)
    to_port     = 80            # End of port range (HTTP)
    protocol    = "tcp"         # TCP protocol required for HTTP
    cidr_blocks = ["0.0.0.0/0"] # Allow from any IP address (open to internet)
    description = "Http port"   # Description of this rule
  }

  # Outbound rule — allows all outbound traffic (EC2 can reach the internet freely)
  egress {
    from_port   = 0             # 0 means all ports
    to_port     = 0             # 0 means all ports
    protocol    = "-1"          # -1 means all protocols (TCP, UDP, ICMP, etc.)
    cidr_blocks = ["0.0.0.0/0"] # Allow to any destination
    description = "All access"  # Description of this rule
  }
}

# Creates multiple EC2 instances using for_each — one instance per map entry
resource "aws_instance" "my-test" {
  #count = 2 # Alternative: Meta-argument that creates N identical instances (commented out)

  # for_each loops through a map — creates 5 instances with different instance types
  for_each = tomap({
    Ajay-micro = "t2.micro" # 1 vCPU, 1 GB RAM
    # Ajay-medium = "t2.medium" # 2 vCPUs, 4 GB RAM
    # Ajay-small  = "t2.small"  # 1 vCPU, 2 GB RAM
    # Ajay-nano   = "t2.nano"   # 1 vCPU, 0.5 GB RAM
    # Ajay-large  = "t2.large"  # 2 vCPUs, 8 GB RAM
  })

  # Ensures the key pair and security group are created before the instances
  depends_on = [aws_key_pair.my-key, aws_security_group.my_security_group]

  ami                         = var.ec2_ami_id                            # OS image to use (Amazon Linux 2)
  instance_type               = each.value                                # Hardware size — varies per instance (each.value is the map value)
  key_name                    = aws_key_pair.my-key.key_name              # SSH key pair to attach for login
  vpc_security_group_ids      = [aws_security_group.my_security_group.id] # Attach the security group created above
  user_data                   = file("install_nginx.sh")                  # Shell script to run on first boot (installs nginx)
  user_data_replace_on_change = true                                      # Recreate the instance if user_data script changes

  # Configure the root EBS disk
  root_block_device {
    volume_size = var.env == "prod" ? 20 : var.ec2_default_root_storage # Ternary: if env is "prod", use 20 GB, else use var value
    volume_type = "gp3"                                                 # General Purpose SSD v3 — better performance than gp2
  }

  tags = {
    Name        = each.key # Tag shown as the instance name in the AWS console (each.key is the map key)
    Environment = var.env
  }
}
