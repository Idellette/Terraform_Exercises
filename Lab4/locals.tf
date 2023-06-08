# donnees locales
locals {
  web_ami = "ami-0cfed801f3165b72c"
}

resource "aws_instance" "instance3" {
  instance_type = "t2.micro"
  ami           = local.web_ami
  tags          = {
    Name        = "Web Server"
  }
}

resource "aws_instance" "instance4" {
  instance_type = "t2.micro"
  ami           = local.web_ami
  tags          = {
    Name        = "Web Server"
  }
}
