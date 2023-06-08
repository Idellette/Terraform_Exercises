provider "aws" {
  region = "eu-west-3"
}

module "server_website1" {
  source = "./modules/aws-ec2-website" 

  ami_website = "ami-0cfed801f3165b72c"
  instance_name = "web-server1"
}

module "server_website2" {
  source = "./modules/aws-ec2-website" 

  ami_website = "ami-0cfed801f3165b72c"
  instance_name = "web-server2"
}

module "server_website3" {
  source = "./modules/aws-ec2-website"

}
