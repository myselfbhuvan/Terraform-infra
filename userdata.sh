#!/bin/bash
#update and Install docker as well as start docker
dnf update -y
dnf install -y docker
systemctl start docker
systemctl enable docker
usermod -aG docker ec2-user

