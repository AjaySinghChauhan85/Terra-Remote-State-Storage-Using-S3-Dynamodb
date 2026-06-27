# Output block — values printed to terminal after "terraform apply" completes

# Outputs the public IP of each instance as a map (key = instance name, value = public IP)
# Public IPs are used to access the instance from the internet (e.g., via SSH or browser)
output "ec2_public_ip" {
  value = { for key, instance in aws_instance.my-test : key => instance.public_ip }
  # Iterates over all instances created by for_each and maps name -> public IP
}

# Outputs the public DNS hostname of each instance as a map
# Public DNS resolves to the public IP — can be used in place of IP for HTTP/SSH access
output "ec2_public_dns" {
  value = { for key, instance in aws_instance.my-test : key => instance.public_dns }
  # Iterates over all instances and maps name -> public DNS hostname
}

# Outputs the private IP of each instance as a map
# Private IPs are only accessible within the VPC — used for internal service communication
output "ec2_private_ip" {
  value = { for key, instance in aws_instance.my-test : key => instance.private_ip }
  # Iterates over all instances and maps name -> private IP
}

# Outputs the private DNS hostname of each instance as a map
# Private DNS is resolvable only within the VPC (e.g., ip-10-0-1-5.ec2.internal)
output "ec2_private_dns" {
  value = { for key, instance in aws_instance.my-test : key => instance.private_dns }
  # Iterates over all instances and maps name -> private DNS hostname
}
