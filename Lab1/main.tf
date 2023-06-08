provider "aws" {
  region = "eu-west-3"
}

resource "aws_instance" "instance1" {
  ami           = "ami-055fc45692cb976ff"
  instance_type = "t2.micro"
  tags          = {
    Name        = "web_server"
  }
  security_groups = [
    "webserver",
  ]
}
