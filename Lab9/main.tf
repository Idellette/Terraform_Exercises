provider "aws" {
  region = "eu-west-3"
}

resource "aws_vpc" "web" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "web"
  }
}

resource "aws_subnet" "web" {
  vpc_id     = aws_vpc.web.id
  cidr_block = "10.0.1.0/24"
  
  availability_zone = "eu-west-3a"
  tags = {
    Name = "web"
  }
}

resource "aws_internet_gateway" "web" {
  vpc_id = aws_vpc.web.id

  tags = {
    Name = "web"
  }
}

resource "aws_route" "web" {
  route_table_id            = aws_vpc.web.default_route_table_id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.web.id
}

resource "aws_security_group" "web" {
  name        = "allow_web"
  description = "Allow web inbound traffic"
  vpc_id      = aws_vpc.web.id

  ingress {
    description = "web from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_web"
  }
}

resource "aws_instance" "web" {
  ami           = "ami-055fc45692cb976ff"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web.id]
  subnet_id = aws_subnet.web.id
  associate_public_ip_address = true

  tags = {
    Name = "web"
  }
}

resource "aws_eip" "web" {
  instance = aws_instance.web.id
  vpc      = true
}
