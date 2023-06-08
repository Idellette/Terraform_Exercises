provider "aws" {
  region  = "eu-west-3"
}

resource "aws_s3_bucket" "web_s3" {
  bucket = "s3-20201103"
}

resource "aws_default_vpc" "web_vpc" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_default_subnet" "web_subnet" {
  availability_zone = "eu-west-3a"
}

resource "aws_security_group" "web_sg" {
  name        = "webserver"
  description = "Acces HTTP"
}
