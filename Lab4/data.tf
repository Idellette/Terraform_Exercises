# donnees extraites de l'infrastructure aws
data "aws_ami" "image_web" {
  owners = ["self"]
  filter {
    name   = "tag:Tested"
    values = ["true"]
  }
  most_recent = true
}

resource "aws_instance" "instance2" {
  instance_type = "t2.micro"
  ami           = data.aws_ami.image_web.id
  tags          = {
    Name        = "Web Server"
  }
}
