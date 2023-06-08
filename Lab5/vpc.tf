resource "aws_subnet" "prod_subnet" {
  vpc_id                 = aws_vpc.prod_vpc.id
  cidr_block              = "192.168.1.0/24"
  availability_zone       = "eu-west-3a"
  tags = {
    Name = "prod_subnet"
  }
}

resource "aws_subnet" "dev_subnet" {
  vpc_id                 = aws_vpc.dev_vpc.id
  cidr_block              = "192.168.2.0/24"
  availability_zone       = "eu-west-3a"
  tags = {
    Name = "dev_subnet"
  }
}

resource "aws_vpc" "prod_vpc" {
  cidr_block           = "192.168.1.0/24"
  tags = {
    Name = "prod_vpc"
  }
}

resource "aws_vpc" "dev_vpc" {
  cidr_block           = "192.168.2.0/24"
  tags = {
    Name = "dev_vpc"
  }
}

