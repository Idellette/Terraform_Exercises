provider "aws" {
  region     = "eu-west-3"
}

resource "aws_vpc" "vpc_web" {
  cidr_block = "172.16.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "web"
  }
}

resource "aws_subnet" "subnet_web1" {
  vpc_id                  = aws_vpc.vpc_web.id
  cidr_block              = "172.16.10.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-west-3a"
  tags = {
    Name = "web"
  }
}

resource "aws_subnet" "subnet_web2" {
  vpc_id                  = aws_vpc.vpc_web.id
  cidr_block              = "172.16.20.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-west-3b"
  tags = {
    Name = "web"
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.vpc_web.id
  tags = {
    Name = "web"
  }
}

resource "aws_route" "route_web" {
  route_table_id          = aws_vpc.vpc_web.main_route_table_id
  destination_cidr_block  = "0.0.0.0/0"
  gateway_id              = aws_internet_gateway.default.id
}

resource "aws_instance" "web_serv_1" {
  ami = "ami-055fc45692cb976ff"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg_web.id]
  subnet_id              = aws_subnet.subnet_web1.id
  associate_public_ip_address = "true"
  tags = {
    Name = "web"
  }
}

resource "aws_instance" "web_serv_2" {
  ami = "ami-055fc45692cb976ff"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg_web.id]
  subnet_id              = aws_subnet.subnet_web2.id
  associate_public_ip_address = "true"
  tags = {
    Name = "web"
  }
}

resource "aws_security_group" "sg_web" {
  name = "sg_web"
  vpc_id = aws_vpc.vpc_web.id
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "web"
  }
}

# Elastic Load Balancer 
resource "aws_elb" "elb-web" {
  name = "elb-web"
  subnets = [aws_subnet.subnet_web1.id,aws_subnet.subnet_web2.id]
  security_groups = [aws_security_group.sg_elb.id]
  instances       = [aws_instance.web_serv_1.id, aws_instance.web_serv_2.id]
  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = 80
    instance_protocol = "http"
  }
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 5
    target = "TCP:80"
  }
  tags = {
    Name = "web"
  }
}

resource "aws_security_group" "sg_elb" {
  name = "sg_elb"
  vpc_id = aws_vpc.vpc_web.id
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "web"
  }
}
