resource "aws_instance" "web_server" {
  instance_type = "t2.micro"
  ami           = "ami-0cfed801f3165b72c"
  tags          = var.tags_list  
}

variable "tags_list" {
  type = map
  default = {
    Name = "Web Server"
    Environment = "Development"
    }
}

output "instance_ip_addr" {
  value       = aws_instance.web_server.public_ip
  description = "Adresse publique du Serveur Web."
}

output "instance_tags" {
  value       = aws_instance.web_server.tags
  description = "Liste des tags Serveur Web."
  depends_on  = [aws_instance.web_server]
}

