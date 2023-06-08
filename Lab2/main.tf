provider "aws" {
  region = "eu-west-3"
}

resource "aws_instance" "instance2" {
  ami           = "ami-055fc45692cb976ff"
  instance_type = "t2.micro"
}
