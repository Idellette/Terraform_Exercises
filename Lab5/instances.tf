#    condition ? valeur_si_vrai : valeur_si_faux 
#    operateurs :  ==   !=   >   >=   <   <=   &&   ||   !

resource "aws_instance" "web_instance" {
  count         = var.create_instance ? 2 : 0
  subnet_id     = var.environment == "production" ? aws_subnet.prod_subnet.id : aws_subnet.dev_subnet.id
  instance_type = "t2.micro"
  ami           = "ami-0cfed801f3165b72c"
  tags          = {
    Name = "Web Server"
  }
}
