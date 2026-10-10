# Find the latest Amazon Linux 2023 AMI
data "aws_ssm_parameter" "al2023_ami" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

# SSH key used to access the EC2 instance
resource "aws_key_pair" "portfolio" {
  key_name   = "bhuvanesh-portfolio-key"
  public_key = file(pathexpand("~/.ssh/bhuvanesh-portfolio.pub"))
}

# Security group for the portfolio server
resource "aws_security_group" "portfolio" {
  name        = "bhuvanesh-portfolio-sg"
  description = "Security group for Bhuvanesh portfolio"
  vpc_id      = data.aws_vpc.default.id

  # Allow visitors to access the portfolio
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SSH only from my current IP
  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["14.195.132.38/32"]
  }

  # Allow the server to make outbound connections
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 server that will host the portfolio
resource "aws_instance" "portfolio" {
  ami                    = data.aws_ssm_parameter.al2023_ami.value
  instance_type          = var.instance_type
  subnet_id              = data.aws_subnet.portfolio.id
  key_name               = aws_key_pair.portfolio.key_name
  vpc_security_group_ids = [aws_security_group.portfolio.id]

  # Install Docker automatically when the server starts
  user_data = file("${path.module}/userdata.sh")

  tags = {
    Name = "bhuvanesh-portfolio"
  }
}
