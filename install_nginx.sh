#!/bin/bash
# This script runs automatically on EC2 first boot via user_data

sudo yum update -y                                  # Update all installed packages to latest version
sudo amazon-linux-extras install nginx1 -y          # Install Nginx web server using Amazon Linux extras
sudo systemctl start nginx                          # Start the Nginx service immediately
sudo systemctl enable nginx                         # Enable Nginx to start automatically on every reboot
echo "<h1> Hello DevOps Engineers </h1>" | sudo tee /usr/share/nginx/html/index.html
# Replace the default Nginx welcome page with a custom HTML message
