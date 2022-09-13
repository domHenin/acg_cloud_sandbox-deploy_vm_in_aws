provider "aws" {}

resource "aws_vpc" "vpc_nginx" {
  cidr_block = var.vpc_cidr
  #   ipv6_cidr_block = var.ipv6_cidr

  tags = {
    "Name" = "nginx_VPC"
  }
}


resource "aws_security_group" "sg_nginx" {
  name        = "nginx_sg"
  description = "security group attached to nginx instance"
  vpc_id      = var.vpc_id


  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc_nginx.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    "Name" = var.sg_tag
  }
}

resource "aws_instance" "nginx_server" {
  ami             = var.ami_image
  instance_type   = var.instance_type
  subnet_id       = var.subnet_id
  security_groups = [aws_security_group.sg_nginx.id]


  tags = {
    Name = var.tags
  }
}