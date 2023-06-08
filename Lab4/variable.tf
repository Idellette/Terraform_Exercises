# variable de type chaine de caracteres
variable "image_id" {
  type = string
  default = "ami-055fc45692cb976ff"
}

# variable de type liste de chaines de caracteres
variable "availability_zones" {
  type        = list(string)
  default = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
}

# variable de type objet ou liste de cle=valeur
variable "tags_list" {
  type = map
  default = {
    Name = "Web Server"
    Environment = "Development"
    }
}

resource "aws_instance" "instance1" {
  instance_type = "t2.micro"
  ami           = var.image_id
  tags          = var.tags_list  
  availability_zone = var.availability_zones[0]
}
