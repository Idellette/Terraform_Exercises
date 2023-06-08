resource "aws_instance" "web_server" {
  instance_type = "t2.micro"
  ami           = var.ami_website
  tags          = {
    Name = var.instance_name
  }
}
