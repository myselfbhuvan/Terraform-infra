#!/bin/bash

# Update the server packages
dnf update -y

# Install Docker
dnf install -y docker

# Start Docker and enable it after reboot
systemctl enable --now docker

# Allow ec2-user to run Docker without sudo
usermod -aG docker ec2-user
