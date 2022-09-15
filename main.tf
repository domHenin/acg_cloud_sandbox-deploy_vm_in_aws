provider "aws" {}

resource "aws_vpc" "vpc_nginx" {
  cidr_block = var.vpc_cidr
  #   ipv6_cidr_block = var.ipv6_cidr

  tags = {
    "Name" = "nginx_VPC"
  }
}

# resource "aws_vpc" "vpc_nginx_personal" {
#   cidr_block = var.vpc_cidr_perso

#   tags = {
#     "Name" = "nginx_VPC-personal"
#   }
# }

resource "aws_subnet" "pub_sub" {
  # vpc_id     = aws_vpc.vpc_nginx
  # vpc_id     = aws_vpc.vpc_nginx_personal.id
  vpc_id = aws_vpc.vpc_nginx.id
  cidr_block = var.pub_cidr

  tags = {
    Name = var.sub_tag
  }
}


resource "aws_security_group" "sg_ssh_nginx" {
  name        = "nginx_sg_ssh"
  description = "security group created for ssh connection"
  vpc_id      = var.vpc_id
  # vpc_id = aws_vpc.vpc_nginx_personal.id


  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    "Name" = var.sg_ssh_tag
  }
}

resource "aws_security_group" "sg_https_nginx" {
  name        = "nginx_sg_https"
  description = "security group created for https connection"
  vpc_id      = var.vpc_id
  # vpc_id = aws_vpc.vpc_nginx_personal.id


  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    "Name" = var.sg_https_tag
  }
}


resource "aws_instance" "nginx_server" {
  ami           = var.ami_image
  instance_type = var.instance_type
  # subnet_id     = aws_subnet.pub_sub.id
  subnet_id       = var.subnet_id
  security_groups = [aws_security_group.sg_ssh_nginx.id, aws_security_group.sg_https_nginx.id]

  # user_data = file("./files/nginx_install.sh")
  user_data = file("./files/nginx_install.sh")

  # provisioner "file" {
  #   source = "./web/hello_world.html"
  #   destination = "/var/www/"
  # }


  tags = {
    Name = var.tags
  }
}