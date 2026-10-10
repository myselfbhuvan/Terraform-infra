output "Docker-instance1-public-ip" {
  value = aws_instance.Docker-ec2-1.public_ip
}

output "Docker-instance2-public-ip" {
  value = aws_instance.Docker-ec2-2.public_ip
}