variable "aws_region" {
  description = "AWS region where the portfolio server will be created"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type for the portfolio server"
  type        = string
  default     = "t3.micro"
}
