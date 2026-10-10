resource "aws_vpc" "DockerVpc" {
  cidr_block = "11.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Strvpc"
  }
}

#Subnet-1
resource "aws_subnet" "Subnet1-Public" {
  vpc_id = aws_vpc.DockerVpc.id
  cidr_block = "11.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "Subnet1-Public"
  }
}

#Subnet-2
resource "aws_subnet" "Subnet2-Public" {
  vpc_id = aws_vpc.DockerVpc.id
  cidr_block = "11.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "Subnet2-Public"
  }
}

#Internetgateway
resource "aws_internet_gateway" "IGW" {
    vpc_id = aws_vpc.DockerVpc.id

    tags = {
      Name = "Strvpc-IGW"
    }
  
}

#Route Table
resource "aws_route_table" "DockerVpc-RT" {
  vpc_id = aws_vpc.DockerVpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }

  tags = {
    Name = "StrVpc-RT"



















  }
}

#Route Table Association with subnets
resource "aws_route_table_association" "rt-association-subnet1" {
  subnet_id = aws_subnet.Subnet1-Public.id
  route_table_id = aws_route_table.DockerVpc-RT.id
}

resource "aws_route_table_association" "rt-association-subnet2" {
    subnet_id = aws_subnet.Subnet2-Public.id
    route_table_id = aws_route_table.DockerVpc-RT.id
  
}