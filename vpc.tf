# Use the existing default VPC
data "aws_vpc" "default" {
  default = true
}

# Find the default subnet in an Availability Zone
# that supports our t3.micro instance.
data "aws_subnet" "portfolio" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  filter {
    name   = "availability-zone"
    values = ["us-east-1a"]
  }

  filter {
    name   = "default-for-az"
    values = ["true"]
  }
}
